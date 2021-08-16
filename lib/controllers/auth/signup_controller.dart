import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/utils/regex_util.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUpController extends BaseController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController authNumberController = TextEditingController();
  final TextEditingController friendCodeController = TextEditingController();

  Rx<bool> sendPhoneCode = false.obs;
  Rx<bool> authCode = false.obs;

  Rx<bool> agree = false.obs;
  Rx<bool> privacyAgree = false.obs;

  Rx<bool> isEmail = false.obs;
  Rx<String> emailTxt = ''.obs;

  Rx<bool> isPhone = false.obs;
  Rx<String> phoneTxt = ''.obs;

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
  }
}