import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/MainHome_page.dart';
import "package:get/get.dart";
import 'package:flutter/material.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';

class MainPageController extends BaseController {

  RxInt selectedIdx = 0.obs;

  //로딩할 위젯들
  List<Widget> widgetOptions = <Widget> [
    MainHome(),
    MainHome(),
    MainHome(),
    MainHome(),
    MainHome(),
  ];

  void onItemTaped(int idx){
    if(idx == 0){
      selectedIdx.value = idx;
    } else if(idx == 1) {
      selectedIdx.value = idx;
    } else if(idx == 2) {
      selectedIdx.value = idx;
    } else if(idx == 3) {
      selectedIdx.value = idx;
    }else{
      selectedIdx.value = idx;
    }
    print("현재 선택된 idx: ${selectedIdx.value}");
    update();
  }

  @override
  void onInit() {
    super.onInit();
  }
}