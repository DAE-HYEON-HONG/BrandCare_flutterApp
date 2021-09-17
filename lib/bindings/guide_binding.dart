import 'package:brandcare_mobile_flutter_v2/controllers/guide/guide_controller.dart';
import 'package:get/get.dart';

class GuideBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(GuideController());
  }
}