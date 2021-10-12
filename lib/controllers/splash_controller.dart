import 'dart:async';
import 'dart:io';
import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/care/careCategory_model.dart';
import 'package:brandcare_mobile_flutter_v2/providers/auth_provider.dart';
import 'package:brandcare_mobile_flutter_v2/providers/care_provider.dart';
import 'package:brandcare_mobile_flutter_v2/utils/FcmPushMgr.dart';
import 'package:brandcare_mobile_flutter_v2/utils/shared_token_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

import '../main.dart';
import 'global_controller.dart';

class SplashController extends BaseController {

  Duration splashTime = Duration(seconds: 3);
  final globalCtrl = Get.find<GlobalController>();

  void checkAppVersion() {
    String store = Platform.isAndroid ? 'Play스토어' : '앱스토어';
    Get.dialog(
      CustomDialogWidget(content: '새 버전이 있습니다.\n$store로 이동하시겠습니까?', onClick: (){
        Get.back();
      }, title: '업데이트', isSingleButton: false),
      barrierDismissible: false
    );
  }

  Future<void> chkGuidePage() async {
    final bool isGuide = await SharedTokenUtil.getBool('isGuide') ?? false;
    if(!isGuide){
      return Get.offAllNamed('/guide');
    }
    return;
  }

  Future<void> checkLogin() async {
    final bool isLogin = await SharedTokenUtil.getBool('isAutoLogin') ?? false;
    if(isLogin){
      final String? token = await SharedTokenUtil.getToken("userLogin_token");
      print(token);
      final res = await AuthProvider().loginToken(token!);
      print(res.toString());
      if(res != null){
        globalCtrl.isLoginChk(true);
        globalCtrl.addUserInfo(res);
        Get.offAllNamed('/mainPage');
      }else{
        //Get.dialog 후 loginController 사라지는 현상 수정
        Get.dialog(
          CustomDialogWidget(content: '세션이 만료되었습니다.\n 다시 로그인 해주세요.', onClick: (){
            Get.offAllNamed('/auth/login');
            update();
          }),
          barrierDismissible: false,
        );
      }
    }else{
      Get.offAllNamed('/auth/login');
    }
  }

  Future<void> careCategory()async{
    final res = await CareProvider().careCategory();
    if(res == null){
      Get.dialog(
          CustomDialogWidget(content: '서버와 접속이 원할 하지 않습니다.', onClick: (){
            Get.back();
            update();
          })
      );
    }else {
      print(res['data']);
      final list = (res['data'] as List).map((e) => CareCategoryModel.fromJson(e)).toList();
      for (var e in list) {
        globalCtrl.careCategory!.add(e);
      }
    }
    globalCtrl.update();
    update();
  }

  @override
  void onInit()async{
    FcmPushMgr().listenFCM();
    String fcmToken = await FcmPushMgr().regToken();
    globalCtrl.fcmToken = fcmToken;
    globalCtrl.update();
    super.onInit();
    await careCategory();
    await chkGuidePage();
    Timer(splashTime, ()async{
      //TODO: Check auto login
          await checkLogin();
    });
  }

  @override
  void onReady() {
    // checkAppVersion();
  }
}