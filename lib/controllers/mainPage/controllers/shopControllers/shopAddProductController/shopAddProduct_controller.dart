import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/shopControllers/shopDetail/shopDetail_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/mypage/product/myProduct_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/paging_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/shop/addProductShop_model.dart';
import 'package:brandcare_mobile_flutter_v2/providers/my_provider.dart';
import 'package:brandcare_mobile_flutter_v2/providers/shop_provider.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/main_page.dart';
import 'package:brandcare_mobile_flutter_v2/utils/shared_token_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

import '../mainShop_controller.dart';

class ShopAddProductController extends BaseController{

  MainPage mainPage = MainPage();
  late TextEditingController titleCtrl;
  late TextEditingController priceCtrl;
  late TextEditingController bodyCtrl;
  Rx<bool> fill = false.obs;
  Rx<bool> categoryModel = false.obs;
  MainShopController mainShopCtrl = Get.find<MainShopController>();

  late Paging productListPaging;
  List<MyProduct> myProductList = <MyProduct>[];
  ScrollController pagingScroll = ScrollController();
  int currentPage = 1;
  int? myProductIdx;
  int? currentIdx;
  RxString sort = "LATEST".obs;
  RxBool runningServer = false.obs;

  final ImagePicker imgPicker = ImagePicker();
  dynamic imgPickerErr;
  List<File>? pickImgList = <File>[];

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
    if(myProductIdx == null){
      customDialogShow(title: "제품이 선택되지 않았습니다.", context: context);
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
        content: '등록 하시겠습니까?',
        onClick: () async{
          Get.back();
          runningServer.value = true;
          super.networkState = NetworkStateEnum.LOADING.obs;
          DateTime now = DateTime.now();
          if(mainPage.currentBackPressTime == null ||
              now.difference(mainPage.currentBackPressTime!) > Duration(seconds: 2)){
            mainPage.currentBackPressTime = now;
            await uploadAddProduct();
          }
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
    if(titleCtrl.text != "" && myProductIdx != null && priceCtrl.text != "" && bodyCtrl.text != ""){
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
      AddProductShopModel model = AddProductShopModel(
        title: titleCtrl.text,
        productIdx: myProductIdx ?? 0,
        price: int.parse(priceCtrl.text.replaceAll(',', '')),
        content: bodyCtrl.text,
        pictures: pickImgList!,
      );
      final res = await ShopProvider().addShopProduct(token: token!, model: model);
      super.networkState = NetworkStateEnum.DONE.obs;
      fill.value = true;
      if(res == null){
        runningServer.value = false;
        Get.dialog(
          CustomDialogWidget(content: '서버와 접속이 원할 하지 않습니다.', onClick: (){
            Get.back();
            update();
          }),
        );
      }else{
        runningServer.value = false;
        print(res['data']);
        if(res['data'] == "Y"){
          Get.dialog(
            CustomDialogWidget(content: '등록되었습니다.', onClick: ()async{
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
    myProductIdx = idx;
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

  @override
  void onInit() async{
    titleCtrl = TextEditingController();
    priceCtrl = TextEditingController();
    bodyCtrl = TextEditingController();
    // titleCtrl = TextEditingController(text: shopDetailController.model!.title);
    // priceCtrl = TextEditingController(text: shopDetailController.model!.price.toString());
    // bodyCtrl = TextEditingController(text: shopDetailController.model!.content);
    cameraPermissionChk();
    await reqProductList();
    pagingScroll.addListener(pagingScrollListener);
    _cameraPermission();
    super.onInit();
  }
}