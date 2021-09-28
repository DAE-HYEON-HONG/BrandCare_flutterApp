import 'dart:async';


import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/global_controller.dart';
import 'package:brandcare_mobile_flutter_v2/providers/auth_provider.dart';
import 'package:brandcare_mobile_flutter_v2/utils/regex_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

enum SignUpCheckEmail {
  NONE,
  DONE,
  DUPLICATE
}

class SignUpController extends BaseController {
  final globalCtrl = Get.find<GlobalController>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController authNumberController = TextEditingController();
  final TextEditingController friendCodeController = TextEditingController();

  Map<String, String> linkData = {
    '이용약관': '/main/my/term',
    '개인정보 취급방침': '/main/my/term'
  };

  Rx<bool> sendPhoneCode = false.obs;
  Rx<bool> authCode = false.obs;

  Rx<bool> agree = false.obs;
  Rx<bool> privacyAgree = false.obs;

  Rx<bool> isEmail = false.obs;
  Rx<String> emailTxt = ''.obs;
  Rx<SignUpCheckEmail> duplicateEmail = SignUpCheckEmail.NONE.obs;

  Rx<bool> isPhone = false.obs;
  Rx<String> phoneTxt = ''.obs;
  bool phoneChecked = false; // false로 꼭 바꿔주세요.
  String smsCode = '';

  Rx<bool> isAuthCode = false.obs;
  Rx<String> authCodeTxt = ''.obs;

  Rx<int> smsTime = 180.obs;

  Rx<bool> phoneReadOnly = false.obs;

  final _authApiProvider = AuthProvider();


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

  void chkDuplicateEmail(String email)async{
    super.networkState.value = NetworkStateEnum.LOADING;
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
        duplicateEmail.value = SignUpCheckEmail.DONE;
        update();
      }else {
        duplicateEmail.value = SignUpCheckEmail.DUPLICATE;
        update();
      }
    }
    super.networkState.value = NetworkStateEnum.NONE;
  }

  Future<void> registerChk() async{
    if(emailController.text == ""){
      Get.dialog(
          CustomDialogWidget(content: '이메일이 적혀있지 않습니다.', onClick: (){
            Get.back();
            update();
          }),
      );
    } else if(passwordController.text == "") {
      Get.dialog(
        CustomDialogWidget(content: '비밀번호를 입력해주세요.', onClick: (){
          Get.back();
        }),
      );
    }else if(!RegexUtil.checkPasswordRegex(password: passwordController.text)) {
      Get.dialog(
        CustomDialogWidget(content: '비밀번호 형식을 확인해주세요.', onClick: (){
          Get.back();
        }),
      );
    }else if(passwordController.text != rePasswordController.text){
      Get.dialog(
        CustomDialogWidget(content: '비밀번호가 일치하지 않습니다.', onClick: (){
          Get.back();
        }),
      );
    }
    else if(nameController.text.length > 8){
      Get.dialog(
        CustomDialogWidget(content: '닉네임은 8자리 이하로 입력해주세요.', onClick: (){
          Get.back();
        }),
      );
    }
    // else if(duplicateEmail.value == SignUpCheckEmail.DUPLICATE){
    //   Get.dialog(
    //     CustomDialogWidget(content: '이메일을 중복 및 확인해주세요.', onClick: (){
    //       Get.back();
    //       update();
    //     }),
    //   );
    // }
    else if(phoneController.text == ""){
      Get.dialog(
        CustomDialogWidget(content: '전화번호를 확인해주세요.', onClick: (){
          Get.back();
          update();
        }),
      );
    // } else if (phoneChecked == false) {
    } else if (authCode.value == false) {
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
      await addUser();
    }
  }

  Future<void> addUser() async{
    super.networkState.value = NetworkStateEnum.LOADING;
    final addUser = await _authApiProvider.registerUserEmail(
      friendCodeController.text,
      emailController.text,
      nameController.text,
      passwordController.text,
      phoneController.text,
      globalCtrl.fcmToken!,
    );
    super.networkState.value = NetworkStateEnum.DONE;
    // Get.back();
    Get.offAndToNamed('/auth/signup/complete');
  }

  Future<void> sendSms() async {
    if(phoneController.text.isEmpty) return null;
    if(!RegexUtil.checkPhoneRegex(phone: phoneController.text)) return null;
    var response = await _authApiProvider.smsAuth(phoneController.text);
    if(response != null) {
      sendPhoneCode.value = true;
      authCode.value = false;
      phoneReadOnly.value = false;
      smsCode = response["data"];
      checkSmsAuthTimer();
      update();
    }
  }

  checkAuthCode() {
    String code = authNumberController.text;
    if(smsTime.value == 0) {
      Get.dialog(
        CustomDialogWidget(content: '인증시간이 초과되었습니다.\n다시 시도 부탁드립니다.', onClick: (){
          Get.back();
        })
      );
    }
    if(code == smsCode){
      authCode.value = true;
      phoneReadOnly.value = true;
      update();
      return;
    }else {
      Get.dialog(
          CustomDialogWidget(content: '인증번호가 올바르지 않습니다.', onClick: (){
            Get.back();
          })
      );
    }
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

  bool get allAgree => agree.value && privacyAgree.value;

  @override
  void onInit() {
    super.onInit();
    debounce(emailTxt, (_) {
      isEmail.value = RegexUtil.checkEmailRegex(email: emailTxt.value);
    });
    debounce(phoneTxt, (_) {
      isPhone.value = RegexUtil.checkPhoneRegex(phone: phoneTxt.value);
    });
    debounce(authCodeTxt, (_) {
      print('autCode txt = $authCodeTxt');
      isAuthCode.value = RegexUtil.checkSMSCodeRegex(code: authCodeTxt.value);
      print('isAuthCode = ${isAuthCode.value}');
    });
  }
}