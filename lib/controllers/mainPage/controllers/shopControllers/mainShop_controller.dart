import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainShopController extends BaseController with SingleGetTickerProviderMixin {

  late TabController tabCtrl = TabController(length: 3, vsync: this);
  late ScrollController scrollViewCtrl = ScrollController();
  final focusNode = FocusScopeNode();

  @override
  void onInit() {
    super.onInit();
  }
}