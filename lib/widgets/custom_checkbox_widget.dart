import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CustomCheckBoxWidget extends StatelessWidget {
  const CustomCheckBoxWidget({Key? key, required this.isChecked, this.width=20.0, this.height=20.0})
      : super(key: key);

  final bool isChecked;
  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    String svgAsset = 'assets/icons/';
    svgAsset += isChecked ? 'check_on.svg' :'check_off.svg';
    return SvgPicture.asset(svgAsset, width: width, height: height,);
  }
}
