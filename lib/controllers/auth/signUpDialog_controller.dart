import 'dart:convert';
import 'dart:io';

import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/providers/auth_provider.dart';
import 'package:brandcare_mobile_flutter_v2/screens/auth/signup_dialog.dart';
import 'package:brandcare_mobile_flutter_v2/utils/shared_token_util.dart';
import 'package:flutter/material.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'package:get/get.dart';
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

import '../global_controller.dart';

class SignUpDialogController extends BaseController {
  final globalCtrl = Get.find<GlobalController>();
  RxBool isKakaoTalkInstalled = false.obs;

  void notLoginMain() {
    Get.offAllNamed('/mainPage');
  }

  void emailJoin(){
    Get.back();
    Get.toNamed('/auth/signup');
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
    }else if(type == "login_apple.svg"){
      _appleLogin();
    } else{
      await loginFacebook();
    }
  }

  //애플로 로그인
  _appleLogin() async {
    final credential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
    );
    print("유저 AuthCode : ${credential.authorizationCode}");
    print("유저 identityToken : ${credential.identityToken}");
    Map<String, dynamic> payload = JwtDecoder.decode(credential.identityToken!);
    print(payload);
    super.networkState.value = NetworkStateEnum.LOADING;
    final res = await AuthProvider().registerUserSocialChk(
      credential.userIdentifier.toString(),
      "",
      "APPLE",
      globalCtrl.fcmToken!,
    );
    Map<String, dynamic> jsonMap = jsonDecode(res!.body.toString());
    if(jsonMap['code'] == "R9721"){
      super.networkState.value = NetworkStateEnum.DONE;
      Get.toNamed(
        '/auth/signupSocial',
        arguments: {
          "TYPE": "APPLE",
          "Email" : payload['email'],
          "nickName" : "",
          "sub" : credential.userIdentifier.toString(),
          "fcm" : globalCtrl.fcmToken,
        },
      );
    }else{
      super.networkState.value = NetworkStateEnum.DONE;
      SharedTokenUtil.saveBool(false, 'isAutoLogin');
      SharedTokenUtil.saveToken(jsonMap['token']['token'], "userLogin_token");
      globalCtrl.isLoginChk(true);
      Get.offAllNamed('/mainPage');
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
    super.networkState.value = NetworkStateEnum.LOADING;
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
        globalCtrl.fcmToken!,
      );
      super.networkState.value = NetworkStateEnum.DONE;
      Map<String, dynamic> jsonMap = jsonDecode(res!.body.toString());
      if(jsonMap['code'] == "R9721"){
        Get.toNamed(
          '/auth/signupSocial',
          arguments: {
            "TYPE":"KAKAO",
            "Email" : user.kakaoAccount!.email,
            "nickName" : user.kakaoAccount!.profile!.nickname,
            "sub" : "",
            "fcm" : globalCtrl.fcmToken,
          },
        );
      }else{
        SharedTokenUtil.saveBool(false, 'isAutoLogin');
        SharedTokenUtil.saveToken(jsonMap['token']['token'], "userLogin_token");
        globalCtrl.isLoginChk(true);
        Get.offAllNamed('/mainPage');
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
      await FlutterNaverLogin.logOut();
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
        globalCtrl.fcmToken!,
      );
      Map<String, dynamic> jsonMap = jsonDecode(response!.body.toString());
      if(jsonMap['code'] == "R9721"){
        await FlutterNaverLogin.logOut();
        Get.toNamed(
          '/auth/signup/Social',
          arguments: {
            "TYPE":"NAVER",
            "Email" : res.account.email,
            "nickName" : res.account.nickname,
          },
        );
      }
    }catch(e){
      print(e.toString());
    }
  }

  //페이스북 로그인 부분
  Future<void> loginFacebook() async {
    try{
      final result = await FacebookAuth.instance.login(
        permissions: ['public_profile', 'email'],
      );
      final userData = await FacebookAuth.instance.getUserData();
      print(userData.toString());
      if(result.status == LoginStatus.success){
        final AccessToken  accessToken = result.accessToken!;
        print(accessToken.token);
        super.networkState.value = NetworkStateEnum.LOADING;
        final response = await AuthProvider().registerUserSocialChk(
          accessToken.token,
          userData['email'],
          "FACEBOOK",
          globalCtrl.fcmToken!,
        );
        Map<String, dynamic> jsonMap = jsonDecode(response!.body.toString());
        print(jsonMap.toString());
        if(jsonMap['code'] == "R9721"){
          super.networkState.value = NetworkStateEnum.DONE;
          Get.toNamed(
            '/auth/signupSocial',
            arguments: {
              "TYPE":"FACEBOOK",
              "Email" : userData['email'],
              "nickName" : userData['name'],
              "sub" : "",
              "fcm" : globalCtrl.fcmToken,
            },
          );
        }else{
          super.networkState.value = NetworkStateEnum.DONE;
          SharedTokenUtil.saveBool(false, 'isAutoLogin');
          SharedTokenUtil.saveToken(jsonMap['token']['token'], "userLogin_token");
          globalCtrl.isLoginChk(true);
          Get.offAllNamed('/mainPage');
        }
      }
    }catch(e){
      print(e.toString());
    }
  }

  void openSignUpDialog() {
    Get.dialog(
      SignUpDialog(),
    );
  }

  @override
  void onInit() {
    super.onInit();
    _initKakaoInit();
  }
}