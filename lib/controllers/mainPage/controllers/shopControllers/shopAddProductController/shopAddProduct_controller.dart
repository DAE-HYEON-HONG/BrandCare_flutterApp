import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ShopAddProductController extends BaseController{

  TextEditingController titleCtrl = TextEditingController();
  TextEditingController priceCtrl = TextEditingController();
  TextEditingController bodyCtrl = TextEditingController();
  TextEditingController categoryCtrl = TextEditingController();
  Rx<bool> fill = false.obs;
  Rx<bool> categoryModel = false.obs;

  final ImagePicker imgPicker = ImagePicker();
  dynamic imgPickerErr;
  List<XFile>? pickImgList = <XFile>[];

  Future<void> loadAssets() async {
    try{
      final pickedFileList = await imgPicker.pickMultiImage(
        maxWidth: 500,
        maxHeight: 500,
        imageQuality: 10,
      );
      pickImgList = pickedFileList;
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

  void chkForm(BuildContext context) {
    print("거래등록 폼 체크");
    if(titleCtrl.text == ""){
      customDialogShow(title: "제목이 입력되지 않았습니다.", context: context);
      return;
    }
    if(categoryCtrl.text == ""){
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

  @override
  void onInit() {
    _cameraPermission();
    super.onInit();
  }
}