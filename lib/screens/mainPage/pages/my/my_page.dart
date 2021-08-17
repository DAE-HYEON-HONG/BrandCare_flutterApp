import 'package:brandcare_mobile_flutter_v2/consts/box_shadow.dart';
import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/global_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/my_controller.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/route_container_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyPage extends StatelessWidget {

  MyPage({Key? key}) : super(key: key);

  final myController = Get.put(MyController());
  final globalController = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    return DefaultAppBarScaffold(
      isLeadingShow: false,
      title: '나의 정보',
      child: SingleChildScrollView(
        child: Column(
          children: [
            _renderProfile(),
          _renderHistory(),
            const SizedBox(height: 14,),
            Divider(
              height: 0,
              thickness: 1,
                color: gray_F5F6F7Color
            ),
            ...myController.linkData.entries.map((e) => _renderLinkItem(e.key, e.value)),
            _renderAdBox(),
          ],
        ),
      ),
    );
  }

  Widget _renderProfile() => Container(
        padding: const EdgeInsets.only(left: 16, top: 32, right: 16),
        child: Row(
          children: [
            Container(
              width: 59,
              height: 50,
              child: Stack(
                children: [
                  Positioned(
                    child:  Container(
                      width: 50,
                      height: 50,
                      child: Center(
                        child: SvgPicture.asset(
                          'assets/icons/mypage_on.svg',
                          width: 25,
                          height: 25,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    right: 0,
                    bottom: 0,
                    child: Container(
                        width: 18,
                        height: 18,
                        decoration: BoxDecoration(
                            color: primaryColor,
                            shape: BoxShape.circle
                        ),
                        child: Center(child: Icon(Icons.edit_outlined, color: whiteColor,size: 8,))),
                  )
                ],
              ),
            ),
            const SizedBox(width: 24,),
            Flexible(
              child: Container(
                height: 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('이재룡 님', style: medium14TextStyle,),
                    const Spacer(),
                    Text('최근접속 2020.12.24 20:45:13', style: regular12TextStyle.copyWith(color: gray_333Color),),
                  ],
                ),
              ),
            )
          ],
        ),
      );

  Widget _renderHistory() => Container(
    margin: const EdgeInsets.only(left: 16, top:25, right:16),
    padding: const EdgeInsets.only(left:24, top: 15, right: 24, bottom: 15),
    decoration: BoxDecoration(
      color: whiteColor,
      borderRadius: BorderRadius.circular(12.h),
      boxShadow: [
        defaultBoxShadow
      ],
    ),
    child: Row(
      // mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        ...myController.myData.map((e) {
          return Flexible(
            child: Container(
              decoration: BoxDecoration(
                border: myController.myData.indexOf(e) != 2 ? Border(
                  right: BorderSide(
                    width: 1,
                    color: gray_F1F3F5Color
                  ),
                ) : null
              ),
              child: Center(
                child: Column(
                  children: [
                    Text('${e.keys.first}', style: regular12TextStyle.copyWith(color: gray_333Color),),
                    const SizedBox(height: 16.5,),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(text: '${e.values.first}', style: medium24TextStyle.copyWith(color: primaryColor)),
                          TextSpan(text: ' 건', style: regular14TextStyle)
                        ]
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        })
      ],
    ),
  );

  Widget _renderLinkItem(String title, String link) {
    return Container(
      margin: const EdgeInsets.only(left: 16, right: 16),
      padding: const EdgeInsets.only(top: 16, bottom: 16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            width: 1,
            color: gray_F5F6F7Color
          )
        )
      ),
      child: RouteContainerWidget(
        title: title, route: link,
      ),
    );
  }

  Widget _renderAdBox() => Container(
    margin: const EdgeInsets.only(left: 16, top: 16, right: 16, bottom: 49),
    padding: const EdgeInsets.only(left: 24, top: 26, bottom: 28),
    height: 94,
    width: double.infinity,
    decoration: BoxDecoration(
      color: gray_AFColor,
      borderRadius: BorderRadius.circular(4),
    ),
    child: Text('나의 소중한 명품\n인증받고, 케어받고, 관심받고', style: medium14TextStyle.copyWith(color: whiteColor),),
  );
}
