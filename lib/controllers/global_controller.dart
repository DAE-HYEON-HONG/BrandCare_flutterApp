import 'package:brandcare_mobile_flutter_v2/models/care/careCategory_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/mypage/myInfo/myProfileInfo_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/mypage/myInfo/userInfo_model.dart';
import 'package:brandcare_mobile_flutter_v2/providers/care_provider.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:get/get.dart';

class GlobalController extends GetxController{
  RxBool isLogin = false.obs;
  RxString token = "".obs;
  UserInfoModel? userInfoModel;
  String? fcmToken;

  List<CareCategoryModel>? careCategory = <CareCategoryModel>[];

  Future<void> reqCareCategory()async{
    final res = await CareProvider().careCategory();
    if(res == null){
      Get.dialog(
          CustomDialogWidget(content: '서버와 접속이 원할 하지 않습니다.', onClick: (){
            Get.back();
            update();
          })
      );
    }else {
      print(res['data']);
      final list = (res['data'] as List).map((e) => CareCategoryModel.fromJson(e)).toList();
      // for (var e in list) {
      //   careCategory!.add(e);
      // }
      careCategory = list;
    }
    update();
  }

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