import 'package:brandcare_mobile_flutter_v2/controllers/my/care_history_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/genuine_controller.dart';
import 'package:get/get.dart';

class CareHistoryBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(CareHistoryController());
  }

}