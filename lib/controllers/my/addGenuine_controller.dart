import 'dart:async';

import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/global_controller.dart';
import 'package:brandcare_mobile_flutter_v2/providers/auth_provider.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/genuine/addGenuineEtc_page.dart';
import 'package:brandcare_mobile_flutter_v2/utils/regex_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddGenuineController extends BaseController {

  final globalCtrl = Get.find<GlobalController>();

  int productIdx = Get.arguments;

  Rx<int> smsTime = 180.obs;
  RxBool normalAddress = false.obs;

  TextEditingController senderName = TextEditingController();
  TextEditingController senderPhNum = TextEditingController();
  TextEditingController authNum = TextEditingController();
  RxBool senderPhNumFill = false.obs;
  RxBool authNumFill = false.obs;
  RxString senderPhTxt = "".obs;
  RxString authNumTxt = "".obs;
  String phAuth = "";
  RxBool phoneChecked = false.obs;

  TextEditingController senderPostCode = TextEditingController();
  TextEditingController senderAddress = TextEditingController();
  TextEditingController senderAddressDetailCtrl = TextEditingController();
  RxString senderAddressDetail = "".obs;
  RxBool senderNormalAddress = false.obs;
  RxBool saveSenderPostChk = false.obs;
  RxBool senderPostSet = false.obs;

  TextEditingController receiverName = TextEditingController();
  TextEditingController receiverPhNum = TextEditingController();

  RxBool samePost = false.obs;
  TextEditingController receiverPostCode = TextEditingController();
  TextEditingController receiverAddress = TextEditingController();
  TextEditingController receiverAddressDetailCtrl = TextEditingController();
  RxString receiverAddressDetail = "".obs;
  RxBool receiverNormalAddress = false.obs;
  RxBool saveReceiverPostChk = false.obs;
  RxBool receiverPostSet = false.obs;

  RxBool returnSender = true.obs;
  RxBool returnReceiver = false.obs;

  void chkNormalAddress() {
    if(globalCtrl.userInfoModel?.address!.city != "" &&
        globalCtrl.userInfoModel?.address!.street != "" &&
        globalCtrl.userInfoModel?.address!.zipCode != ""
    ){
      normalAddress.value = true;
      update();
    }else {
      normalAddress.value = false;
      update();
    }
  }

  Future<void> smsAuth() async {
    if(senderPhTxt.value == ""){
      Get.dialog(
        CustomDialogWidget(content: '전화번호가 입력되지 않았습니다.', onClick: (){
          Get.back();
          update();
        }),
      );
    }else{
      final res = await AuthProvider().smsAuth(senderPhTxt.value);
      if(res == null){
        Get.dialog(
          CustomDialogWidget(content: '서버와의 연결이 원할하지 않습니다.', onClick: (){
            Get.back();
            update();
          }),
        );
      }else{
        checkSmsAuthTimer();
        phAuth = res['data'];
        update();
      }
    }
  }

  void smsAuthChk() {
    if(phAuth == authNumTxt.value){
      phoneChecked.value = true;
    }else{
      Get.dialog(
        CustomDialogWidget(content: '인증번호가 올바르지 않습니다.', onClick: (){
          Get.back();
          update();
        }),
      );
      phoneChecked.value = false;
    }
    update();
  }

  checkSmsAuthTimer(){
    // Duration defaultDuration = Duration(minutes: 3);
    smsTime.value = 180;
    Timer.periodic(Duration(seconds: 1), (timer) {
      smsTime.value--;
      if(smsTime.value == 0){
        timer.cancel();
      }
    });
  }

  void senderNormalAddressSet() {
    senderNormalAddress.value = !senderNormalAddress.value;
    if(senderNormalAddress.value){
      senderPostCode.text = globalCtrl.userInfoModel!.address!.zipCode;
      senderAddress.text = globalCtrl.userInfoModel!.address!.city;
      senderAddressDetail.value = globalCtrl.userInfoModel!.address!.street;
      senderAddressDetailCtrl.text = globalCtrl.userInfoModel!.address!.street;
    }
    update();
  }

  void changeSenderPost(String postCode, String address){
    senderPostCode.text = postCode;
    senderAddress.text = address;
    update();
  }

  void senderPostSaveChk(){
    if(!senderNormalAddress.value) {
      if (senderPostCode.text != ""
          || senderAddress.text != ""
          || senderAddressDetail.value != "") {
        saveSenderPostChk.value = true;
        update();
      } else {
        saveSenderPostChk.value = false;
        update();
      }
    }
  }

  void senderPostSave() {
    if(receiverPostSet.value){
      receiverPostSet.value = false;
      update();
    }else{
      senderPostSet.value = !senderPostSet.value;
      update();
    }
  }

  void receiverSamePost() {
    samePost.value = !samePost.value;
    if(samePost.value){
      receiverName.text = senderName.text;
      receiverPhNum.text = senderPhNum.text;
      receiverPostCode.text = senderPostCode.text;
      receiverAddress.text = senderAddress.text;
      receiverAddressDetailCtrl.text = senderAddressDetailCtrl.text;
      receiverAddressDetail.value = senderAddressDetail.value;
    }
    update();
  }

  void receiverNormalAddressSet() {
    receiverNormalAddress.value = !receiverNormalAddress.value;
    if(receiverNormalAddress.value){
      receiverPostCode.text = globalCtrl.userInfoModel!.address!.zipCode;
      receiverAddress.text = globalCtrl.userInfoModel!.address!.city;
      receiverAddressDetail.value = globalCtrl.userInfoModel!.address!.street;
      receiverAddressDetailCtrl.text = globalCtrl.userInfoModel!.address!.street;
    }
    update();
  }

  void receiverPostSaveChk(){
    if (receiverPostCode.text != ""
        || receiverAddress.text != ""
        || receiverAddressDetail.value != ""){
      saveReceiverPostChk.value = true;
      update();
    }else{
      saveReceiverPostChk.value = false;
      update();
    }
  }

  void receiverPostSave() {
    if(senderPostSet.value){
      senderPostSet.value = false;
      update();
    }else{
      receiverPostSet.value = !receiverPostSet.value;
      update();
    }
  }

  void changeReceiverPost(String postCode, String address){
    receiverPostCode.text = postCode;
    receiverAddress.text = address;
    update();
  }

  void changeReturnPost(String person){
    if(person == "sender"){
      returnSender.value = true;
      returnReceiver.value = false;
    }else{
      returnSender.value = false;
      returnReceiver.value = true;
    }
    update();
  }



  void nextLevel(){
    if(senderName.text.isEmpty){
      Get.dialog(
        CustomDialogWidget(content: '보내는 분의 이름이 없습니다.', onClick: (){
          Get.back();
          update();
        }),
      );
    }else if(senderPhNum.text.isEmpty){
      Get.dialog(
        CustomDialogWidget(content: '보내는 분의 전화번호가 없습니다.', onClick: (){
          Get.back();
          update();
        }),
      );
    }else if(phoneChecked.value == false){
      Get.dialog(
        CustomDialogWidget(content: '인증번호가 확인되지 않았습니다.', onClick: (){
          Get.back();
          update();
        }),
      );
    }else if(senderPostCode.text.isEmpty){
      Get.dialog(
        CustomDialogWidget(content: '보내는 분의 주소가 올바르지 않습니다.', onClick: (){
          Get.back();
          update();
        }),
      );
    }else if(senderAddress.text.isEmpty){
      Get.dialog(
        CustomDialogWidget(content: '보내는 분의 주소가 올바르지 않습니다.', onClick: (){
          Get.back();
          update();
        }),
      );
    }else if(senderAddressDetailCtrl.text.isEmpty){
      Get.dialog(
        CustomDialogWidget(content: '보내는 분의 주소가 올바르지 않습니다.', onClick: (){
          Get.back();
          update();
        }),
      );
    }else if(receiverName.text.isEmpty){
      Get.dialog(
        CustomDialogWidget(content: '받는 분의 이름이 없습니다..', onClick: (){
          Get.back();
          update();
        }),
      );
    }else if(receiverPhNum.text.isEmpty){
      Get.dialog(
        CustomDialogWidget(content: '받는 분의 전화번호가 없습니다.', onClick: (){
          Get.back();
          update();
        }),
      );
    }else if(receiverPostCode.text.isEmpty){
      Get.dialog(
        CustomDialogWidget(content: '받는 분의 주소가 올바르지 않습니다.', onClick: (){
          Get.back();
          update();
        }),
      );
    }else if(receiverAddress.text.isEmpty){
      Get.dialog(
        CustomDialogWidget(content: '받는 분의 주소가 올바르지 않습니다.', onClick: (){
          Get.back();
          update();
        }),
      );
    }else if(receiverAddressDetailCtrl.text.isEmpty){
      Get.dialog(
        CustomDialogWidget(content: '받는 분의 주소가 올바르지 않습니다.', onClick: (){
          Get.back();
          update();
        }),
      );
    }else{
      Get.to(AddGenuineEtcPage());
    }
  }

  @override
  void onInit() {
    super.onInit();
    chkNormalAddress();
    debounce(senderPhTxt, (_) {
      senderPhNumFill.value = RegexUtil.checkPhoneRegex(phone: senderPhTxt.value);
    });
    debounce(authNumTxt, (_) {
      print('autCode txt = $authNumTxt');
      authNumFill.value = RegexUtil.checkSMSCodeRegex(code: authNumTxt.value);
      print('isAuthCode = ${authNumFill.value}');
    });
  }
}