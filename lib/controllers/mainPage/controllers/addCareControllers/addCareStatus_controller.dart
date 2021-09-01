import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/addCare/careProductInfo_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/addCare/careStatus_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/addCare/care_statusDate_model.dart';
import 'package:brandcare_mobile_flutter_v2/providers/care_provider.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/addCarePages/addCareDetail_page.dart';
import 'package:brandcare_mobile_flutter_v2/utils/shared_token_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:get/get.dart';

class AddCareStatusController extends BaseController {

  RxBool fill = true.obs;
  CareStatusModel? careStatus;
  CareStatusDateModel? dateStatus;
  int productIdx = Get.arguments["idx"];
  bool back = Get.arguments['back'];

  List<Map<dynamic, dynamic>> careStatusJson = [];
  void nextLevel() {
    if(back){
      Get.back();
    }else{
      Get.offAllNamed('/mainPage');
    }
  }

  void detail() {
    Get.to(() => AddCareDetailPage(), arguments: productIdx);
  }

  Future<void> reqCareStatus() async {
    try{
      super.networkState.value = NetworkStateEnum.LOADING;
      final String? token = await SharedTokenUtil.getToken("userLogin_token");
      final res =  await CareProvider().careStatus(token!, productIdx);
      if(res == null){
        Get.dialog(
            CustomDialogWidget(content: '서버와 접속이 원할 하지 않습니다.', onClick: (){
              Get.back();
              update();
            })
        );
      }else{
        careStatus = CareStatusModel.fromJson(res);
        dateStatus = CareStatusDateModel.fromJson(res);
        update();
        super.networkState.value = NetworkStateEnum.DONE;
      }
    }catch(e){
      print(e);
      super.networkState.value = NetworkStateEnum.ERROR;
    }
  }

  void addList(){
    print(dateStatus?.completedDate);
    careStatusJson.add({
      "statusType" : "신청 완료",
      "date" : careStatus?.createdDate,
      "time" : careStatus?.createdDate,
      "checked" : careStatus?.createdDate == null ? false : true,
    });
    careStatusJson.add({
      "statusType" : "택배 수거 진행중",
      "date" : dateStatus?.pickUpDate,
      "time" : dateStatus?.pickUpDate,
      "checked" : dateStatus?.pickUpDate == null ? false : true,
    });
    careStatusJson.add({
      "statusType" : "입고",
      "date" : dateStatus?.wareHouseIngDate,
      "time" : dateStatus?.wareHouseIngDate,
      "checked" : dateStatus?.wareHouseIngDate == null ? false : true,
    });
    careStatusJson.add({
      "statusType" : "케어/수선 진행 중",
      "date" : dateStatus?.caringDate,
      "time" : dateStatus?.caringDate,
      "checked" : dateStatus?.caringDate == null ? false : true,
    });
    careStatusJson.add({
      "statusType" : "출고",
      "date" : dateStatus?.be_releasedDate,
      "time" : dateStatus?.be_releasedDate,
      "checked" : dateStatus?.be_releasedDate == null ? false : true,
    });
    careStatusJson.add({
      "statusType" : "택배 배송 중",
      "date" : dateStatus?.deliveringDate,
      "time" : dateStatus?.deliveringDate,
      "checked" : dateStatus?.deliveringDate == null ? false : true,
    });
    careStatusJson.add({
      "statusType" : "완료",
      "date" : dateStatus?.completedDate,
      "time" : dateStatus?.completedDate,
      "checked" : dateStatus?.completedDate == null ? false : true,
    });
    update();
  }
  @override
  void onInit() async{
    await reqCareStatus();
    addList();
    super.onInit();
  }
}