import 'package:brandcare_mobile_flutter_v2/controllers/my/change_product_controller.dart';
import 'package:get/get.dart';

class ChangeProductBinding implements Bindings{
  @override
  void dependencies() {
    Get.put(ChangeProductController());
  }
}