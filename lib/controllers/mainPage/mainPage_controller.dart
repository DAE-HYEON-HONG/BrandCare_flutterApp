import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/mainHome_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/my_page.dart';
import "package:get/get.dart";
import 'package:flutter/material.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';

class MainPageController extends BaseController {

  RxInt selectedIdx = 0.obs;

  //로딩할 위젯들
  List<Widget> widgetOptions = <Widget> [
    MainHomePage(),
    MainHomePage(),
    MainHomePage(),
    MainHomePage(),
    MyPage(),
  ];

  void onItemTaped(int idx){
    selectedIdx.value = idx;

    // 대현씨 유물
    // if(idx == 0){
    //   selectedIdx.value = idx;
    // } else if(idx == 1) {
    //   selectedIdx.value = idx;
    // } else if(idx == 2) {
    //   selectedIdx.value = idx;
    // } else if(idx == 3) {
    //   selectedIdx.value = idx;
    // }else{
    //   selectedIdx.value = idx;
    // }

    print("현재 선택된 idx: ${selectedIdx.value}");
    update();
  }

  @override
  void onInit() {
    super.onInit();
  }
}