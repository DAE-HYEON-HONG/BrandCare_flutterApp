import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/button/custom_button_empty_background_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String termTest = '약관 내용입니다' * 10;

    return DefaultAppBarScaffold(title: Get.arguments['title'], child: Container(
      child: Column(
        children: [
          Flexible(
            fit: FlexFit.tight,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    const SizedBox(height: 80,),
                    Text(termTest, style: regular14TextStyle.copyWith(color: gray_666Color),)
                  ],
                ),
              ),
            ),
          ),
          CustomButtonEmptyBackgroundWidget(title: '확인', onClick: (){
             Get.back();
          })
        ],
      ),
    ));
  }
}
