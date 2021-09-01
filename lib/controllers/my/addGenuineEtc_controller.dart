import 'dart:async';

import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/global_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/addGenuine_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/productInfo_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/mypage/genuine/genuineList_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/product/addGenuineList_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/product/genuineList_model.dart';
import 'package:brandcare_mobile_flutter_v2/providers/auth_provider.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/product/addGenuinePayment_page.dart';
import 'package:brandcare_mobile_flutter_v2/utils/regex_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddGenuineEtcController extends BaseController {

  final globalCtrl = Get.find<GlobalController>();
  final addGenuineCtrl = Get.find<AddGenuineController>();
  final productInfoDetailCtrl = Get.find<ProductInfoDetailController>();

  List<GenuinePriceListModel>? genuineList = [
    GenuinePriceListModel("정품인증", 2, 29000),
  ];

  List<GenuinePriceListModel> priceList = <GenuinePriceListModel> [];


  TextEditingController productName = TextEditingController();
  TextEditingController serialCode = TextEditingController();
  TextEditingController buyDate = TextEditingController();
  TextEditingController des = TextEditingController();

  int firstGenuine = 0;
  int secondGenuine = 0;

  RxBool fill = false.obs;

  void changeFirstGenuine(int idx){
    firstGenuine = idx;
    priceList.add(GenuinePriceListModel("정품인증", 1, 29000));
    update();
  }

  void changeSecondGenuine(int idx){
    secondGenuine = idx;
    priceList.add(GenuinePriceListModel("정품인증", 2, 29000));
    update();
  }

  void fillChange(){
    if(des.text != "" && productName.text != "" && serialCode.text != "" && buyDate.text != ""){
      fill.value = true;
      update();
    }else{
      fill.value = false;
      update();
    }
  }

  void nextLevel(){
    if(fill.value){
      Get.to(AddGenuinePaymentPage());
    }
  }

  int addPrices(){
    int price = 0;
    int length = priceList.length;
    for(var i = 0; i < length; i++){
      price += priceList[i].price;
    }
    return price;
  }

  @override
  void onInit() {
    super.onInit();

  }
}