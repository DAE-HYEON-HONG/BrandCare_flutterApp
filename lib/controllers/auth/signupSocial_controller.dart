import 'dart:async';

import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/providers/auth_provider.dart';
import 'package:brandcare_mobile_flutter_v2/utils/regex_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUpSocialController extends BaseController {

  Rx<int> smsTime = 180.obs;

  Timer? _timer;

  final TextEditingController emailController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController authNumberController = TextEditingController();
  final TextEditingController friendCodeController = TextEditingController();
  final String socialType = Get.arguments['TYPE'];
  String? sub;
  String? fcm;

  bool duplicateNumber = false;
  Rx<bool> sendPhoneCode = false.obs;
  Rx<bool> authCode = false.obs;
  RxString authNumTxt = "".obs;

  Rx<bool> agree = false.obs;
  Rx<bool> privacyAgree = false.obs;

  Rx<bool> isEmail = false.obs;
  Rx<String> emailTxt = ''.obs;
  RxBool duplicateEmail = false.obs;

  Rx<bool> isPhone = false.obs;
  Rx<bool> isAuthCode = false.obs;
  Rx<String> phoneTxt = ''.obs;
  RxBool phoneChecked = false.obs; // false로 꼭 바꿔주세요.


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
    print("fcm ${Get.arguments['fcm']}");
    sub = Get.arguments['sub'];
    fcm = Get.arguments['fcm'];
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

  Future<void> registerChk(String type, context) async{
    FocusScope.of(context).unfocus();
    if(emailController.text == ""){
      Get.dialog(
          CustomDialogWidget(content: '이메일이 적혀있지 않습니다.', onClick: (){
            Get.back();
            update();
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
    // else if(!duplicateEmail.value){
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
      if(duplicateNumber == true){
        Get.dialog(
          CustomDialogWidget(
            title: '중복된 추천인 코드',
            content: '이미 친구 초대코드를 사용하셨어요.\n회원가입 시 쿠폰 및 포인트가 적립되지 않아요.',
            onClick: ()async{
              await addUser(type);
            },
            onCancelClick: () {
              Get.back();
            },
            isSingleButton: false,
            okTxt: "예",
            cancelTxt: "아니오",
          ),
        );
      }else{
        await addUser(type);
      }
    }
  }

  Future<void> addUser(String type) async{
    print(fcm);
    super.networkState.value = NetworkStateEnum.LOADING;
    final addUser = await AuthProvider().registerUserSocial(
      friendCodeController.text,
      emailController.text,
      nameController.text,
      phoneTxt.value,
      type,
      sub!,
      fcm!
    );
    super.networkState.value = NetworkStateEnum.DONE;
    Get.offAndToNamed('/auth/signup/complete');
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
      final res = await AuthProvider().phoneChkAuth(phoneTxt.value);
      if(res == null){
        Get.dialog(
          CustomDialogWidget(content: '서버와의 연결이 원할하지 않습니다.', onClick: (){
            Get.back();
            update();
          }),
        );
      }else if(res['code'] == "P002"){
        Get.dialog(
            CustomDialogWidget(content: '이미 가입된 전화번호입니다.\n다른 전화번호로 시도해주세요.', onClick: (){
              Get.back();
            })
        );
        if(_timer != null){
          _timer!.cancel();
        }
        smsTime.value = 180;
        update();
        return;
      }else{
        final response = await AuthProvider().smsAuth(phoneTxt.value);
        if(response == null){
          Get.dialog(
            CustomDialogWidget(content: '서버와의 연결이 원할하지 않습니다.', onClick: (){
              Get.back();
              update();
            }),
          );
          return;
        }
        sendPhoneCode.value = true;
        phoneChecked.value = false;
        authNumberController.text =  "";
        checkSmsAuthTimer();
        phAuth = response['data'];
        if(response['duplicate'] == "Y"){
          duplicateNumber = false;
        }else{
          duplicateNumber = true;
        }
        update();
      }
    }
  }

  void smsAuthChk() {
    if(phoneChecked.value == false){
      if(smsTime.value == 0) {
        Get.dialog(
            CustomDialogWidget(content: '인증시간이 초과되었습니다.\n다시 시도 부탁드립니다.', onClick: (){
              Get.back();
            })
        );
        return;
      }
      if(phAuth == authNumberController.text){
        phoneChecked.value = true;
        isPhone.value = true;
        update();
      }else{
        Get.dialog(
          CustomDialogWidget(content: '인증번호가 올바르지 않습니다.', onClick: (){
            Get.back();
            update();
          }),
        );
        phoneChecked.value = false;
        //isPhone.value = false;
        update();
      }
      update();
    }
  }

  checkSmsAuthTimer(){
    if(_timer != null){
      _timer!.cancel();
    }
    // Duration defaultDuration = Duration(minutes: 3);
    smsTime.value = 180;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      smsTime.value--;
      if(smsTime.value == 0){
        timer.cancel();
      }
    });
  }

  @override
  void onInit() {
    if(_timer != null){
      _timer!.cancel();
    }
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