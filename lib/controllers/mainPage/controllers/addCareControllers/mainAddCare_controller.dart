import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/providers/auth_provider.dart';
import 'package:brandcare_mobile_flutter_v2/utils/regex_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainAddCareController extends BaseController {

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
    debounce(senderPhTxt, (_) {
      senderPhNumFill.value = RegexUtil.checkPhoneRegex(phone: senderPhTxt.value);
    });
  }
}