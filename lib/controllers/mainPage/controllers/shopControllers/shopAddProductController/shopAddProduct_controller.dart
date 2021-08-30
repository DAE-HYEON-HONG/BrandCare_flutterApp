import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/shop/addProductShop_model.dart';
import 'package:brandcare_mobile_flutter_v2/providers/shop_provider.dart';
import 'package:brandcare_mobile_flutter_v2/utils/shared_token_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';

class ShopAddProductController extends BaseController{

  TextEditingController titleCtrl = TextEditingController();
  TextEditingController priceCtrl = TextEditingController();
  TextEditingController bodyCtrl = TextEditingController();
  TextEditingController categoryCtrl = TextEditingController();
  Rx<bool> fill = false.obs;
  Rx<bool> categoryModel = false.obs;

  final ImagePicker imgPicker = ImagePicker();
  dynamic imgPickerErr;
  List<File>? pickImgList = <File>[];

  Future<void> loadAssets() async {
    try{
      final pickedFileList = await imgPicker.pickMultiImage(
        maxWidth: 500,
        maxHeight: 500,
        imageQuality: 10,
      );
      for(var file in pickedFileList!){
        pickImgList!.add(File(file.path));
      }
      update();
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
    // if(categoryCtrl.text == ""){
    //   customDialogShow(title: "제품이 선택되지 않았습니다.", context: context);
    //   return;
    // }
    if(priceCtrl.text == ""){
      customDialogShow(title: "가격이 입력되지 않았습니다.", context: context);
      return;
    }
    if(bodyCtrl.text == ""){
      customDialogShow(title: "내용이 입력되지 않았습니다.",context: context);
      return;
    }
    await uploadAddProduct();
  }

  void chkField() {
    if(titleCtrl.text != "" || categoryCtrl.text != "" || priceCtrl.text != "" || bodyCtrl.text != ""){
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
    final String? token = await SharedTokenUtil.getToken("userLogin_token");
    AddProductShopModel model = AddProductShopModel(
      title: titleCtrl.text,
      productIdx: 2,
      price: int.parse(priceCtrl.text),
      content: bodyCtrl.text,
      pictures: pickImgList!,
    );
    final res = await ShopProvider().addShopProduct(token: token!, model: model);
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
          CustomDialogWidget(content: '등록되었습니다.', onClick: (){
            Get.back();
            update();
          }),
        );
      }
    }
  }

  @override
  void onInit() {
    _cameraPermission();
    super.onInit();
  }
}