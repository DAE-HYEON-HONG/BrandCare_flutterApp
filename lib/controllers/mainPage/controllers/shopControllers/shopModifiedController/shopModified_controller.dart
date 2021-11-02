import 'package:brandcare_mobile_flutter_v2/apis/base_api_service.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/shopControllers/shopDetail/shopDetail_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/mypage/product/myProduct_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/paging_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/shop/addProductShop_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/shop/modProductShop_model.dart';
import 'package:brandcare_mobile_flutter_v2/providers/my_provider.dart';
import 'package:brandcare_mobile_flutter_v2/providers/shop_provider.dart';
import 'package:brandcare_mobile_flutter_v2/utils/shared_token_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:math';

import '../mainShop_controller.dart';

class ShopModifiedController extends BaseController{

  late TextEditingController titleCtrl;
  late TextEditingController priceCtrl;
  late TextEditingController bodyCtrl;
  Rx<bool> fill = true.obs;
  Rx<bool> categoryModel = false.obs;
  MainShopController mainShopCtrl = Get.find<MainShopController>();
  final shopDetailController = Get.find<ShopDetailController>();

  late Paging productListPaging;
  List<MyProduct> myProductList = <MyProduct>[];
  ScrollController pagingScroll = ScrollController();
  int currentPage = 1;
  int? currentIdx;
  RxString sort = "LATEST".obs;

  final ImagePicker imgPicker = ImagePicker();
  dynamic imgPickerErr;
  RxList<File>? pickImgList = <File>[].obs;

  double autoHeight (BuildContext context){
    double height = MediaQuery.of(context).viewInsets.bottom == 0 ? 0 : 200;
    return height;
  }

  Future<void> loadAssets(ImageSource source) async {
    try{
      if(source == ImageSource.camera){
        final pickedFile = await imgPicker.pickImage(
          source: source,
          maxWidth: 500,
          maxHeight: 500,
          imageQuality: 100,
          preferredCameraDevice: CameraDevice.rear,
        );
        pickImgList!.add(File(pickedFile!.path));
        Get.back();
        update();
      }else{
        final pickedFileList = await imgPicker.pickMultiImage(
          maxWidth: 500,
          maxHeight: 500,
          imageQuality: 100,
        );
        for(var file in pickedFileList!){
          pickImgList!.add(File(file.path));
        }
        Get.back();
        update();
      }
    }catch(e){
      imgPickerErr = e;
      update();
    }
  }

  void removePics({dynamic obj}) {
    pickImgList!.remove(obj);
    update();
  }

  Future<void>_cameraPermission() async {
    if(await Permission.photos.request().isDenied){
      print("카메라 권한 거부");
      Get.back();
    }else{
      print("카메라 및 갤러리 권한 허용됨");
    }
  }

  void chkForm(BuildContext context) async{
    print("거래등록 폼 체크");
    if(titleCtrl.text == ""){
      customDialogShow(title: "제목이 입력되지 않았습니다.", context: context);
      return;
    }
    if(priceCtrl.text == ""){
      customDialogShow(title: "가격이 입력되지 않았습니다.", context: context);
      return;
    }
    if(bodyCtrl.text == ""){
      customDialogShow(title: "내용이 입력되지 않았습니다.",context: context);
      return;
    }
    reallyAdd();
  }

  void reallyAdd(){
    Get.dialog(
      CustomDialogWidget(
        title: '알림',
        content: '수정 하시겠습니까?',
        onClick: ()async{
          await uploadAddProduct();
        },
        onCancelClick: () {
          Get.back();
        },
        isSingleButton: false,
        okTxt: "확인",
        cancelTxt: "취소",
      ),
    );
  }

  void chkField() {
    if(titleCtrl.text != "" && priceCtrl.text != "" && bodyCtrl.text != ""){
      this.fill.value = true;
    }
  }

  void customDialogShow({required String title, required BuildContext context}){
    showDialog(context: context, builder: (_) {
      return CustomDialogWidget(
        content: title,
        onClick: () => Get.back(),
        okTxt: "확인",
        isSingleButton: true,
      );
    });
  }



  Future<void> uploadAddProduct() async{
    if(fill.value){
      fill.value = false;
      final String? token = await SharedTokenUtil.getToken("userLogin_token");
      super.networkState = NetworkStateEnum.LOADING.obs;
      ModProductShopModel model = ModProductShopModel(
        title: titleCtrl.text,
        productIdx: shopDetailController.modModel!.productId,
        price: int.parse(priceCtrl.text.replaceAll(',', '')),
        content: bodyCtrl.text,
        pictures: pickImgList!,
        id: shopDetailController.idx.toString(),

      );
      final res = await ShopProvider().modShopProduct(token: token!, model: model);
      super.networkState = NetworkStateEnum.DONE.obs;
      fill.value = true;
      if(res == null){
        Get.dialog(
          CustomDialogWidget(content: '서버와 접속이 원할 하지 않습니다.', onClick: (){
            Get.back();
            update();
          }),
        );
      }else{
        print(res['data']);
        if(res['data'] == "Y"){
          Get.dialog(
            CustomDialogWidget(content: '수정되었습니다.', onClick: ()async{
              Get.back();
              Get.back();
              Get.back();
              Get.back();
              if(mainShopCtrl.currentPageIdx == 0){
                await mainShopCtrl.shopListAllCtrl.reqShopList();
              }else if(mainShopCtrl.currentPageIdx == 1){
                await mainShopCtrl.shopListMineCtrl.reqShopList();
              }else{
                await mainShopCtrl.shopListInstCtrl.reqShopList();
              }
              update();
            }),
            barrierDismissible: false,
          );
        }
      }
    }
  }

  void changeProductIdx(int idx){
    shopDetailController.idx = idx;
    print("idx");
    update();
  }

  void currentListIdx(int idx){
    currentIdx = idx;
    update();
  }

  void pagingScrollListener() async {
    if(pagingScroll.position.pixels == pagingScroll.position.maxScrollExtent){
      print("스크롤이 최하단입니다. 다시 로딩합니다.");
      if (productListPaging.totalCount != myProductList.length) {
        this.currentPage++;
        await reqProductList();
      }
    }
  }

  Future<void> reqProductList() async {
    final String? token = await SharedTokenUtil.getToken("userLogin_token");
    final res =  await MyProvider().productList(token!, currentPage, sort.value);
    if(res == null){
      Get.dialog(
          CustomDialogWidget(content: '서버와 접속이 원할 하지 않습니다.', onClick: (){
            Get.back();
            update();
          })
      );
    }else{
      print(res['list']);
      myProductList = (res['list'] as List).map((e) => MyProduct.fromJson(e)).toList();
      productListPaging = Paging.fromJson(res);
      update();
    }
  }

  void cameraPermissionChk()async{
    var _cameraStatus = await Permission.camera.status.isGranted;
    var _galleryStatus = await Permission.photos.isGranted;
    if(_cameraStatus == false || _galleryStatus == false){
      Get.snackbar(
        '권한 알림', '카메라 및 갤러리 권한이 필요합니다.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(milliseconds: 900),
      );
      Get.back();
    }
  }

  void initiateTextData(){
    titleCtrl = TextEditingController(text: shopDetailController.modModel!.title);
    priceCtrl = TextEditingController(text: shopDetailController.modModel!.price.toString());
    bodyCtrl = TextEditingController(text: shopDetailController.modModel!.content);
  }

  Future<void> getImageListOnCache() async {
    try {
      var x = 0;
      if(shopDetailController.modModel!.leftImage != null){
        x++;
      }
      if(shopDetailController.modModel!.rightImage != null){
        x++;
      }
      if(shopDetailController.modModel!.frontImage != null){
        x++;
      }
      if(shopDetailController.modModel!.backImage != null){
        x++;
      }
      print(shopDetailController.modModel!.images.length);
      for (int i = 0; i < shopDetailController.modModel!.images.length - x; i++) {
        print('image url : ' + 'http://api.leadgo.oig.kr/api/brc/image?path=' + shopDetailController.modModel!.images[i].path!);
        File imageFileUrl = await urlToFile('http://api.leadgo.oig.kr/api/brc/image?path=' + shopDetailController.modModel!.images[i].path!);
        pickImgList!.add(imageFileUrl);
        // if(Platform.isAndroid){
        //   pickImgList!.add(File('/data/user/0/com.laonstory.brandcare/cache/' + shopDetailController.modModel!.images[i].path!.split('/').last));
        // }
        // else if(Platform.isIOS){
        //   pickImgList!.add(File('/private/var/mobile/Containers/Data/Application/3CC8E19F-7DA4-4A18-BBFE-01D5BCF67F16/tmp/' + shopDetailController.modModel!.images[i].path!.split('/').last));
        // }
        print(pickImgList![i]);
      }
    }
    catch (e){
      printError();
    }
  }

  Future<File> urlToFile(String imageUrl) async {
// generate random number.
    var rng = new Random();
// get temporary directory of device.
    Directory tempDir = await getTemporaryDirectory();
// get temporary path from temporary directory.
    String tempPath = tempDir.path;
// create a new file in temporary path with random file name.
    File file = new File('$tempPath'+ (rng.nextInt(100)).toString() +'.png');
// call http.get method and pass imageUrl into it to get response.
    http.Response response = await http.get(Uri.parse(imageUrl));
// write bodyBytes received in response to file.
    await file.writeAsBytes(response.bodyBytes);
// now return the file which is created with random name in
// temporary directory and image bytes from response is written to // that file.
    return file;
  }

  @override
  void onInit() async{

  // titleCtrl = TextEditingController();
    // priceCtrl = TextEditingController();
    // bodyCtrl = TextEditingController();
    getImageListOnCache();
    initiateTextData();
    cameraPermissionChk();
    await reqProductList();
    pagingScroll.addListener(pagingScrollListener);
    _cameraPermission();
    super.onInit();
  }
}