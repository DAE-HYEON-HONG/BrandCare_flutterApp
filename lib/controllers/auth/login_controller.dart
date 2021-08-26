import 'dart:convert';
import 'dart:io';

import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/global_controller.dart';
import 'package:brandcare_mobile_flutter_v2/providers/auth_provider.dart';
import 'package:brandcare_mobile_flutter_v2/screens/auth/signup_dialog.dart';
import 'package:brandcare_mobile_flutter_v2/utils/shared_token_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';

class LoginController extends BaseController {

  final globalCtrl = Get.find<GlobalController>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Rx<bool> isAutoLogin = false.obs;

  RxBool isKakaoTalkInstalled = false.obs;

  List<Map<String, String>> textList = [{'아이디 찾기': '/auth/find'}, {'비밀번호 찾기': '/auth/find'}, { '회원가입': ''}];

  List snsLoginItem = ['login_kakao.svg', 'login_naver.svg', 'login_facebook.svg'];

  void changeAutoLogin() {
    isAutoLogin.value = !isAutoLogin.value;
    update();
  }

  void notLoginMain() {
    Get.offAllNamed('/mainPage');
  }

  void loginButton(String type)async{
    if(type == "login_kakao.svg"){
      if(isKakaoTalkInstalled.value){
        await loginWithTalk();
      }else{
        await loginWithKakao();
      }
    }else if(type == "login_naver.svg"){
      await loginNaver();
    }else{
      await loginFacebook();
    }
  }

  //키키오 설치 확인 로직
  _initKakaoInit() async {
    final installed = await isKakaoTalkInstalled();
    print('kakao 설치 : ${installed.toString()}');
    isKakaoTalkInstalled.value = installed;
    update();
  }

  //카카오 로그인 부분
  Future<void> issueAcessToken(String authCode) async {
    try{
      var token = await AuthApi.instance.issueAccessToken(authCode);
      AccessTokenStore.instance.toStore(token);
      var user = await UserApi.instance.me();
      print("카카오 토큰값 ${token.accessToken}");
      print("카카오 토큰타입 ${token.tokenType}");
      print("카카오 토큰만료 ${token.expiresIn}");
      final res = await AuthProvider().registerUserSocialChk(
        token.accessToken,
        "${user.kakaoAccount!.email}",
        "KAKAO",
      );
      Map<String, dynamic> jsonMap = jsonDecode(res!.body.toString());
      if(jsonMap['code'] == "R9721"){
        Get.toNamed(
          '/auth/signupSocial',
          arguments: {
            "TYPE":"KAKAO",
            "Email" : user.kakaoAccount!.email,
            "nickName" : user.kakaoAccount!.profile!.nickname,
          },
        );
      }else{
        if(isAutoLogin.value){
          SharedTokenUtil.saveBool(true, 'isAutoLogin');
          SharedTokenUtil.saveToken(jsonMap['token']['token'], "userLogin_token");
          globalCtrl.isLoginChk(true);
          Get.toNamed('/mainPage');
        }else{
          SharedTokenUtil.saveBool(false, 'isAutoLogin');
        }
      }
    }catch(e){
      print(e.toString());
    }
  }
  //카카오가 설치되어 있지 않았을때 로그인
  Future<void> loginWithKakao() async {
    try{
      print("카카오가 설치되어 있지 않았을때 로그인");
      var code = await AuthCodeClient.instance.request();
      print("카카오가 설치되어 있지 않았을때 로그인");
      print(code.toString());
      await issueAcessToken(code);
    }catch(e){
      print("카카오톡 웹뷰 에러");
      print(e.toString());
    }
  }
  //카카오가 설치되어 있을 때 로그인
  Future<void> loginWithTalk() async {
    try{
      print("카카오가 설치되어 있을 때 로그인");
      var code = await AuthCodeClient.instance.requestWithTalk();
      print("카카오가 설치되어 있을 때 로그인");
      print(code.toString());
      await issueAcessToken(code);
    }catch(e){
      print("카카오톡 설치되었지만 로그인 에러");
      print(e.toString());
      if(e.toString() == "PlatformException(NotSupportError, KakaoTalk is installed but not connected to Kakao account., null, null)"){
        loginWithKakao();
      }
    }
  }

  //네이버 로그인 부분
  Future<void> loginNaver() async {
    try{
      NaverLoginResult res = await FlutterNaverLogin.logIn();
      NaverAccessToken resAccess = await FlutterNaverLogin.currentAccessToken;
      print("네이버 로그인 상태 ${res.status}");
      print("네이버 로그인 엑세스 토큰 ${resAccess.accessToken}");
      print("네이버 로그인 이름 ${res.account.name}");
      print("네이버 로그인 닉네임 ${res.account.nickname}");
      print("네이버 로그인 ${res.account.email}");
      final response = await AuthProvider().registerUserSocialChk(
        resAccess.accessToken,
        "${res.account.email}",
        "NAVER",
      );
      Map<String, dynamic> jsonMap = jsonDecode(response!.body.toString());
      print(jsonMap.toString());
      if(jsonMap['code'] == "R9721"){
        Get.toNamed(
            '/auth/signupSocial',
            arguments: {
              "TYPE":"NAVER",
              "Email" : res.account.email,
              "nickName" : res.account.nickname,
            },
        );
      }else{
        if(isAutoLogin.value){
          SharedTokenUtil.saveBool(true, 'isAutoLogin');
          SharedTokenUtil.saveToken(jsonMap['token']['token'], "userLogin_token");
          globalCtrl.isLoginChk(true);
          Get.toNamed('/mainPage');
        }else{
          SharedTokenUtil.saveBool(false, 'isAutoLogin');
        }
      }
    }catch(e){
      print(e.toString());
    }
  }

  //페이스북 로그인 부분
  Future<void> loginFacebook() async {
    try{
      final result = await FacebookAuth.instance.login();
      print(result.toString());
    }catch(e){
      print(e.toString());
    }
  }

  //일반 로그인
  Future<void> login() async {
    if(emailController.text == ""){
      Get.dialog(
        CustomDialogWidget(content: '이메일을 입력해주세요.', onClick: (){
          Get.back();
          update();
        }),
      );
    }else if(passwordController.text == ""){
      Get.dialog(
        CustomDialogWidget(content: '비밀번호를 입력해주세요.', onClick: (){
          Get.back();
          update();
        }),
      );
    }else{
      try{
        super.networkState.value = NetworkStateEnum.LOADING;
        final res = await AuthProvider().loginUser(emailController.text, passwordController.text);
        Map<String, dynamic> jsonMap = jsonDecode(res!.body.toString());
        print(jsonMap.toString());
        if(jsonMap['code'] == "U003") {
          Get.dialog(
            CustomDialogWidget(content: '이메일 또는 비밀번호를 확인해주세요.', onClick: (){
              Get.back();
              update();
            }),
          );
        }else{
          if(isAutoLogin.value){
            SharedTokenUtil.saveBool(true, 'isAutoLogin');
            SharedTokenUtil.saveToken(jsonMap['token']['token'], "userLogin_token");
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
            SharedTokenUtil.saveBool(false, 'isAutoLogin');
            SharedTokenUtil.saveToken(jsonMap['token']['token'], "userLogin_token");
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
          }
        }
        super.networkState.value = NetworkStateEnum.DONE;
      }catch(e) {
        print(e);
        super.networkState.value = NetworkStateEnum.ERROR;
      }

    }
  }

  void openSignUpDialog() {
    Get.dialog(
      SignUpDialog(),
    );
  }

  // void getMe() async {
  //   super.networkState.value = NetworkStateEnum.LOADING;
  //   super.isShowLoading = false;
  //   try{
  //     Model model = await AuthProvider().getMe();
  //   }catch(Exception)
  //
  //   super.networkState.value = NetworkStateEnum.DONE;
  //
  // }

  @override
  void onInit() {
    super.onInit();
    if(Platform.isIOS) snsLoginItem.insert(0, 'login_apple.svg');
    _initKakaoInit();
  }
}