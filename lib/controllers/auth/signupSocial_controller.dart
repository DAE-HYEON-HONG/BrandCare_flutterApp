import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/providers/auth_provider.dart';
import 'package:brandcare_mobile_flutter_v2/utils/regex_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SignUpSocialController extends BaseController {
  final TextEditingController emailController = TextEditingController();
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
  RxBool duplicateEmail = false.obs;

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

  void setSocialProfile({String? email, String? name}){
    emailController.text = email ?? '';
    emailTxt.value = email ?? '';
    nameController.text = name ?? '';
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

  Future<void> registerChk(String type) async{
    if(emailController.text == ""){
      Get.dialog(
          CustomDialogWidget(content: '이메일이 적혀있지 않습니다.', onClick: (){
            Get.back();
            update();
          }),
      );
    } else if(!duplicateEmail.value){
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
      await addUser(type);
    }
  }

  Future<void> addUser(String type) async{
    final addUser = await AuthProvider().registerUserSocial(
      friendCodeController.text,
      emailController.text,
      nameController.text,
      phoneController.text,
      type,
    );
    Get.back();
  }

  bool get allAgree => agree.value && privacyAgree.value;

  @override
  void onInit() {
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
  }
}