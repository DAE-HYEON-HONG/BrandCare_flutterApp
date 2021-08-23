import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainAddCareController extends BaseController {

  TextEditingController senderName = TextEditingController();
  TextEditingController senderPhNum = TextEditingController();
  TextEditingController authNum = TextEditingController();

  TextEditingController senderPostCode = TextEditingController();
  TextEditingController senderAddress = TextEditingController();
  TextEditingController senderAddressDetail = TextEditingController();
  RxBool saveSenderPost = false.obs;
  RxBool saveSenderPostChk = false.obs;

  TextEditingController receiverName = TextEditingController();
  TextEditingController receiverPhNum = TextEditingController();

  RxBool samePost = false.obs;
  TextEditingController receiverPostCode = TextEditingController();
  TextEditingController receiverAddress = TextEditingController();
  TextEditingController receiverAddressDetail = TextEditingController();
  RxBool saveReceiverPost = false.obs;
  RxBool saveReceiverPostChk = false.obs;

  // RxString senderPostCode = "10587".obs;
  // RxString senderAddress = "경기도 고양시 덕양구 덕수천 1로 37".obs;

  void changeSenderPost(String postCode, String address){
    senderPostCode.text = postCode;
    senderAddress.text = address;
    update();
  }

  void senderPostSaveChk(){
    if (senderPostCode.text != ""
        || senderAddress.text != ""
        || senderAddressDetail.text != ""){
      saveSenderPost.value = true;
      update();
    }else{
      saveSenderPost.value = false;
      update();
    }
  }

  void receiverPostSaveChk(){
    if (receiverPostCode.text != ""
        || receiverAddress.text != ""
        || receiverAddressDetail.text != ""){
      saveReceiverPost.value = true;
      update();
    }else{
      saveReceiverPost.value = false;
      update();
    }
  }

  void changeReceiverPost(String postCode, String address){
    receiverPostCode.text = postCode;
    receiverAddress.text = address;
    update();
  }

  void nextLevel(){
    Get.toNamed('/mainAddCare/add/pics');
  }

  @override
  void onInit() {
    super.onInit();
  }
}