import 'package:brandcare_mobile_flutter_v2/controllers/my/modified_product_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/src/bindings_interface.dart';

class ModifiedProductInfoBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ModifiedProductController());
  }
}