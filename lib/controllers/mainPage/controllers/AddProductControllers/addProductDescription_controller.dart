import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddProductDescriptionController extends BaseController{

  TextEditingController desBody = TextEditingController();

  RxBool dirty = false.obs;
  RxBool broken = false.obs;
  RxBool nothing = false.obs;
  RxBool dustBag = false.obs;
  RxBool guarantee = false.obs;
  RxBool notExist = false.obs;

  bool isCondition = false;
  bool products = false;
  bool description = false;

  RxBool fill = false.obs;

  void choiceChk(String title){
    if(title == "오염"){
      dirty.value = !dirty.value;
    }else if(title == "파손"){
      broken.value = !broken.value;
    }else if(title == "문제 없음"){
      nothing.value = !nothing.value;
    }else if(title == "더스트백"){
      dustBag.value = !dustBag.value;
    }else if(title == "보증서"){
      guarantee.value = !guarantee.value;
    }else{
      notExist.value = !notExist.value;
    }
    formChk();
    update();
  }

  void formChk(){
    if(dirty.value && broken.value && nothing.value){
      this.isCondition = true;
    }else {
      this.isCondition = false;
    }

    if(dustBag.value && guarantee.value && notExist.value){
      this.products = true;
    }else {
      this.products = false;
    }

    if(desBody.text != ""){
      this.description = true;
    }else {
      this.description = false;
    }

    if(this.isCondition || this.products || this.description){
      fill.value = true;
    }else {
      fill.value = false;
    }
    update();
    return;
  }

  @override
  void onInit() {
    super.onInit();
  }
}