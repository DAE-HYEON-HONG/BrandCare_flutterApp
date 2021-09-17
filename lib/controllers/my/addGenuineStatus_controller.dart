import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/addCare/careStatus_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/addCare/care_statusDate_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/genuine/genuineStatus_model.dart';
import 'package:brandcare_mobile_flutter_v2/providers/care_provider.dart';
import 'package:brandcare_mobile_flutter_v2/providers/product_provider.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/addCarePages/addCareDetail_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/genuine/addGenuineDetail_page.dart';
import 'package:brandcare_mobile_flutter_v2/utils/shared_token_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:get/get.dart';

class AddGenuineStatusController extends BaseController {

  RxBool fill = true.obs;
  GenuineStatusModel? genuineStatus;
  CareStatusDateModel? dateStatus;
  int productIdx = Get.arguments['idx'];
  bool back = Get.arguments['back'];
  List<Map<dynamic, dynamic>> genuineStatusJson = [];
  void nextLevel() {
    if(back){
      Get.back();
    }else{
      Get.offAllNamed('/mainPage');
    }
  }

  void detail() {
    Get.to(() => AddGenuineDetailPage(), arguments: {
      'back' : true,
      'idx' : genuineStatus?.id,
      'status': genuineStatus?.status,
    });
  }

  Future<void> reqGenuineStatus() async {
    print(productIdx);
    try{
      super.networkState.value = NetworkStateEnum.LOADING;
      final res =  await ProductProvider().genuineStatus(productIdx);
      if(res == null){
        Get.dialog(
            CustomDialogWidget(content: '서버와 접속이 원할 하지 않습니다.', onClick: (){
              Get.back();
              update();
            })
        );
        super.networkState.value = NetworkStateEnum.DONE;
        Get.back();
      }else{
        genuineStatus = GenuineStatusModel.fromJson(res);
        dateStatus = CareStatusDateModel.fromJson(res);
        super.networkState.value = NetworkStateEnum.DONE;
        update();
      }
    }catch(e){
      print(e);
      super.networkState.value = NetworkStateEnum.ERROR;
    }
  }

  void addList(){
    genuineStatusJson.add({
      "statusType" : "신청 완료",
      "date" : genuineStatus?.createdDate,
      "time" : genuineStatus?.createdDate,
      "checked" : genuineStatus?.createdDate == null ? false : true,
    });
    genuineStatusJson.add({
      "statusType" : "택배 수거 진행중",
      "date" : dateStatus?.pickUpDate,
      "time" : dateStatus?.pickUpDate,
      "checked" : dateStatus?.pickUpDate == null ? false : true,
    });
    genuineStatusJson.add({
      "statusType" : "입고",
      "date" : dateStatus?.wareHouseIngDate,
      "time" : dateStatus?.wareHouseIngDate,
      "checked" : dateStatus?.wareHouseIngDate == null ? false : true,
    });
    genuineStatusJson.add({
      "statusType" : "케어/수선 진행 중",
      "date" : dateStatus?.caringDate,
      "time" : dateStatus?.caringDate,
      "checked" : dateStatus?.caringDate == null ? false : true,
    });
    genuineStatusJson.add({
      "statusType" : "출고",
      "date" : dateStatus?.be_releasedDate,
      "time" : dateStatus?.be_releasedDate,
      "checked" : dateStatus?.be_releasedDate == null ? false : true,
    });
    genuineStatusJson.add({
      "statusType" : "택배 배송 중",
      "date" : dateStatus?.deliveringDate,
      "time" : dateStatus?.deliveringDate,
      "checked" : dateStatus?.deliveringDate == null ? false : true,
    });
    genuineStatusJson.add({
      "statusType" : "완료",
      "date" : dateStatus?.completedDate,
      "time" : dateStatus?.completedDate,
      "checked" : dateStatus?.completedDate == null ? false : true,
    });
    update();
  }

  @override
  void onInit() async{
    super.onInit();
    await reqGenuineStatus();
    addList();
  }
}
//${controller.careStatus.careProduct[0].category}