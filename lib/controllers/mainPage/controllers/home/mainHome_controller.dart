import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/mypage/banner/banner_model.dart';
import 'package:brandcare_mobile_flutter_v2/providers/my_provider.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

class MainHomeController extends BaseController{

  List<BannerModel>? bannerList = <BannerModel>[];

  Rx<int> pageNum = 0.obs;

  void launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void changeBannerImg(int idx) {
    print(idx);
    this.pageNum.value = idx;
    update();
  }

  void useInfo(int index, String title){
    Get.toNamed('/mainPage/useInfo/main', arguments: {'index': index, 'title' : title});
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