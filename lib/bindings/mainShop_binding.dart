import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/shopControllers/shopAddProductController/shopAddProduct_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/shopControllers/shopDetail/shopDetail_controller.dart';
import 'package:get/get.dart';

//메인 샵 바인딩

//shop 거래 등록 바인딩
class MainShopAddProductBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ShopAddProductController());
  }
}

class MainShopDetailBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(ShopDetailController());
  }
}