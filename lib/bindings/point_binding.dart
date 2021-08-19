import 'package:brandcare_mobile_flutter_v2/controllers/auth/login_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/point_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/splash_controller.dart';
import 'package:get/get.dart';

class PointBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(PointController());
  }

}