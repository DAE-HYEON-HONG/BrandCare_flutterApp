import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:flutter/material.dart';

class GenuineLogo extends StatelessWidget {
  bool genuine;
  GenuineLogo({required this.genuine});
  @override
  Widget build(BuildContext context) {
    return this.genuine == true ?
    Container(
      width: 64,
      height: 24,
      decoration: BoxDecoration(
        border: Border.all(color: Color(0xff212B62), width: 1),
        borderRadius: BorderRadius.circular(24),
        color: Colors.white,
      ),
      child: Center(
        child: Text(
          "정품",
          style: medium12TextStyle.copyWith(color: primaryColor),
        ),
      ),
    ) : Container(
      width: 64,
      height: 24,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(24),
        color: Color(0xffAFAFAF),
      ),
      child: Center(
        child: Text(
          "미인증",
          style: medium12TextStyle.copyWith(color: whiteColor),
        ),
      ),
    );
  }
}
