import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/notice/main_notice_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/mainPage_controller.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MainNoticePage extends StatelessWidget {
  final controller = Get.put(MainNoticeController());

  @override
  Widget build(BuildContext context) {
    final mainPageCtrl = Get.find<MainPageController>();
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        leading: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: (){
            print("실행됨");
            mainPageCtrl.onItemTaped(mainPageCtrl.backWidget);
          },
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: SvgPicture.asset('assets/icons/btn_arrow_left.svg', width: 18, height: 18,),
          ),
        ),
        title:
            Text("알림", style: medium16TextStyle.copyWith(color: primaryColor)),
        actions: [
          GestureDetector(
            onTap: () {},
            behavior: HitTestBehavior.translucent,
            child: SvgPicture.asset('assets/icons/trash.svg', height: 16),
          ),
          const SizedBox(width: 16),
        ],
        titleSpacing: 0,
        centerTitle: true,
        titleTextStyle: medium16TextStyle.copyWith(color: primaryColor),
        backgroundColor: whiteColor,
        elevation: 4,
        shadowColor: blackColor.withOpacity(0.05),
        automaticallyImplyLeading: false,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              const SizedBox(height: 32),
              ListView.separated(
                padding: const EdgeInsets.only(left: 16, right: 16),
                physics: NeverScrollableScrollPhysics(),
                itemCount: 5,
                shrinkWrap: true,
                itemBuilder: (context, idx) {
                  return _noticeList();
                },
                separatorBuilder: (context, idx) => const Divider(
                  height: 0,
                  thickness: 1,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _noticeList() {
    return GestureDetector(
      onTap: () {},
      child: Container(
        width: double.infinity,
        height: 74,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "케어/수선 신청 현황",
              style: regular14TextStyle,
            ),
            const SizedBox(height: 4),
            Text(
              "제품이 \"택배 수거 진행 중\" 입니다.",
              style: regular12TextStyle.copyWith(color: gray_999Color),
            ),
            const SizedBox(height: 4),
            Text(
              "2021.08.02 03:00 PM",
              style: medium10TextStyle.copyWith(color: gray_666Color),
            ),
          ],
        ),
      ),
    );
  }
}
