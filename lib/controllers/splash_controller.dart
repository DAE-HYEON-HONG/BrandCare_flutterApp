import 'dart:async';
import 'dart:io';
import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/providers/auth_provider.dart';
import 'package:brandcare_mobile_flutter_v2/utils/shared_token_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:get/get.dart';

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

  void checkLogin() async {
    final bool isLogin = await SharedTokenUtil.getBool('isAutoLogin') ?? false;
    if(isLogin){
      final String? token = await SharedTokenUtil.getToken("userLogin_token");
      final res = await AuthProvider().loginToken(token!);
      if(res != null){
        globalCtrl.isLoginChk(true);
        globalCtrl.addUserInfo(res);
        Get.offAllNamed('/mainPage');
      }else{
        Get.offAllNamed('/auth/login');
        Get.dialog(
          CustomDialogWidget(content: '이메일 또는 비밀번호를 확인해주세요.', onClick: (){
            Get.back();
            update();
          }),
        );
      }
    }else{
      Get.offAllNamed('/auth/login');
    }
  }

  @override
  void onInit(){
    super.onInit();
    Timer(splashTime, (){
      //TODO: Check auto login
          checkLogin();
    });
  }

  @override
  void onReady() {
    // checkAppVersion();
  }
}