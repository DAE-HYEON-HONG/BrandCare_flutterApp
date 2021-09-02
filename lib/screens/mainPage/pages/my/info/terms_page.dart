import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/settings/terms_controller.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/button/custom_button_empty_background_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:delayed_widget/delayed_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(TermsController());

    return DefaultAppBarScaffold(
        title: Get.arguments['title'],
        child: GetBuilder<TermsController>(builder: (_) => Container(
          width: double.infinity,
          height: double.infinity,
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: DelayedWidget(
                      delayDuration: Duration(milliseconds: 500),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 80,
                          ),
                          Get.arguments['title'] == "이용약관" ?
                          Text(
                            "${controller.termsList?[0].content ?? ""}",
                            style: regular14TextStyle.copyWith(
                                color: gray_666Color),
                          ):
                          Text(
                            "${controller.termsList?[1].content ?? ""}",
                            style: regular14TextStyle.copyWith(
                                color: gray_666Color),
                          ),
                        ],
                      ),
                    )
                  ),
                ),
              ),
              CustomButtonEmptyBackgroundWidget(
                title: '확인',
                onClick: () {
                  Get.back();
                },
              ),
            ],
          ),
        )
      )
    );
  }
}
