import 'package:brandcare_mobile_flutter_v2/controllers/my/care_history_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/payment/iamport_payment_controller.dart';
import 'package:get/get.dart';

class IamportPaymentBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(IamportPaymentController());
  }

}