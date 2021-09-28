import 'package:brandcare_mobile_flutter_v2/models/care/careCategory_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/mypage/myInfo/myProfileInfo_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/mypage/myInfo/userInfo_model.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController{
  RxBool isLogin = false.obs;
  RxString token = "".obs;
  UserInfoModel? userInfoModel;
  String? fcmToken;

  List<CareCategoryModel>? careCategory = <CareCategoryModel>[];

  void isLoginChk(bool isChk){
    if(isChk){
      isLogin.value = true;
      update();
    }else{
      isLogin.value = false;
    }
  }

  void addUserInfo(dynamic userInfo) {
    userInfoModel = userInfo;
    update();
  }
}