import 'dart:async';

import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/providers/auth_provider.dart';
import 'package:brandcare_mobile_flutter_v2/utils/auth_format_util.dart';
import 'package:brandcare_mobile_flutter_v2/utils/regex_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum FindIdStateEnum { NONE, FIND_ALL_ID, DONE }

enum FindPwStateEnum { NONE, AUTH, DONE }

class FindController extends BaseController with SingleGetTickerProviderMixin {
   TextEditingController emailController = TextEditingController();
   TextEditingController phoneController = TextEditingController();
   TextEditingController authCodeController = TextEditingController();
   TextEditingController pwController = TextEditingController();
   TextEditingController rePwController = TextEditingController();

   Timer? _timer;
   Rx<int> smsTime = 180.obs;

  int currentIndex = 0;
  String phone = '';
  String authCode = '';
  String email = "";

  bool isAuth = false;
  bool isPwAuth = false;

  Rx<bool> isPhone = false.obs;
  Rx<String> phoneTxt = ''.obs;

  Rx<bool> isCode = false.obs;
  Rx<String> codeTxt = ''.obs;

  Rx<bool> enableButton = false.obs;

   Rx<String> pwTxt = ''.obs;
   Rx<String> rePwTxt = ''.obs;
   Rx<bool> isPwCheck = false.obs;

  Rx<FindIdStateEnum> idState = FindIdStateEnum.NONE.obs;
  Rx<FindPwStateEnum> pwState = FindPwStateEnum.NONE.obs;

  int nowTab = int.parse(Get.arguments);

  late TabController tabController;

  changeCurrentIndex({required int index}) {
    currentIndex = index;
    update();
  }

   double autoHeight (BuildContext context){
     double height = MediaQuery.of(context).viewInsets.bottom == 0 ? 0 : 300;
     return height;
   }

  Future<void> reqSecureFindId() async{
    try{
      super.networkState.value = NetworkStateEnum.LOADING;
      final res = await AuthProvider().findId(phoneController.text);
      if(res == null){
        super.networkState.value = NetworkStateEnum.DONE;
        Get.dialog(
            CustomDialogWidget(content: '서버와 접속이 원할 하지 않습니다.', onClick: (){
              Get.back();
              update();
            })
        );
      }else{
        super.networkState.value = NetworkStateEnum.DONE;
        if(res['code'] == "U001") {
          Get.dialog(
              CustomDialogWidget(content: '해당 유저를 찾을 수 없습니다.', onClick: () {
                Get.back();
                update();
              })
          );
        }else{
          super.networkState.value = NetworkStateEnum.DONE;
          email = res['data'];
          Get.dialog(CustomDialogWidget(
            content: '${AuthFormatUtil.secureEmail(res['data'])}\n\n휴대전화 번호 인증을 하시면\n전체 아이디를 확인 하실 수 있습니다.\n인증을 진행하시겠습니까?',
            title: '아이디 찾기 안내\n',
            isSingleButton: false,
            onClick: () async{
              idState.value = FindIdStateEnum.FIND_ALL_ID;
              enableButton.value = false;
              await smsAuth();
              update();
              Get.back();
            },
          ));
        }
        super.networkState.value = NetworkStateEnum.DONE;
        update();
      }
    }catch(e){
      print(e);
      super.networkState.value = NetworkStateEnum.ERROR;
    }
  }

   Future<void> smsAuth() async {
     if(phoneController.text == ""){
       Get.dialog(
         CustomDialogWidget(content: '전화번호가 입력되지 않았습니다.', onClick: (){
           Get.back();
           update();
         }),
       );
     }else{
       final res = await AuthProvider().smsAuth(phoneController.text);
       if(res == null){
         Get.dialog(
           CustomDialogWidget(content: '서버와의 연결이 원할하지 않습니다.', onClick: (){
             Get.back();
             update();
           }),
         );
       }else{
         enableButton.value = false;
         isAuth = false;
         isCode.value = false;
         authCodeController.text = "";
         idState.value = FindIdStateEnum.FIND_ALL_ID;
         pwState.value = FindPwStateEnum.DONE;
         authCode = res['data'];
         checkSmsAuthTimer();
         update();
       }
     }
   }

   checkSmsAuthTimer(){
     if(_timer != null){
       _timer!.cancel();
     }
     smsTime.value = 180;
     _timer = Timer.periodic(Duration(seconds: 1), (timer) {
       smsTime.value--;
       if(smsTime.value == 0){
         timer.cancel();
         return;
       }
       if(isAuth){
         timer.cancel();
         return;
       }
     });
   }

   void smsAuthChk() {
     if(smsTime.value == 0) {
       Get.dialog(
           CustomDialogWidget(content: '인증시간이 초과되었습니다.\n다시 시도 부탁드립니다.', onClick: (){
             Get.back();
           })
       );
       return;
     }
     if(authCode == authCodeController.text){
       isAuth = true;
       enableButton.value = true;
       _timer!.cancel();
       update();
     }else{
       Get.dialog(
         CustomDialogWidget(content: '인증번호가 올바르지 않습니다.', onClick: (){
           Get.back();
           update();
         }),
       );
       isAuth = false;
     }
     update();
   }

  showAllFindId() {
    Get.dialog(CustomDialogWidget(
      content: email,
      title: '아이디 안내',
      isSingleButton: false,
      okTxt: '로그인',
      cancelTxt: '비밀번호 찾기',
      onClick: () {
        Get.back();
        Get.offAllNamed('/auth/login');
      },
      onCancelClick: () {
        Get.back();
        tabController.index = 1;
        emailController.text = email;
        isAuth = false;
        _timer!.cancel();
        smsTime.value = 180;
        pwState.value = FindPwStateEnum.NONE;
        update();
      },
    ));
  }

 Future<bool> showPwAuthDialog() async{
      super.networkState.value = NetworkStateEnum.LOADING;
      final res = await AuthProvider().findPw(phoneController.text, emailController.text);
      if(res == null){
        Get.dialog(
            CustomDialogWidget(content: '서버와 접속이 원할 하지 않습니다.', onClick: (){
              Get.back();
              update();
            })
        );
        super.networkState.value = NetworkStateEnum.DONE;
        update();
        return false;
      }else{
        if(res['code'] == "U001" || res['code'] == "U002") {
          Get.dialog(
              CustomDialogWidget(content: '해당 유저를 찾을 수 없습니다.', onClick: () {
                Get.back();
                update();
              })
          );
          super.networkState.value = NetworkStateEnum.DONE;
          update();
          return false;
        }else{
          email = res['email'];
          isPwAuth = true;
          enableButton.value = false;
          pwState.value = FindPwStateEnum.AUTH;
          super.networkState.value = NetworkStateEnum.DONE;
          update();
          return true;
        }
      }
  }

   Future<void> showPwChangeDialog() async {
     if(pwTxt.value != rePwTxt.value){
       Get.dialog(
         CustomDialogWidget(content: '새로운 비밀번호가 서로 일치 하지 않습니다.', onClick: (){
           Get.back();
           update();
         }),
       );
     }else{
       final res = await AuthProvider().updatePw(email, pwTxt.value);
       if(res != null){
         print(res.toString());
         if(res['code'] == "U003"){
           Get.dialog(
             CustomDialogWidget(content: '비밀번호가 올바르지 않습니다.', onClick: (){
               Get.back();
               update();
             }),
           );
         }else{
           Get.dialog(
               CustomDialogWidget(content: '비밀번호가 변경되었습니다.', onClick: (){
                 Get.back();
                 Get.offAllNamed('/auth/login');
               })
           );
         }
       }else{
         Get.dialog(
           CustomDialogWidget(content: '서버와의 연결이 원할하지 않습니다.', onClick: (){
             Get.back();
             update();
           }),
         );
       }
     }
   }

  void idConfirm() async{
    if (idState.value == FindIdStateEnum.NONE) {
      await reqSecureFindId();
    } else {
      if(isAuth){
        showAllFindId();
        return;
      }
      Get.dialog(
          CustomDialogWidget(content: '인증번호를 인증해주세요.', onClick: (){
            Get.back();
          })
      );
    }
  }

  void pwConfirm() async{
    if(pwState.value == FindPwStateEnum.AUTH){
      await showPwChangeDialog();
    }
    if(isAuth && emailController.text.isNotEmpty) {
      await showPwAuthDialog();
      return;
    }
    if(emailController.text == ""){
      Get.dialog(
          CustomDialogWidget(content: '이메일을 입력해주세요.', onClick: (){
            Get.back();
          })
      );
      return;
    }
    Get.dialog(
        CustomDialogWidget(content: '인증번호를 인증해주세요.', onClick: (){
          Get.back();
        })
    );
  }

  void checkAuthCode() {
    isAuth = true;
    enableButton.value = true;
    update();
  }

  bool get pwCheck => pwTxt.value.length > 6 && pwTxt.value == rePwTxt.value;

  void initTabString() {
    print('tabController');
    print(tabController.indexIsChanging);
    if(!tabController.indexIsChanging){
      emailController = TextEditingController();
      phoneController = TextEditingController();
      authCodeController = TextEditingController();
      pwController = TextEditingController();
      rePwController = TextEditingController();
      idState.value = FindIdStateEnum.NONE;
      pwState.value = FindPwStateEnum.NONE;
      phone = '';
      authCode = '';
      isAuth = false;
      isPwAuth = false;
      isPhone = false.obs;
      phoneTxt = ''.obs;
      isCode = false.obs;
      codeTxt = ''.obs;
      enableButton = false.obs;
      debounce(phoneTxt, (_) {
        print('debounce');
        isPhone.value = RegexUtil.checkPhoneRegex(phone: phoneTxt.value);
        if (tabController.index == 0 && idState.value == FindIdStateEnum.NONE) {
          enableButton.value = isPhone.value;
        }
      });
      debounce(codeTxt, (_) {
        isCode.value = codeTxt.value.length == 6;
      });
    }
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    tabController.index = nowTab;
    idState.value = FindIdStateEnum.NONE;
    tabController.addListener(initTabString);
    debounce(phoneTxt, (_) {
      print('debounce');
      isPhone.value = RegexUtil.checkPhoneRegex(phone: phoneTxt.value);
      if (tabController.index == 0 && idState.value == FindIdStateEnum.NONE) {
        enableButton.value = isPhone.value;
      }
    });
    debounce(codeTxt, (_) {
      isCode.value = codeTxt.value.length == 6;
    });
  }
}
