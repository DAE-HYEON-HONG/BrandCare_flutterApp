import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/careStatus_model.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/addCarePages/addCareDetail_page.dart';
import 'package:get/get.dart';

class AddCareStatusController extends BaseController {

  RxBool fill = true.obs;

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
  @override
  void onInit() {
    super.onInit();
  }
}