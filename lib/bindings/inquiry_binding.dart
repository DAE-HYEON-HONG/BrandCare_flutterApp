import 'package:brandcare_mobile_flutter_v2/controllers/my/inquiry_controller.dart';
import 'package:get/get.dart';

class InquiryBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(InquiryController());
  }

}