import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/AddProductControllers/addProductDescription_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/AddProductControllers/addProductImgs_controller.dart';
import 'package:get/get.dart';

class MainAddProductBindings implements Bindings {
  @override
  void dependencies() {
    Get.put(AddProductImgsController());
    Get.put(AddProductDescriptionController());
  }
}