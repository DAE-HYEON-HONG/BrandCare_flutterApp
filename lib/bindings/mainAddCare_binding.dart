import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/addCareControllers/addCareEtc_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/addCareControllers/addCarePayment_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/addCareControllers/addCarePic_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/addCareControllers/addCareStatus_controller.dart';
import 'package:get/get.dart';

class MainAddCareBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AddCarePicController());
    Get.put(AddCareEtcController());
    Get.put(AddCarePaymentController());
  }
}

class CareStatusBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(AddCareStatusController());
  }
}