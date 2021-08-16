import 'package:brandcare_mobile_flutter_v2/controllers/auth/find_controller.dart';
import 'package:get/get.dart';

class FindAccountBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(FindController());
  }

}