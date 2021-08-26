import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/global_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/my_controller.dart';
import 'package:brandcare_mobile_flutter_v2/utils/image_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/route_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class MyInfoPage extends StatelessWidget {
  MyInfoPage({Key? key}) : super(key: key);

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
                      child: RouteContainerWidget(title: e.key, route: e.value,));
                }),
              ],
            ),
          ),
        ),
    );
  }

  Widget _renderProfileContainer(String title) => Container(
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
              SvgPicture.asset(
                'assets/icons/mypage_on.svg',
              )
            ],
          ),
        ),
      ), );

  _loadAssetsMode(){
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
        children: [
          Text(
            title,
            style: medium14TextStyle,
          ),
          const Spacer(),
          Text(globalCtrl.userInfoModel.email, style: regular14TextStyle.copyWith(color: gray_999Color),)
        ],
      ),
    ), );
}
