import 'dart:async';
import 'dart:io';

import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class SplashController extends BaseController {

  Duration splashTime = Duration(seconds: 3);

  void checkAppVersion() {
    String store = Platform.isAndroid ? 'Play스토어' : '앱스토어';
    Get.dialog(
      CustomDialogWidget(content: '새 버전이 있습니다.\n$store로 이동하시겠습니까?', onClick: (){
        Get.back();
      }, title: '업데이트', isSingleButton: false),
      barrierDismissible: false
    );
  }

  @override
  void onInit(){
    super.onInit();

  //   Timer.periodic(splashTime, (timer) {
  //     //TODO: Check auto login
  //     // Get.offAllNamed('login');
  // });
  }

  @override
  void onReady() {
    checkAppVersion();
  }
}