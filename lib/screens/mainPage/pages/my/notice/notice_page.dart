import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/notice_controller.dart';
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
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
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
                    child: _item(),
                  );

                }, itemCount: 15),

                Padding(
                  padding: const EdgeInsets.only(left: 16, top: 50, bottom: 40),
                  child: Text('Copyright © 2021 BrandCare Inc. All Rights Reserved.', style: regular10TextStyle.copyWith(color: gray_999Color),),
                )
              ],
            ),
          ),
        ));
  }

  Widget _item() => Container(
        child: CustomExpantionTile2(
          isShowShadow: false,
          title: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '01.28 3:00a.m.',
                  style: regular12TextStyle.copyWith(color: gray_999Color),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  '시스템 정기점검 알림',
                  style: medium14TextStyle,
                )
              ],
            ),
          ),
          child: Container(
            color: whiteColor,
            padding: EdgeInsets.only(left: 16, right: 16, top: 16),
            child: Text('''금주 주말에 시스템 정기 점검이 있습니다.
작업 시간 동안 시스템 접속이 원활하지 않을 수 있습니다.

*작업일정 : 2021.02.02(화)
*작업시간 : 02~07시
''', style: regular14TextStyle.copyWith(color: gray_666Color),),
          ),
        ),
      );
}
