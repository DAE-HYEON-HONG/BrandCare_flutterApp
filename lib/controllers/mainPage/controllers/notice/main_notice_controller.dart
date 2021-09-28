
import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainNoticeController extends BaseController with SingleGetTickerProviderMixin {

  int currentPageIdx = 0;
  late TabController tabCtrl = TabController(length: 4, vsync: this);

  void tabBarListener(int idx) async {
    print("현재 선택된 탭바 idx: $idx");
    currentPageIdx = idx;
    update();
  }

  @override
  void onInit() {
    tabCtrl.addListener(() => tabBarListener(tabCtrl.index));
    super.onInit();
  }

}