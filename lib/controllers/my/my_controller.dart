import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/mypage/banner/banner_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/mypage/myInfo/myProfileInfo_model.dart';
import 'package:brandcare_mobile_flutter_v2/providers/auth_provider.dart';
import 'package:brandcare_mobile_flutter_v2/providers/my_provider.dart';
import 'package:brandcare_mobile_flutter_v2/utils/shared_token_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import '../global_controller.dart';

class MyController extends BaseController {

  final globalCtrl = Get.find<GlobalController>();
  MyProfileInfoModel? myProfileInfoModel;
  List<BannerModel>? bannerList = <BannerModel>[];
  List<Map<String, int>> myData = [];

  void myDataInfo(){
    myData.add({'등록제품보기': myProfileInfoModel?.productCount ?? 0});
    myData.add({'케어/수선이력': myProfileInfoModel?.careCount ?? 0});
    myData.add({'정품인증이력': myProfileInfoModel?.activationCount ?? 0});
  }
  Map<String, String> linkData = {
    '친구 초대 하기': '/main/my/invite',
    '제품 사용자 변경': '/main/my/change_product',
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
  Rx<String> city = ''.obs;
  Rx<String> sigungu = ''.obs;
  Rx<String> street = ''.obs;
  Rx<String> address = ''.obs;
  Rx<String> detailAddress = ''.obs;
  Rx<String> postcode = ''.obs;
  String authNum = '';
  bool authNumChk = false;

  TextEditingController nickNameController = TextEditingController();
  TextEditingController currentPwController = TextEditingController();
  TextEditingController pwController = TextEditingController();
  TextEditingController rePwController = TextEditingController();
  TextEditingController addressController = TextEditingController();
  TextEditingController addressDetailController = TextEditingController();
  TextEditingController postCodeController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController codeController = TextEditingController();

  Rx<File> profileImg = File('').obs;
  final ImagePicker imgPicker = ImagePicker();

  Future<void> loadAssets(ImageSource source)async{
    try{
      final pickedFile = await imgPicker.pickImage(
        source: source,
        maxWidth: 500,
        maxHeight: 500,
        imageQuality: 10,
        preferredCameraDevice: CameraDevice.rear,
      );
      profileImg.value = File(pickedFile!.path);
      await changeProfileImg();
      update();
      Get.back();
    }catch(e){
      print(e.toString());
    }
  }

  Rx<bool> isAuth = false.obs;

  void initMyController(){
    print('초기화');
    nickNameController.text = '';
    name.value = "";
    password.value = '';
    rePassword.value = '';
    phone = ''.obs;
    code = ''.obs;
    isAuth.value = false;
    address = ''.obs;
    detailAddress = ''.obs;
    addressController.text = "";
    addressDetailController.text = "";
    postCodeController.text = "";
    phoneController.text = "";
    codeController.text = "";
    update();
  }

  bool changeColor(){
    if(nickNameController.text.isNotEmpty){
      return true;
    }
    else if(password.value.isNotEmpty && rePassword.value.isNotEmpty){
      return true;
    }
    else if(phoneController.text.isNotEmpty && codeController.text.isNotEmpty && isAuth.value){
      return true;
    }
    else if(addressController.text.isNotEmpty && addressDetailController.text.isNotEmpty && postCodeController.text.isNotEmpty){
      return true;
    }
    return false;
  }

  Future<bool> permissionChk() async{
    final Map<Permission, PermissionStatus> status = await [
      Permission.photos,
      Permission.camera,
    ].request();
    bool? permissionStatus;
    await Permission.photos.shouldShowRequestRationale;
    status.forEach((permission, status) {
      if(status.isGranted){
        permissionStatus = true;
        return;
      }
      permissionStatus = false;
    });
    return permissionStatus!;
  }

  Future<void> myInfo() async{
    final String? token = await SharedTokenUtil.getToken("userLogin_token");
    final res = await MyProvider().chkMyProfile(token!);
    final resAuth = await AuthProvider().loginToken(token);
    if(res != null){
      myPageInfo(res);
      globalCtrl.addUserInfo(resAuth);
      globalCtrl.update();
    }else{
      Get.dialog(
        CustomDialogWidget(content: '서버와의 연결이 원할하지 않습니다.', onClick: (){
          Get.back();
          update();
        }),
      );
    }
  }

  Future<void> changeProfileImg() async {
    final String? token = await SharedTokenUtil.getToken('userLogin_token');
    final res = await MyProvider().changeProfileImg(token!, profileImg.value);
    print(res.toString());
    if(res != null){
      await myInfo();
    }else{
      Get.dialog(
        CustomDialogWidget(content: '서버와의 연결이 원할하지 않습니다.', onClick: (){
          Get.back();
          update();
        }),
      );
    }
  }

  void myPageInfo(dynamic myProfileInfo){
    myProfileInfoModel = myProfileInfo;
    update();
  }

  Future<void> changeNickName(String name) async{
    if(name.isNotEmpty){
      final String? token = await SharedTokenUtil.getToken("userLogin_token");
      final res = await MyProvider().changeName(token!, name);
      if(res){
        myInfo();
        Get.dialog(
          CustomDialogWidget(content: '닉네임이 변경되었습니다.', onClick: (){
            Get.back();
            Get.back();
            update();
          }),
        );
        update();
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

  Future<void> changePassword() async {
    if(password.value != rePassword.value){
      Get.dialog(
        CustomDialogWidget(content: '새로운 비밀번호가 서로 일치 하지 않습니다.', onClick: (){
          Get.back();
          update();
        }),
      );
    }else{
      final String? token = await SharedTokenUtil.getToken('userLogin_token');
      final res = await MyProvider().changePassword(token!, password.value, nowPassword.value);
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
              Get.back();
              update();
            }),
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

  Future<void> smsAuth() async {
    final res = await AuthProvider().smsAuth(phone.value);
    if(res == null){
      Get.dialog(
        CustomDialogWidget(content: '서버와의 연결이 원할하지 않습니다.', onClick: (){
          Get.back();
          update();
        }),
      );
    }else{
      authNum = res['data'];
      update();
    }
  }

  void smsAuthChk() {
    if(authNum == code.value){
      isAuth.value = true;
    }else{
      Get.dialog(
        CustomDialogWidget(content: '인증번호가 올바르지 않습니다.', onClick: (){
          Get.back();
          update();
        }),
      );
      isAuth.value = false;
    }
    update();
  }

  Future<void> changePhone() async{
    if(isAuth.value){
      final String? token = await SharedTokenUtil.getToken("userLogin_token");
      final res = await MyProvider().changeNumber(token!, phone.value);
      print(res.toString());
      if(res['data'] == "Y"){
        globalCtrl.userInfoModel!.phNum = phone.value;
        globalCtrl.update();
        myInfo();
        Get.dialog(
          CustomDialogWidget(content: '전화번호가 변경되었습니다.', onClick: (){
            Get.back();
            Get.back();
            update();
          }),
        );
        update();
      }else{
        Get.dialog(
          CustomDialogWidget(content: '서버와의 연결이 원할하지 않습니다.', onClick: (){
            Get.back();
            update();
          }),
        );
      }
    }else{
      Get.dialog(
        CustomDialogWidget(content: '인증번호가 확인되지 않았습니다.', onClick: (){
          Get.back();
          update();
        }),
      );
    }
  }

  Future<void> changeAddress(BuildContext context) async{
    FocusScope.of(context).unfocus();
    if(postCodeController.text == ""){
      Get.dialog(
        CustomDialogWidget(content: '우편번호가 입력되지 않았습니다.', onClick: (){
          Get.back();
          update();
        }),
      );
    }else{
      final String? token = await SharedTokenUtil.getToken("userLogin_token");
      final res = await MyProvider().changeAddress(
        token!,
        '${city.value} ${sigungu.value}',
        "${street.value.split('${city.value} ${sigungu.value}').last}${detailAddress}",
        postcode.value,
      );
      if(res){
        myInfo();
        Get.dialog(
          CustomDialogWidget(content: '주소가 변경되었습니다.', onClick: (){
            Get.back();
            Get.back();
            update();
          }),
        );
        update();
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

  void authChangePhone() {
    isAuth.value = true;
    update();
  }

  Future<void> reqBannerList() async {
    final res =  await MyProvider().getBanner("MAIN");
    if(res == null){
      Get.dialog(
          CustomDialogWidget(content: '서버와 접속이 원할 하지 않습니다.', onClick: (){
            Get.back();
            update();
          })
      );
    }else{
      print(res.toString());
      bannerList = bannerList = (res['data'] as List).map((e) => BannerModel.fromJson(e)).toList();
      update();
    }
    update();
  }

  bool get passwordIsOn => nowPassword.isNotEmpty && password.value.isNotEmpty && rePassword.value.isNotEmpty && password.value == rePassword.value;
  bool get isPhone => phone.value.length == 11;
  bool get isCode => code.value.length == 6;
  bool get isAddress => address.value.isNotEmpty && detailAddress.value.isNotEmpty && postcode.value.isNotEmpty;

  @override
  void onInit() async{
    await myInfo();
    await reqBannerList();
    initMyController();
    myDataInfo();
    super.onInit();
  }
}
