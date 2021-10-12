import 'dart:io';

import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/auth/login_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/auth/signUpDialog_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/auth/signupSocial_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

class SignUpDialog extends StatelessWidget {
  const SignUpDialog({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SignUpDialogController controller = Get.put(SignUpDialogController());
    return Dialog(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8.0)
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 19),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                  onTap: (){
                    Get.back();
                  },
                  child: Icon(Icons.clear_outlined, size: 18, color: blackColor,)),
            ),
            const SizedBox(height: 10,),
            SvgPicture.asset('assets/icons/title_logo.svg', width: 131, height: 30, color: primaryColor,),
            const SizedBox(height: 26,),
            if(Platform.isIOS)
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () => controller.loginButton("login_apple.svg"),
                child: _itemSignUpBtn(blackColor, 'join_apple.svg'),
              ),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => controller.loginButton("login_kakao.svg"),
              child: _itemSignUpBtn(kakaoColor, 'join_kakao.svg'),
            ),
            GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => controller.loginButton('login_naver.svg'),
              child: _itemSignUpBtn(naverColor, 'join_naver.svg'),
            ),
            // GestureDetector(
            //   behavior: HitTestBehavior.translucent,
            //   onTap: () => controller.loginButton('join_facebook.svg'),
            //   child: _itemSignUpBtn(facebookColor, 'join_facebook.svg'),
            // ),
            GestureDetector(
              onTap: () => controller.emailJoin(),
              child: _itemSignUpBtn(whiteColor, 'join_email.svg'),
            ),
            const SizedBox(height: 19),
          ],
        ),
      ),
    );
  }
  Widget _itemSignUpBtn(Color color, String asset) => Container(
    width: double.infinity,
    height: 48,
    margin: const EdgeInsets.only(bottom: 12),
    decoration: BoxDecoration(
      color: color,
      borderRadius: BorderRadius.circular(50),
      border: asset.contains('email')? Border.all(color: gray_D5D7DBColor) : null
    ),
    child: Center(
      child: SvgPicture.asset('assets/icons/$asset'),
    ),
  );
}
