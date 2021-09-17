import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/notLoginUserPages/useInfoPages/useInfoDelivery_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/notLoginUserPages/useInfoPages/useInfoDescription_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/notLoginUserPages/useInfoPages/useInfoEvent_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/notLoginUserPages/useInfoPages/useInfoPrice_page.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UseInfoMainController extends BaseController{

  Rx<String> currentAppBarTitle = "가격표".obs;
  Rx<int> currentPageIdx = 0.obs;

  //로딩할 위젯들
  List<Widget> widgetOptions = <Widget> [
    UseInfoPricePage(),
    UseInfoDescriptionPage(),
    UseInfoDeliveryPage(),
    UseInfoEventPage(),
  ];

  void changeWidget(int idx, String title) {
    this.currentPageIdx.value = idx;
    this.currentAppBarTitle.value = title;
    update();
  }

  void initTitle(){
    this.currentAppBarTitle.value = Get.arguments['title'];
  }

  @override
  void onInit() {
    initTitle();
    super.onInit();
  }
}