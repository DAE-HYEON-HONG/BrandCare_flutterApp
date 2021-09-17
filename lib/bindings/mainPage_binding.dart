import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/home/mainHome_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/mainPage_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/notLoginPagesControllers/useInfoControllers/useInfoMain_controller.dart';
import 'package:get/get.dart';

class MainPageBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(MainPageController());
  }
}

class UseInfoMainBinding implements Bindings {
  @override
  void dependencies(){
    Get.put(UseInfoMainController());
  }
}