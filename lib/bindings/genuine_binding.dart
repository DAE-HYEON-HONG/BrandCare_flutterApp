import 'package:brandcare_mobile_flutter_v2/controllers/my/genuine_controller.dart';
import 'package:get/get.dart';

class GenuineBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(GenuineController());
  }

}