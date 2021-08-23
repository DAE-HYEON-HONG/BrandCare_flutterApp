import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddCareEtcController extends BaseController{
  RxBool fill = false.obs;
  TextEditingController etcDescription = TextEditingController();

  void nextLevel(){
    Get.toNamed('/mainAddCare/add/payment');
  }

  @override
  void onInit() {
    super.onInit();
  }
}