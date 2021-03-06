import 'package:brandcare_mobile_flutter_v2/controllers/my/my_product_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/productInfo_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/product_info_controller.dart';
import 'package:get/get.dart';

class MyProductBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(MyProductController());
  }
}

class ProductInfoBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ProductInfoController());
  }
}

class ProductInfoDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ProductInfoDetailController());
  }
}