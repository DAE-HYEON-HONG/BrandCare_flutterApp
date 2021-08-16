import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainHomeController extends BaseController{

  Rx<int> pageNum = 0.obs;
  List<String> bannerImageList = [
    "https://www.hdcarwallpapers.com/walls/kia_seltos_x_line_concept_2020_5k-HD.jpg",
    "https://images4.alphacoders.com/110/1104217.jpg",
    "https://www.hdcarwallpapers.com/walls/kia_seltos_x_line_concept_2020_5k-HD.jpg",
    "https://www.hdcarwallpapers.com/walls/kia_seltos_x_line_concept_2020_5k-HD.jpg",
  ];

  void changeBannerImg(int idx) {
    this.pageNum.value = idx;
    update();
  }

  @override
  void onInit() {
    super.onInit();
  }
}