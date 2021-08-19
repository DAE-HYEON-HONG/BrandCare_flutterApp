import 'package:brandcare_mobile_flutter_v2/controllers/auth/login_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/coupon_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/splash_controller.dart';
import 'package:get/get.dart';

class CouponBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(CouponController());
  }

}