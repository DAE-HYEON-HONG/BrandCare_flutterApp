import 'package:brandcare_mobile_flutter_v2/apis/base_api_service.dart';
import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/global_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/my_controller.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/route_container_widget.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class MyInfoPage extends StatelessWidget {
  //MyInfoPage({Key? key}) : super(key: key);

  final globalCtrl = Get.find<GlobalController>();
  final myController = Get.find<MyController>();
  @override
  Widget build(BuildContext context) {
    return DefaultAppBarScaffold(
        title: '내 정보',
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                ...myController.infoLinkData.entries.map((e){
                  if(e.value == 'profile') return _renderProfileContainer(e.key);
                  else if(e.value == 'email') return _renderEmailContainer(e.key);
                  return Container(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    decoration: BoxDecoration(
                        border: Border(
                            bottom: BorderSide(
                                width: 1,
                                color: gray_F5F6F7Color
                            )
                        )
                    ),
                    child: RouteContainerWidget(title: e.key, route: e.value, onTap: () {myController.initMyController();},),
                  );
                }),
              ],
            ),
          ),
        ),
    );
  }

  Widget _renderProfileContainer(String title) => GetBuilder<MyController>(builder: (_) => Container(
    padding: const EdgeInsets.symmetric(vertical: 16),
    decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
                width: 1,
                color: gray_F5F6F7Color
            )
        )
    ),
    child: GestureDetector(
      onTap: () async {
        myController.initMyController();
        await _loadAssetsMode();
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 9.0, bottom: 9.0),
        child: Row(
          children: [
            Text(
              title,
              style: medium14TextStyle,
            ),
            const Spacer(),
            myController.myProfileInfoModel?.profile == null ?
            SvgPicture.asset(
              'assets/icons/mypage_on.svg',
            ):
            Container(
              width: 50,
              height: 50,
              child: ClipOval(
                child: ExtendedImage.network(
                  BaseApiService.imageApi+myController.myProfileInfoModel!.profile!,
                  fit: BoxFit.cover,
                  cache: true,
                  // ignore: missing_return
                  loadStateChanged: (ExtendedImageState state) {
                    switch(state.extendedImageLoadState) {
                      case LoadState.loading :
                        break;
                      case LoadState.completed :
                        break;
                      case LoadState.failed :
                        break;
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    ), ));

  _loadAssetsMode() async{
    bool permissionChk = await myController.permissionChk();
    print(permissionChk);
    if (!permissionChk) {
      Get.snackbar(
        '권한 알림',
        '카메라 및 갤러리 권한이 필요합니다.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(milliseconds: 1200),
      );
      //Future.delayed(Duration(milliseconds: 900), () => Get.back());
      return;
    }
    return Get.bottomSheet(
      Container(
        width: double.infinity,
        height: 150,
        color: whiteColor,
        child: Column(
          children: <Widget>[
            ListTile(
              onTap: () async => await myController.loadAssets(ImageSource.camera),
              title: Text(
                "직접 촬영",
                style: medium14TextStyle,
              ),
            ),
            ListTile(
              onTap: () async => await myController.loadAssets(ImageSource.gallery),
              title: Text(
                "갤러리에서 사진 선택",
                style: medium14TextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _renderEmailContainer(String title) => Container(
    padding: const EdgeInsets.symmetric(vertical: 16),
    decoration: BoxDecoration(
        border: Border(
            bottom: BorderSide(
                width: 1,
                color: gray_F5F6F7Color
            )
        )
    ),
    child: Container(
      width: double.infinity,
      padding: const EdgeInsets.only(top: 9.0, bottom: 9.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: medium14TextStyle,
          ),
          const SizedBox(width: 10),
          if(globalCtrl.userInfoModel?.socialType == "KAKAO")
            ClipOval(
              child: SvgPicture.asset("assets/icons/btn_kakao.svg", height: 24),
            ),
          if(globalCtrl.userInfoModel?.socialType == "FACEBOOK")
            ClipOval(
              child: SvgPicture.asset("assets/icons/btn_facebook.svg", height: 24),
            ),
          if(globalCtrl.userInfoModel?.socialType == "APPLE")
            ClipOval(
              child: SvgPicture.asset("assets/icons/btn_apple.svg", height: 24),
            ),
          if(globalCtrl.userInfoModel?.socialType == "NAVER")
            ClipOval(
              child: SvgPicture.asset("assets/icons/btn_naver.svg", height: 24),
            ),
          const Spacer(),
          Text(globalCtrl.userInfoModel?.email ?? '', style: regular14TextStyle.copyWith(color: gray_999Color),),
        ],
      ),
    ), );
}
