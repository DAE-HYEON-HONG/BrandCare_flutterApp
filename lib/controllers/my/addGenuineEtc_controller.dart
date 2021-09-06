import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/global_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/addGenuine_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/productInfo_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/product/genuineList_model.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/genuine/addGenuinePayment_page.dart';
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

  double autoHeight (BuildContext context){
    double height = MediaQuery.of(context).viewInsets.bottom == 0 ? 0 : 200;
    return height;
  }

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

  void removeGenuine(GenuinePriceListModel obj){
    priceList.remove(obj);
    update();
  }

  void fillChange(){
    if(des.text != ""){
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