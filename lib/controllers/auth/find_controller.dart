import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/utils/regex_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

enum FindIdStateEnum { NONE, FIND_ALL_ID, DONE }

enum FindPwStateEnum { NONE, AUTH }

class FindController extends BaseController with SingleGetTickerProviderMixin {
   TextEditingController emailController = TextEditingController();
   TextEditingController phoneController = TextEditingController();
   TextEditingController authCodeController = TextEditingController();

   TextEditingController pwController = TextEditingController();
   TextEditingController rePwController = TextEditingController();

  int currentIndex = 0;
  String phone = '';
  String authCode = '';

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

  late TabController tabController;

  changeCurrentIndex({required int index}) {
    currentIndex = index;
    update();
  }

  showInfoFindId() {
    Get.dialog(CustomDialogWidget(
      content: '휴대전화 번호 인증을 하시면\n전체 아이디를 확인 하실 수 있습니다.\n인증을 진행하시겠습니까?',
      title: '아이디 찾기 안내\n\nte***@test.com',
      isSingleButton: false,
      onClick: () {
        idState.value = FindIdStateEnum.FIND_ALL_ID;
        enableButton.value = false;
        update();
        Get.back();
      },
    ));
  }

  showAllFindId() {
    Get.dialog(CustomDialogWidget(
      content: 'test@test.com',
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
      },
    ));
  }

  showPwAuthDialog() {
    Get.dialog(
      CustomDialogWidget(content: '인증되었습니다.', onClick: (){
        Get.back();
        isPwAuth = true;
        enableButton.value = false;
        pwState.value = FindPwStateEnum.AUTH;
        update();
      })
    );
  }

   showPwChangeDialog() {
     Get.dialog(
         CustomDialogWidget(content: '비밀번호가 변경되었습니다..', onClick: (){
           Get.back();
           Get.offAllNamed('/auth/login');
         })
     );
   }

  void idConfirm() {
    if (idState.value == FindIdStateEnum.NONE) {
      showInfoFindId();
    } else {
      showAllFindId();
    }
  }

  void pwConfirm() {
    if (pwState.value == FindPwStateEnum.NONE) {
      showPwAuthDialog();
    } else {
      showPwChangeDialog();
    }
  }

  void checkAuthCode() {
    isAuth = true;
    enableButton.value = true;
    update();
  }

  bool get pwCheck => pwTxt.value.length > 6 && pwTxt.value == rePwTxt.value;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
    idState.value = FindIdStateEnum.NONE;
    tabController.addListener(() {
      print('tabController');
      print(tabController.indexIsChanging);
      if (tabController.indexIsChanging) {
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
    });
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
