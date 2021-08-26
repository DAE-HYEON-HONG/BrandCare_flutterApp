import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/providers/auth_provider.dart';
import 'package:brandcare_mobile_flutter_v2/utils/regex_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

enum SignUpCheckEmail {
  NONE,
  DONE,
  DUPLICATE
}

class SignUpController extends BaseController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController rePasswordController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController authNumberController = TextEditingController();
  final TextEditingController friendCodeController = TextEditingController();

  Rx<bool> sendPhoneCode = false.obs;
  Rx<bool> authCode = false.obs;

  Rx<bool> agree = false.obs;
  Rx<bool> privacyAgree = false.obs;

  Rx<bool> isEmail = false.obs;
  Rx<String> emailTxt = ''.obs;
  Rx<SignUpCheckEmail> duplicateEmail = SignUpCheckEmail.NONE.obs;

  Rx<bool> isPhone = false.obs;
  Rx<String> phoneTxt = ''.obs;
  bool phoneChecked = true; // false로 꼭 바꿔주세요.


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

  void chkDuplicateEmail(String email)async{
    super.networkState.value = NetworkStateEnum.LOADING;
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
        duplicateEmail.value = SignUpCheckEmail.DONE;
        update();
      }else {
        duplicateEmail.value = SignUpCheckEmail.DUPLICATE;
        // Get.dialog(
        //     CustomDialogWidget(content: '중복되는 이메일입니다.', onClick: (){
        //       Get.back();
        //       update();
        //     })
        // );
        update();
      }
    }
    super.networkState.value = NetworkStateEnum.NONE;
  }

  Future<void> registerChk() async{
    if(emailController.text == ""){
      Get.dialog(
          CustomDialogWidget(content: '이메일이 적혀있지 않습니다.', onClick: (){
            Get.back();
            update();
          }),
      );
    } else if(duplicateEmail.value == SignUpCheckEmail.DUPLICATE){
      Get.dialog(
        CustomDialogWidget(content: '이메일을 중복 및 확인해주세요.', onClick: (){
          Get.back();
          update();
        }),
      );
    } else if(phoneController.text == ""){
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
      await addUser();
    }
  }

  Future<void> addUser() async{
    final addUser = await AuthProvider().registerUserEmail(
        friendCodeController.text,
        emailController.text,
        nameController.text,
        passwordController.text,
        phoneController.text,
    );
    Get.back();
  }

  bool get allAgree => agree.value && privacyAgree.value;

  @override
  void onInit() {
    super.onInit();
    debounce(emailTxt, (_) {
      isEmail.value = RegexUtil.checkEmailRegex(email: emailTxt.value);
    });
    debounce(phoneTxt, (_) {
      isPhone.value = RegexUtil.checkPhoneRegex(phone: phoneTxt.value);
    });
  }
}