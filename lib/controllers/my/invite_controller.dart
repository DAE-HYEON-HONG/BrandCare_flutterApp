import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/global_controller.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/all.dart';

class InviteController extends BaseController {
  final GlobalController globalCtrl = Get.find<GlobalController>();

  void shareMyCode() async {
    try{
      final isKakao = await isKakaoTalkInstalled();
      if(isKakao) {
        var uri = await LinkClient.instance.customWithTalk(
          62207,
          templateArgs: {
            "title": "${globalCtrl.userInfoModel!.nickName}님이 엄청난 브랜드케어에 초대합니다.",
            "content": "브랜드케어로 자신의 품격있는 브랜드를 지켜보세요!",
            "THUMBNAIL" : "https://upload.wikimedia.org/wikipedia/commons/thumb/2/27/Square_200x200.svg/1200px-Square_200x200.svg.png"
          },
        );
        await LinkClient.instance.launchKakaoTalk(uri);
        return;
      }
      var uri = await LinkClient.instance.customWithWeb(
        62207,
        templateArgs: {
          "title": "${globalCtrl.userInfoModel!.nickName}님이 엄청난 브랜드케어에 초대합니다.",
          "content": "브랜드케어로 자신의 품격있는 브랜드를 지켜보세요!",
          "THUMBNAIL" : "https://upload.wikimedia.org/wikipedia/commons/thumb/2/27/Square_200x200.svg/1200px-Square_200x200.svg.png"
        },
      );
      await launchBrowserTab(uri);
    }catch(e){
      print(e.toString());
    }
  }

  void copyString(String text){
    Clipboard.setData(ClipboardData(text: text));
    Get.snackbar(
      '알림', '복사되었습니다.',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(milliseconds: 900),
    );
  }


  @override
  void onInit() {
    super.onInit();
  }
}