import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/shopControllers/shopListController/mainShopListAll_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/shopControllers/shopListController/mainShopListInst_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/shopControllers/shopListController/mainShopListMine_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainShopController extends BaseController with SingleGetTickerProviderMixin {

  int currentPageIdx = 0;
  final shopListAllCtrl = Get.put(MainShopListAllController());
  final shopListMineCtrl = Get.put(MainShopListMineController());
  final shopListInstCtrl = Get.put(MainShopListInstController());
  TextEditingController searchWord = TextEditingController();

  late TabController tabCtrl = TabController(length: 3, vsync: this);
  late ScrollController scrollViewCtrl = ScrollController();
  final focusNode = FocusScopeNode();

  void tabBarListener(int idx) async {
    print("현재 선택된 탭바 idx : $idx");
    currentPageIdx = idx;
    update();
    if(idx == 0){
      await shopListAllCtrl.reqShopList();
    }else if(idx == 1){
      await shopListMineCtrl.reqShopList();
    }else{
      await shopListInstCtrl.reqShopList();
    }
  }

  void reqSearchWord()async{
    if(currentPageIdx == 0){
      shopListAllCtrl.searchWordCtrl = searchWord;
      shopListAllCtrl.update();
      await shopListAllCtrl.reqShopList();
    }else if(currentPageIdx == 1){
      shopListMineCtrl.searchWordCtrl = searchWord;
      shopListMineCtrl.update();
      await shopListMineCtrl.reqShopList();
    }else{
      shopListInstCtrl.searchWordCtrl = searchWord;
      shopListInstCtrl.update();
      await shopListInstCtrl.reqShopList();
    }
  }

  @override
  void onInit() {
    tabCtrl.addListener(() => tabBarListener(tabCtrl.index));
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }
}