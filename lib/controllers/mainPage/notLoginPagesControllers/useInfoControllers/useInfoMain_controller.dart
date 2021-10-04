import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/splash_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/care/careCategory_model.dart';
import 'package:brandcare_mobile_flutter_v2/providers/care_provider.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/notLoginUserPages/useInfoPages/useInfoDelivery_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/notLoginUserPages/useInfoPages/useInfoDescription_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/notLoginUserPages/useInfoPages/useInfoEvent_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/notLoginUserPages/useInfoPages/useInfoPrice_page.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../global_controller.dart';

class UseInfoMainController extends BaseController{

  Rx<String> currentAppBarTitle = "가격표".obs;
  Rx<int> currentPageIdx = 0.obs;
  final GlobalController globalCtrl = Get.find<GlobalController>();


  //로딩할 위젯들
  List<Widget> widgetOptions = <Widget> [
    UseInfoPricePage(),
    UseInfoDescriptionPage(),
    UseInfoDeliveryPage(),
    UseInfoEventPage(),
  ];

  void changeWidget(int idx, String title) async{
    this.currentPageIdx.value = idx;
    this.currentAppBarTitle.value = title;
    if(idx == 0){
      print("실행됨");
      await globalCtrl.reqCareCategory();
    }
    update();
  }

  void initTitle(){
    this.currentAppBarTitle.value = Get.arguments['title'];
  }

  @override
  void onInit() async{
    await globalCtrl.reqCareCategory();
    initTitle();
    super.onInit();
  }
}