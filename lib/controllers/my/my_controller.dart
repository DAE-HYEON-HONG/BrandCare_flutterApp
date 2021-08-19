import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MyController extends BaseController {
  List<Map<String, int>> myData = [
    {'등록제품보기': 13},
    {'케어/수선이력': 10},
    {'정품인증이력': 10}
  ];

  Map<String, String> linkData = {
    '친구 초대 하기': '/main/my/invite',
    '제품 사용자 변경': '',
    '공지사항': '/main/my/notice',
    '자주 묻는 질문': '/main/my/question',
    '1:1 문의': '/main/my/inquiry',
    '설정': '/main/my/setting',
  };

  Map<String, String> infoLinkData = {
    '프로필 사진 등록 / 변경': 'profile',
    '아이디(이메일)' : 'email',
    '이름(닉네임) 변경' : '/main/my/info/name',
    '비밀번호 변경': '/main/my/info/password',
    '전화번호 변경': '/main/my/info/phone',
    '주소 등록 / 변경': '/main/my/info/address'
  };

  Rx<String> name = ''.obs;
  Rx<String> nowPassword = ''.obs;
  Rx<String> password = ''.obs;
  Rx<String> rePassword = ''.obs;
  Rx<String> phone = ''.obs;
  Rx<String> code = ''.obs;
  Rx<String> address = ''.obs;
  Rx<String> detailAddress = ''.obs;
  Rx<String> postcode = ''.obs;

  TextEditingController addressController = TextEditingController();
  TextEditingController addressDetailController = TextEditingController();
  TextEditingController postCodeController = TextEditingController();

  Rx<bool> isAuth = false.obs;
  void initMyController(){
    name.value = '';
    password.value = '';
    rePassword.value = '';
    phone = ''.obs;
    code = ''.obs;
    isAuth.value = false;
    address = ''.obs;
    detailAddress = ''.obs;
    addressController = TextEditingController();
    addressDetailController = TextEditingController();
    postCodeController = TextEditingController();
  }

  void authChangePhone() {
    isAuth.value = true;
    update();
  }

  bool get passwordIsOn => nowPassword.isNotEmpty && password.value.isNotEmpty && rePassword.value.isNotEmpty && password.value == rePassword.value;
  bool get isPhone => phone.value.length == 11;
  bool get isCode => code.value.length == 6;
  bool get isAddress => address.value.isNotEmpty && detailAddress.value.isNotEmpty && postcode.value.isNotEmpty;

}
