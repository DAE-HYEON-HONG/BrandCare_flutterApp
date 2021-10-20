import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/global_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/addGenuine_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/productInfo_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/payment/genuine_price_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/product/genuineList_model.dart';
import 'package:brandcare_mobile_flutter_v2/providers/product_provider.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/genuine/addGenuinePayment_page.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddGenuineEtcController extends BaseController {

  final globalCtrl = Get.find<GlobalController>();
  final productInfoDetailCtrl = Get.find<ProductInfoDetailController>();
  final genuinePriceController = Get.find<GenuinePriceController>();

  List<GenuinePriceListModel>? genuineList = [
    GenuinePriceListModel("정품인증", 2, 29000),
  ];

  List<GenuinePriceListModel> priceList = <GenuinePriceListModel> [];


  TextEditingController productName = TextEditingController();
  TextEditingController serialCode = TextEditingController();
  TextEditingController buyDate = TextEditingController();
  TextEditingController des = TextEditingController();

  int firstGenuine = 0;

  RxBool fill = false.obs;

  double autoHeight (BuildContext context){
    double height = MediaQuery.of(context).viewInsets.bottom == 0 ? 0 : 200;
    return height;
  }

  void changeFirstGenuine(int idx){
    if(priceList.length != 1){
      firstGenuine = idx;
      priceList.add(GenuinePriceListModel("정품인증", 1, genuinePriceController.genuinePrice.value));
      update();
    }
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
      Get.to(() => AddGenuinePaymentPage());
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

  // Future<void> reqGenuineStatus() async {
  //   try{
  //     super.networkState.value = NetworkStateEnum.LOADING;
  //     final res =  await ProductProvider().genuineStatus(productIdx);
  //     if(res == null){
  //       Get.dialog(
  //           CustomDialogWidget(content: '서버와 접속이 원할 하지 않습니다.', onClick: (){
  //             Get.back();
  //             update();
  //           })
  //       );
  //       super.networkState.value = NetworkStateEnum.DONE;
  //       Get.back();
  //     }else{
  //       genuineStatus = GenuineStatusModel.fromJson(res);
  //       dateStatus = CareStatusDateModel.fromJson(res);
  //       super.networkState.value = NetworkStateEnum.DONE;
  //       update();
  //     }
  //   }catch(e){
  //     print(e);
  //     super.networkState.value = NetworkStateEnum.ERROR;
  //   }
  // }

  @override
  Future<void> onInit() async {
    priceList.add(GenuinePriceListModel("정품인증", 1, genuinePriceController.genuinePrice.value));
    super.onInit();

  }
}