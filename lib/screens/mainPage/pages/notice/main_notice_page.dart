import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/notice/main_notice_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/mainPage_controller.dart';
import 'package:brandcare_mobile_flutter_v2/utils/date_format_util.dart';
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
        leading: GetBuilder<MainNoticeController>(builder: (_) =>GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: (){
            if(controller.type == "fcm"){
              Get.back();
            }else{
              mainPageCtrl.onItemTaped(mainPageCtrl.backWidget);
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: SvgPicture.asset('assets/icons/btn_arrow_left.svg', width: 18, height: 18,),
          ),
        )),
        title:
            Text("알림", style: medium16TextStyle.copyWith(color: primaryColor)),
        actions: [
          GestureDetector(
            onTap: () => controller.removeAllAlarms(),
            behavior: HitTestBehavior.translucent,
            child: Container(
              width: 16,
              height: 16,
              child: SvgPicture.asset('assets/icons/trash.svg', height: 18),
            )
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
        child: Column(
          children: [
            TabBar(
              indicator: UnderlineTabIndicator(
                borderSide:
                BorderSide(width: 3.0, color: primaryColor),
              ),
              controller: controller.tabCtrl,
              physics: NeverScrollableScrollPhysics(),
              unselectedLabelColor: Color(0xff999999),
              unselectedLabelStyle: regular14TextStyle.copyWith(color: gray_333Color),
              indicatorColor: primaryColor,
              labelColor: primaryColor,
              labelStyle: regular14TextStyle,
              tabs: <Widget>[
                Tab(
                  child: _tabBarText("진행관련"),
                ),
                Tab(
                  child: _tabBarText("제품관련"),
                ),
                Tab(
                  child: _tabBarText("SHOP"),
                ),
                Tab(
                  child: _tabBarText("1:1문의"),
                ),
              ],
            ),
            _renderTabBarView(),
          ],
        )
      ),
    );
  }

  _tabBarText(String title){
    return Center(
      child: Text(
        title,
        style: regular14TextStyle,
      ),
    );
  }

  _noticeList(String content, String type, String createdDate, int id) {
    return GestureDetector(
      behavior: HitTestBehavior.translucent,
      onTap: () => controller.navigator(type, id),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 10, bottom: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "${controller.changeTyper(type)}",
              style: regular14TextStyle,
            ),
            const SizedBox(height: 4),
            Text(
              "$content",
              style: regular12TextStyle.copyWith(color: gray_999Color),
              maxLines: 30,
            ),
            const SizedBox(height: 4),
            Text(
              "${DateFormatUtil.convertDateFormat(date: createdDate, format: "yyyy.MM.dd hh:mm a")}",
              style: medium10TextStyle.copyWith(color: gray_666Color),
            ),
          ],
        )
      ),
    );
  }

  _renderTabBarView() {
    return Expanded(
      child: GetBuilder<MainNoticeController>(builder: (_) => TabBarView(
        controller: controller.tabCtrl,
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              controller: controller.pagingScroll,
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  ListView.separated(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.progressNoticeList!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, idx) {
                      return _noticeList(
                        controller.progressNoticeList![idx].content,
                        controller.progressNoticeList![idx].type,
                        controller.progressNoticeList![idx].createdTime,
                        controller.progressNoticeList![idx].id,
                      );
                    },
                    separatorBuilder: (context, idx) => const Divider(
                      height: 0,
                      thickness: 1,
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              controller: controller.pagingScroll,
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  ListView.separated(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.productNoticeList!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, idx) {
                      return _noticeList(
                        controller.productNoticeList![idx].content,
                        controller.productNoticeList![idx].type,
                        controller.productNoticeList![idx].createdTime,
                        controller.productNoticeList![idx].id,
                      );
                    },
                    separatorBuilder: (context, idx) => const Divider(
                      height: 0,
                      thickness: 1,
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              controller: controller.pagingScroll,
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  ListView.separated(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 0,
                    shrinkWrap: true,
                    itemBuilder: (context, idx) {
                      return _noticeList(
                        controller.shopNoticeList![idx].content,
                        controller.shopNoticeList![idx].type,
                        controller.shopNoticeList![idx].createdTime,
                        controller.shopNoticeList![idx].id,
                      );
                    },
                    separatorBuilder: (context, idx) => const Divider(
                      height: 0,
                      thickness: 1,
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
          Container(
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              controller: controller.pagingScroll,
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  const SizedBox(height: 12),
                  ListView.separated(
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: controller.inquiryNoticeList!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, idx) {
                      return _noticeList(
                        controller.inquiryNoticeList![idx].content,
                        controller.inquiryNoticeList![idx].type,
                        controller.inquiryNoticeList![idx].createdTime,
                        controller.inquiryNoticeList![idx].id,
                      );
                    },
                    separatorBuilder: (context, idx) => const Divider(
                      height: 0,
                      thickness: 1,
                    ),
                  ),
                  const SizedBox(height: 32),
                ],
              ),
            ),
          ),
        ],
      )),
    );
  }
}
