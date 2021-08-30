import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/addCare/careStatus_model.dart';
import 'package:brandcare_mobile_flutter_v2/providers/care_provider.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/addCarePages/addCareDetail_page.dart';
import 'package:brandcare_mobile_flutter_v2/utils/shared_token_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:get/get.dart';

class AddCareStatusController extends BaseController {

  RxBool fill = true.obs;
  late CareStatusModel careStatus;

  List<Map<dynamic, dynamic>> careStatusJson = [
    {
      "statusType" : "신청 완료",
      "date" : "2021-06-02T17:11:59.040906",
      "time" : "2021-06-02T17:11:59.040906",
      "checked" : true,
    },
    {
      "statusType" : "택배 수거 진행중",
      "date" : "2021-06-02T17:11:59.040906",
      "time" : "2021-06-02T17:11:59.040906",
      "checked" : true,
    },
    {
      "statusType" : "입고",
      "date" : "2021-06-02T17:11:59.040906",
      "time" : "2021-06-02T17:11:59.040906",
      "checked" : true,
    },
    {
      "statusType" : "케어/수선 진행 중",
      "date" : "2021-06-02T17:11:59.040906",
      "time" : "2021-06-02T17:11:59.040906",
      "checked" : false,
    },
    {
      "statusType" : "출고",
      "date" : "2021-06-02T17:11:59.040906",
      "time" : "2021-06-02T17:11:59.040906",
      "checked" : false,
    },
    {
      "statusType" : "택배 배송 중",
      "date" : "2021-06-02T17:11:59.040906",
      "time" : "2021-06-02T17:11:59.040906",
      "checked" : false,
    },
    {
      "statusType" : "완료",
      "date" : "2021-06-02T17:11:59.040906",
      "time" : "2021-06-02T17:11:59.040906",
      "checked" : false,
    },
  ];
  void nextLevel() {
    Get.offAllNamed('/mainPage');
  }

  void detail() {
    Get.to(AddCareDetailPage());
  }

  Future<void> reqCareStatus() async {
    try{
      super.networkState.value = NetworkStateEnum.LOADING;
      final String? token = await SharedTokenUtil.getToken("userLogin_token");
      final res =  await CareProvider().careStatus(token!, Get.arguments);
      if(res == null){
        Get.dialog(
            CustomDialogWidget(content: '서버와 접속이 원할 하지 않습니다.', onClick: (){
              Get.back();
              update();
            })
        );
      }else{
        careStatus = res;
        super.networkState.value = NetworkStateEnum.DONE;
        update();
      }
    }catch(e){
      print(e);
      super.networkState.value = NetworkStateEnum.ERROR;
    }
  }

  @override
  void onInit() async{
    await reqCareStatus();
    super.onInit();
  }
}
//${controller.careStatus.careProduct[0].category}