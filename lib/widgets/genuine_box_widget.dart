import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:flutter/material.dart';

class GenuineBoxWidget extends StatelessWidget {
  const GenuineBoxWidget({Key? key, required this.isGenuine}) : super(key: key);
  final bool isGenuine;

  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = isGenuine ? medium12TextStyle.copyWith(color: primaryColor) :medium12TextStyle.copyWith(color: whiteColor);
    return Container(
      width: 64,
      height: 24,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        border: isGenuine ? Border.all(color: primaryColor) : null,
        color: isGenuine ? whiteColor : gray_AFColor,
      ),
      child: Text('${isGenuine ? '정품' : '미인증'}', style: textStyle,),
    );
  }
}
