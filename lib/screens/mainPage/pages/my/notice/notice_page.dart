import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/notice_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/mypage/notice/noticeList_model.dart';
import 'package:brandcare_mobile_flutter_v2/utils/date_format_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_expansion_tile_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NoticePage extends GetView<NoticeController> {
  const NoticePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultAppBarScaffold(
        title: '공지사항',
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: whiteColor,
          child: SingleChildScrollView(
            controller: controller.pagingScroll,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                GetBuilder<NoticeController>(builder: (_) => controller.noticeList!.length != 0 ?
                ListView.separated(
                    physics: NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, idx) {
                      return Divider(
                        height: 0,
                        thickness: 1,
                        color: gray_F5F6F7Color,
                      );
                    },
                    shrinkWrap: true,
                    itemBuilder: (context, idx) {
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0, top: 16.0),
                        child: _item(controller.noticeList![idx]),
                      );

                    },
                    itemCount: controller.noticeList?.length ?? 0
                ) :
                Container(
                  width: double.infinity,
                  height: 150,
                  child: Center(
                    child: Text(
                      "도착한 공지사항이 없어요.",
                      style: regular14TextStyle.copyWith(
                        color: gray_999Color,
                      ),
                    ),
                  ),
                ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 50, bottom: 40),
                  child: Text('Copyright © 2021 BrandCare Inc. All Rights Reserved.', style: regular10TextStyle.copyWith(color: gray_999Color),),
                )
              ],
            ),
          ),
        ));
  }

  Widget _item(NoticeListModel model) => Container(
        child: CustomExpantionTile2(
          isShowShadow: false,
          title: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${DateFormatUtil.convertDateFormat(date: model.createdDate, format: "MM.dd")} ${DateFormatUtil.convertDateFormat(date: model.createdDate, format: "hh:mma")}',
                  style: regular12TextStyle.copyWith(color: gray_999Color),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  model.title,
                  style: medium14TextStyle,
                )
              ],
            ),
          ),
          child: Container(
            width: double.infinity,
            color: whiteColor,
            padding: EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Text(model.content, style: regular14TextStyle.copyWith(color: gray_666Color),),
          ),
        ),
      );
}
