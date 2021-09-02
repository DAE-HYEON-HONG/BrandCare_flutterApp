import 'package:brandcare_mobile_flutter_v2/controllers/global_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/AddProductControllers/mainAddProduct_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/addCareControllers/mainAddCare_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/care/careCategory_model.dart';
import 'package:brandcare_mobile_flutter_v2/providers/care_provider.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/addCarePages/mainAddCare_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/addProductPages/mainAddProduct_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/mainHome_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/shopPages/mainShop_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/my_page.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import "package:get/get.dart";
import 'package:flutter/material.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';

class MainPageController extends BaseController {

  RxInt selectedIdx = 0.obs;
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
  ];

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
    if(idx == 1){
      mainAddProductCtrl.initInfo();
      mainAddProductCtrl.update();
    }else if(idx == 2){
      _addCareController.initInfo();
      _addCareController.update();
    }
    update();
  }

  Future<void> careCategory()async{
    final res = await CareProvider().careCategory();
    if(res == null){
      Get.dialog(
          CustomDialogWidget(content: '서버와 접속이 원할 하지 않습니다.', onClick: (){
            Get.back();
            update();
          })
      );
    }else {
      print(res['data']);
      final list = (res['data'] as List).map((e) => CareCategoryModel.fromJson(e)).toList();
      for (var e in list) {
        _globalController.careCategory!.add(e);
      }
    }
    _globalController.update();
    update();
  }

  @override
  void onInit() async{
    await careCategory();
    super.onInit();
  }
}