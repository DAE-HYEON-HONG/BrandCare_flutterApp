import 'package:brandcare_mobile_flutter_v2/controllers/global_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/AddProductControllers/mainAddProduct_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/addCareControllers/mainAddCare_controller.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/addCarePages/mainAddCare_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/addProductPages/mainAddProduct_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/mainHome_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/notice/main_notice_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/shopPages/mainShop_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/my_page.dart';
import "package:get/get.dart";
import 'package:flutter/material.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';

class MainPageController extends BaseController {

  RxInt selectedIdx = 0.obs;
  int backWidget = 0;
  GlobalController _globalController = Get.find<GlobalController>();
  MainAddProductController mainAddProductCtrl = Get.put(MainAddProductController());
  MainAddCareController _addCareController = Get.put(MainAddCareController());

  //로딩할 위젯들
  List<Widget> widgetOptions = <Widget> [
    MainHomePage(),
    MainAddProductPage(),
    MainAddCarePage(),
    MainShopPage(),
    MyPage(),
    MainNoticePage(),
  ];

  void backHome(){
    selectedIdx.value = 0;
    update();
  }

  void onItemTaped(int idx){
    if(!_globalController.isLogin.value) {
      Get.toNamed('/notLoginPage');
      return;
    }
    if(idx == 2){
    _addCareController.initInfo();
    _addCareController.update();
    }
    selectedIdx.value = idx;
    print("현재 선택된 idx: ${selectedIdx.value}");
    if(idx != 5) {
      backWidget = idx;
    }
    update();
    if(idx == 1){
      mainAddProductCtrl.initInfo();
      mainAddProductCtrl.update();
    }else if(idx == 2){
      _addCareController.initInfo();
      _addCareController.update();
    }
    update();
  }
  @override
  void onInit() async{
    super.onInit();
  }
}