import 'package:brandcare_mobile_flutter_v2/controllers/my/invite_controller.dart';
import 'package:get/get.dart';

class InviteBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(InviteController());
  }

}