import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainAddProductController extends BaseController {

  TextEditingController titleCtrl = TextEditingController();
  TextEditingController categoryCtrl = TextEditingController();
  TextEditingController brandCtrl = TextEditingController();
  TextEditingController serialCtrl = TextEditingController();
  TextEditingController sinceBuyCtrl = TextEditingController();
  TextEditingController priceCtrl = TextEditingController();
  TextEditingController connectBuyCtrl = TextEditingController();

  RxBool nextBtn = false.obs;

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

  void nextBtnFill(){
    if (titleCtrl.text == "" || serialCtrl.text == "" || sinceBuyCtrl.text == "" || priceCtrl.text == "" || connectBuyCtrl.text == ""){
      nextBtn.value = false;
      update();
    }else {
      nextBtn.value = true;
      update();
    }
  }

  void nextBtnFunc(BuildContext context) {
    FocusScope.of(context).unfocus();
    Get.toNamed("/mainAddProduct/addImg");
  }

  @override
  void onInit() {
    super.onInit();
  }
}