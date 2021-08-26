import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/button/custom_button_empty_background_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SignUpCompletePage extends StatelessWidget {
  const SignUpCompletePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Positioned(
              top: 128,
              left: 85,
              right: 85,
              child: Column(
                children: [
                  SvgPicture.asset('assets/icons/ic_welcome.svg'),
                  const SizedBox(height: 16,),
                  Text('축하합니다!\n회원가입이 완료 되었습니다.', style: medium16TextStyle, textAlign: TextAlign.center,)
                ],
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: CustomButtonEmptyBackgroundWidget(
                title: '확인',
                onClick: (){
                    Get.offAndToNamed('/auth/login');
                },
              ),
            )
          ],
        ),
      ),
    );
  }
}
