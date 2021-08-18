import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/my_controller.dart';
import 'package:brandcare_mobile_flutter_v2/utils/image_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/route_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class MyInfoPage extends StatelessWidget {
  const MyInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myController = Get.find<MyController>();
    return DefaultAppBarScaffold(
        title: '내 정보',
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
        ));
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
          await ImageUtil().getImage();
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
          Text('test01@test.com', style: regular14TextStyle.copyWith(color: gray_999Color),)
        ],
      ),
    ), );
}
