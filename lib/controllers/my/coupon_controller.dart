import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:get/get.dart';

class CouponController extends BaseController{
  List couponList = [];
  RxString couponCode = RxString('');

  addCoupon() {
    couponList.add('');
    update();
  }
  bool get isValidCouponCode => couponCode.value != '' && couponCode.value.isNotEmpty && couponCode.value.length == 11;

}