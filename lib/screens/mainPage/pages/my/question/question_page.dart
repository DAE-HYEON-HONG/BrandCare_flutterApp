import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/question_controller.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_expansion_tile_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionPage extends GetView<QuestionController> {
  const QuestionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultAppBarScaffold(
        title: '자주 묻는 질문',
        child: Container(
          width: double.infinity,
          height: double.infinity,
          color: whiteColor,
          child: ListView.separated(
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
        ));
  }

  Widget _item() => Container(
    child: CustomExpantionTile2(
      isShowShadow: false,
      title: Container(
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              'Q',
              style: medium14TextStyle.copyWith(color: primaryColor),
            ),
            const SizedBox(
              width: 8,
            ),
            Text(
              '제품 케어 신청이 무엇인가요?',
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
