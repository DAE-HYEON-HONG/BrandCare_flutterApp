import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/question_controller.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/button/custom_button_empty_background_widget.dart';
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GetBuilder<QuestionController>(builder: (_) => Expanded(
                child: controller.qnaList?.length != 0 ?
                ListView.separated(
                  controller: controller.pagingScroll,
                    separatorBuilder: (context, idx) {
                      return Divider(
                        height: 0,
                        thickness: 1,
                        color: gray_F5F6F7Color,
                      );
                    },
                    shrinkWrap: true,
                    itemBuilder: (context, idx) {
                      if(idx == controller.qnaList?.length) {
                        return Padding(
                          padding: const EdgeInsets.only(left: 16, top: 50, bottom: 40),
                          child: Text('Copyright © 2021 BrandCare Inc. All Rights Reserved.', style: regular10TextStyle.copyWith(color: gray_999Color),),
                        );
                      }
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 16.0, top: 16.0),
                        child: _item(
                          controller.qnaList?[idx].question ?? "",
                          controller.qnaList?[idx].answer ?? "",
                        ),
                      );

                    }, itemCount: controller.qnaList?.length ?? 0
                ):
                Container(
                  width: double.infinity,
                  height: 150,
                  child: Center(
                    child: Text(
                      "자주묻는 질문이 없어요.",
                      style: regular14TextStyle.copyWith(
                        color: gray_999Color,
                      ),
                    ),
                  ),
                ),
              )),
              Spacer(),
              if(controller.globalCtrl.isLogin.value)
              CustomButtonEmptyBackgroundWidget(title: '1:1 문의', onClick: (){
                Get.offAndToNamed('/main/my/inquiry');
              }),
            ],
          ),
        ));
  }

  Widget _item(String title, String contents) => Container(
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
              '$title',
              style: medium14TextStyle,
            )
          ],
        ),
      ),
      child: Container(
        width: double.infinity,
        color: whiteColor,
        padding: EdgeInsets.only(left: 16, right: 16, top: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(contents, style: regular14TextStyle.copyWith(color: gray_666Color),),
          ],
        ),
      ),
    ),
  );
}
