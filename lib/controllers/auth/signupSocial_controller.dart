import 'dart:async';

import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/providers/auth_provider.dart';
import 'package:brandcare_mobile_flutter_v2/utils/regex_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUpSocialController extends BaseController {

  Rx<int> smsTime = 180.obs;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController authNumberController = TextEditingController();
  final TextEditingController friendCodeController = TextEditingController();

  Rx<bool> sendPhoneCode = false.obs;
  Rx<bool> authCode = false.obs;
  RxString authNumTxt = "".obs;

  Rx<bool> agree = false.obs;
  Rx<bool> privacyAgree = false.obs;

  Rx<bool> isEmail = false.obs;
  Rx<String> emailTxt = ''.obs;
  RxBool duplicateEmail = false.obs;

  Rx<bool> isPhone = false.obs;
  Rx<String> phoneTxt = ''.obs;
  bool phoneChecked = false; // false로 꼭 바꿔주세요.


  void agreeUpdate() {
    agree.value = !agree.value;
    update();
  }

  void privacyUpdate() {
    privacyAgree.value = !privacyAgree.value;
    update();
  }

  void allUpdate() {
    if(allAgree) {
      agree.value = false;
      privacyAgree.value = false;
      update();
      return;
    }
    agree.value = true;
    privacyAgree.value = true;
    update();
  }

  void setSocialProfile({String? email, String? name}){
    emailController.text = email ?? '';
    emailTxt.value = email ?? '';
    nameController.text = name ?? '';
  }

  void chkDuplicateEmail(String email)async{
    if(email == ""){
      Get.dialog(
          CustomDialogWidget(content: '이메일을 입력해주세요.', onClick: (){
            Get.back();
            update();
          })
      );
    }else{
      final chkEmail = await AuthProvider().chkDuplicateEmail(email);
      if (chkEmail == null){
        Get.dialog(
            CustomDialogWidget(content: '네트워크 연결에 실패하였습니다.', onClick: (){
              Get.back();
              update();
            })
        );
      }else if(chkEmail == "Y"){
        duplicateEmail.value = true;
        update();
      }else {
        duplicateEmail.value = false;
        Get.dialog(
            CustomDialogWidget(content: '중복되는 이메일입니다.', onClick: (){
              Get.back();
              update();
            })
        );
        update();
      }
    }
  }

  Future<void> registerChk(String type) async{
    if(emailController.text == ""){
      Get.dialog(
          CustomDialogWidget(content: '이메일이 적혀있지 않습니다.', onClick: (){
            Get.back();
            update();
          }),
      );
    } else if(!duplicateEmail.value){
      Get.dialog(
        CustomDialogWidget(content: '이메일을 중복 및 확인해주세요.', onClick: (){
          Get.back();
          update();
        }),
      );
    } else if(phoneController.text == ""){
      Get.dialog(
        CustomDialogWidget(content: '전화번호를 확인해주세요.', onClick: (){
          Get.back();
          update();
        }),
      );
    } else if (phoneChecked == false) {
      Get.dialog(
        CustomDialogWidget(content: '전화번호가 확인되지 않았습니다.', onClick: (){
          Get.back();
          update();
        }),
      );
    } else if(!allAgree){
      Get.dialog(
        CustomDialogWidget(content: '약관이 동의되지 않았습니다.', onClick: (){
          Get.back();
          update();
        }),
      );
    }else{
      await addUser(type);
    }
  }

  Future<void> addUser(String type) async{
    final addUser = await AuthProvider().registerUserSocial(
      friendCodeController.text,
      emailController.text,
      nameController.text,
      phoneController.text,
      type,
    );
    Get.back();
  }

  bool get allAgree => agree.value && privacyAgree.value;

  String phAuth = "";
  Future<void> smsAuth() async {
    if(phoneTxt.value == ""){
      Get.dialog(
        CustomDialogWidget(content: '전화번호가 입력되지 않았습니다.', onClick: (){
          Get.back();
          update();
        }),
      );
    }else{
      final res = await AuthProvider().smsAuth(phoneTxt.value);
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
    if(phAuth == authNumberController.text){
      phoneChecked = true;
      isPhone.value = true;
      update();
    }else{
      Get.dialog(
        CustomDialogWidget(content: '인증번호가 올바르지 않습니다.', onClick: (){
          Get.back();
          update();
        }),
      );
      phoneChecked = false;
      isPhone.value = false;
      update();
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

  @override
  void onInit() {
    super.onInit();
    setSocialProfile(
      email: Get.arguments?['Email'],
      name: Get.arguments?['nickName'],
    );
    debounce(emailTxt, (_) {
      isEmail.value = RegexUtil.checkEmailRegex(email: emailTxt.value);
    });
    debounce(phoneTxt, (_) {
      isPhone.value = RegexUtil.checkPhoneRegex(phone: phoneTxt.value);
    });
    debounce(authNumTxt, (_) {
      print('autCode txt = $authNumTxt');
      authCode.value = RegexUtil.checkSMSCodeRegex(code: authNumTxt.value);
      print('isAuthCode = ${authCode.value}');
    });
  }
}