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
import 'package:jwt_decoder/jwt_decoder.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'package:flutter_naver_login/flutter_naver_login.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class LoginController extends BaseController {

  final globalCtrl = Get.find<GlobalController>();

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  Rx<bool> isAutoLogin = false.obs;

  RxBool isKakaoTalk = false.obs;

  List<Map<String, String>> textList = [
    {
      '아이디 찾기': '/auth/find',
      'argument': "0",
    },
    {
      '비밀번호 찾기': '/auth/findpw',
      'argument' : "1",
    },
    { '회원가입': ''},
  ];

  // List snsLoginItem = ['login_kakao.svg', 'login_naver.svg', 'login_facebook.svg']; 페이스북 있는 버전
  List snsLoginItem = ['login_kakao.svg', 'login_naver.svg']; // 페이스북 없는 버전

  void changeAutoLogin() {
    isAutoLogin.value = !isAutoLogin.value;
    update();
  }

  void notLoginMain() {
    globalCtrl.isLoginChk(false);
    Get.offAllNamed('/mainPage');
  }

  void loginButton(String type)async{
    if(type == "login_kakao.svg"){
      await _initKakaoInit();
      if(isKakaoTalk.value){
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
      payload['email'],
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
      if(isAutoLogin.value){
        SharedTokenUtil.saveBool(true, 'isAutoLogin');
        SharedTokenUtil.saveToken(jsonMap['token']['token'], "userLogin_token");
        globalCtrl.isLoginChk(true);
        Get.offAllNamed('/mainPage');
      }else{
        SharedTokenUtil.saveBool(false, 'isAutoLogin');
        SharedTokenUtil.saveToken(jsonMap['token']['token'], "userLogin_token");
        globalCtrl.isLoginChk(true);
        Get.offAllNamed('/mainPage');
      }
    }
  }

  //키키오 설치 확인 로직
  _initKakaoInit() async {
    final installed = await isKakaoTalkInstalled();
    print('kakao 설치 : ${installed.toString()}');
    isKakaoTalk.value = installed;
    update();
  }

  //카카오 로그인 부분
  Future<void> issueAcessToken(String authCode) async {
    try{
      print("카카오로그인");
      var token = await AuthApi.instance.issueAccessToken(authCode);
      AccessTokenStore.instance.toStore(token);
      var user = await UserApi.instance.me();
      print("카카오 토큰값 ${token.accessToken}");
      print("카카오 토큰타입 ${token.tokenType}");
      print("카카오 토큰만료 ${token.expiresIn}");
      super.networkState.value = NetworkStateEnum.LOADING;
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
        if(isAutoLogin.value){
          SharedTokenUtil.saveBool(true, 'isAutoLogin');
          SharedTokenUtil.saveToken(jsonMap['token']['token'], "userLogin_token");
          globalCtrl.isLoginChk(true);
          Get.offAllNamed('/mainPage');
        }else{
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
  //카카오가 설치되어 있지 않았을때 로그인
  Future<void> loginWithKakao() async {
    try{
      print("카카오가 설치되어 있지 않았을때 로그인");
      var code = await AuthCodeClient.instance.request();
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
      super.networkState.value = NetworkStateEnum.LOADING;
      final response = await AuthProvider().registerUserSocialChk(
        resAccess.accessToken,
        "${res.account.email}",
        "NAVER",
        globalCtrl.fcmToken!,
      );
      Map<String, dynamic> jsonMap = jsonDecode(response!.body.toString());
      print(jsonMap.toString());
      if(jsonMap['code'] == "R9721"){
        await FlutterNaverLogin.logOut();
        super.networkState.value = NetworkStateEnum.DONE;
        Get.toNamed(
            '/auth/signupSocial',
            arguments: {
              "TYPE":"NAVER",
              "Email" : res.account.email,
              "nickName" : res.account.nickname,
              "sub" : "",
              "fcm" : globalCtrl.fcmToken,
            },
        );
      }else{
        super.networkState.value = NetworkStateEnum.DONE;
        if(isAutoLogin.value){
          await FlutterNaverLogin.logOut();
          SharedTokenUtil.saveBool(true, 'isAutoLogin');
          SharedTokenUtil.saveToken(jsonMap['token']['token'], "userLogin_token");
          globalCtrl.isLoginChk(true);
          Get.offAllNamed('/mainPage');
        }else{
          await FlutterNaverLogin.logOut();
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
          if(isAutoLogin.value){
            SharedTokenUtil.saveBool(true, 'isAutoLogin');
            SharedTokenUtil.saveToken(jsonMap['token']['token'], "userLogin_token");
            globalCtrl.isLoginChk(true);
            Get.offAllNamed('/mainPage');
          }else{
            SharedTokenUtil.saveBool(false, 'isAutoLogin');
            SharedTokenUtil.saveToken(jsonMap['token']['token'], "userLogin_token");
            globalCtrl.isLoginChk(true);
            Get.offAllNamed('/mainPage');
          }
        }
      }
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
        final res = await AuthProvider().loginUser(
          emailController.text,
          passwordController.text,
          globalCtrl.fcmToken!,
        );
        Map<String, dynamic> jsonMap = jsonDecode(res!.body.toString());
        print(jsonMap.toString());
        //아에 계정이 없을떄;;
        if(jsonMap['code'] == "U002") {
          Get.dialog(
            CustomDialogWidget(content: '이메일 또는 비밀번호를 확인해주세요.', onClick: (){
              Get.back();
              update();
            }),
          );
          super.networkState.value = NetworkStateEnum.DONE;
          return;
        }
        if(jsonMap['code'] == "U003"){
          Get.dialog(
            CustomDialogWidget(content: '이메일 또는 비밀번호를 확인해주세요.', onClick: (){
              Get.back();
              update();
            }),
          );
          super.networkState.value = NetworkStateEnum.DONE;
        } else  if(jsonMap['code'] == "CP001"){
          Get.dialog(
            CustomDialogWidget(content: '탈퇴한 회원입니다.', onClick: (){
              Get.back();
              update();
            }),
          );
          super.networkState.value = NetworkStateEnum.DONE;
        }
        else{
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