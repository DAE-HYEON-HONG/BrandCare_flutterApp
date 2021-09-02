import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/mypage/banner/banner_model.dart';
import 'package:brandcare_mobile_flutter_v2/providers/my_provider.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainHomeController extends BaseController{

  List<BannerModel>? bannerList = <BannerModel>[];

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

  void useInfo(int index){
    Get.toNamed('/mainPage/useInfo/main', arguments: {'index': index});
  }

  Future<void> reqBannerList() async {
    final res =  await MyProvider().getBanner("MAIN");
    if(res == null){
      Get.dialog(
          CustomDialogWidget(content: '서버와 접속이 원할 하지 않습니다.', onClick: (){
            Get.back();
            update();
          })
      );
    }else{
      print(res.toString());
      bannerList = (res['data'] as List).map((e) => BannerModel.fromJson(e)).toList();
      update();
    }
    update();
  }

  @override
  void onInit() async{
    await reqBannerList();
    super.onInit();
  }
}