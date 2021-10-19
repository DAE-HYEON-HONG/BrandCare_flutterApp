import 'package:brandcare_mobile_flutter_v2/controllers/global_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/AddProductControllers/mainAddProduct_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/addCareControllers/mainAddCare_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/notice/main_notice_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/shopControllers/mainShop_controller.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/addCarePages/mainAddCare_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/addProductPages/mainAddProduct_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/mainHome_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/notice/main_notice_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/shopPages/mainShop_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/my_page.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import "package:get/get.dart";
import 'package:flutter/material.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';

class MainPageController extends BaseController {

  RxInt selectedIdx = 0.obs;
  RxBool tabChecker = true.obs;
  int backWidget = 0;
  GlobalController _globalController = Get.find<GlobalController>();
  MainAddProductController mainAddProductCtrl = Get.put(MainAddProductController());
  MainAddCareController _addCareController = Get.put(MainAddCareController());
  MainShopController _mainShopController = Get.put(MainShopController());

  //로딩할 위젯들
  List<Widget> widgetOptions = <Widget> [
  ];

  void addPages(){
    if(_globalController.isLogin.value){
      widgetOptions = [
        MainHomePage(),
        MainAddProductPage(),
        MainAddCarePage(),
        MainShopPage(),
        MyPage(),
        MainNoticePage(),
      ];
    }else{
      widgetOptions = [
        MainHomePage(),
      ];
    }
  }

  void backHome(){
    selectedIdx.value = 0;
    update();
  }

  void onItemTaped(int idx)async{
    if(!_globalController.isLogin.value) {
      Get.toNamed('/notLoginPage');
      return;
    }
    if(_addCareController.timer != null){
      _addCareController.timer!.cancel();
    }
    if(selectedIdx.value == 1){
      await Get.dialog(CustomDialogWidget(
        isSingleButton: false,
        content: '제품 등록 진행을 취소하시겠습니까?',
        okTxt: '확인',
        cancelTxt: '취소',
        onClick: () {
          Get.back();
          selectedIdx.value = idx;
        },
        onCancelClick: () {
          Get.back();
          tabChecker.value = false;
        },
      ),
          barrierDismissible: false
      );
    } else if (selectedIdx.value == 2){
      await Get.dialog(
          CustomDialogWidget(
        isSingleButton: false,
        content: '케어/수선 등록을 취소하시겠습니까?',
        okTxt: '확인',
        cancelTxt: '취소',
        onClick: () {
          Get.back();
          selectedIdx.value = idx;
        },
        onCancelClick: () {
          Get.back();
          tabChecker.value = false;
        }
      ),
      barrierDismissible: false
      );
    }
    tabChecker.value == true ? selectedIdx.value = idx : print('');

    print("현재 선택된 idx: ${selectedIdx.value}");
    if(idx == 5){
      MainNoticeController _noticeCtrl = Get.find<MainNoticeController>();
      _noticeCtrl.reqAlarmList();
      _noticeCtrl.type = "not";
      _noticeCtrl.update();
    }
    if(idx != 5) {
      backWidget = idx;
    }
    update();
    if(tabChecker.value && idx == 1){
      print('init');
      mainAddProductCtrl.initInfo();
      mainAddProductCtrl.update();
    }else if(tabChecker.value && idx == 2){
      print('init');
      _addCareController.initInfo();
      _addCareController.update();
    }
    if(idx == 3){
      await _mainShopController.shopListAllCtrl.reqShopList();
      _mainShopController.tabCtrl.index = 0;
    }
    tabChecker.value = true;
    update();
  }
  @override
  void onInit() async{
    addPages();
    super.onInit();
  }
}