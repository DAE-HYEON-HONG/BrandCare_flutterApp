import 'dart:io';

import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/screens/auth/signup_dialog.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class LoginController extends BaseController {

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Rx<bool> isAutoLogin = false.obs;

  List<Map<String, String>> textList = [{'아이디 찾기': '/auth/find'}, {'비밀번호 찾기': '/auth/find'}, { '회원가입': ''}];

  List snsLoginItem = ['login_kakao.svg', 'login_naver.svg', 'login_facebook.svg'];

  void changeAutoLogin() {
    isAutoLogin.value = !isAutoLogin.value;
    update();
  }

  void openSignUpDialog() {
    Get.dialog(
      SignUpDialog(),
    );
  }

  @override
  void onInit() {
    super.onInit();
    if(Platform.isIOS) snsLoginItem.insert(0, 'login_apple.svg');

  }


}