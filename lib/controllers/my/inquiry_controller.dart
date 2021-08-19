import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/onetoone_inquiry/inquiry_list_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/onetoone_inquiry/inquiry_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InquiryController extends BaseController with SingleGetTickerProviderMixin {
  late TabController tabController;

  Rx<String> title = ''.obs;
  Rx<String> content = ''.obs;

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
  }

  bool get isOn => title.value.isNotEmpty && content.value.isNotEmpty;
}