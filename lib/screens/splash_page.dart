import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SvgPicture.asset('assets/icons/title_logo.svg', width: 224, height: 48,),
            ),
            Positioned(
              left: 0,
              right:0,
              bottom: 40,
              child: Text(
                'Copyright © 2021 BrandCare Inc. All Rights Reserved.',
                style: regular10TextStyle.copyWith(color: gray_999Color),
                textAlign: TextAlign.center,
              ),
            )
          ],
        ),
      ),
    );
  }
}
