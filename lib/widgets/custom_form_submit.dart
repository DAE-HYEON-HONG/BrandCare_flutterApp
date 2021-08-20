import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:flutter/material.dart';
import 'dart:io';

class CustomFormSubmit extends StatelessWidget {

  String title;
  bool fill = false;
  final Function() onTab;

  CustomFormSubmit({
    required this.title,
    required this.onTab,
    required this.fill,
  });
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        this.onTab();
      },
      child: Container(
        width: double.infinity,
        height: Platform.isIOS ? 70 : 60,
        decoration: BoxDecoration(
          border: Border.all(
            color: this.fill == false ? gray_999Color : primaryColor,
            width: 1,
          ),
          color: this.fill == false ? whiteColor : primaryColor,
        ),
        child: Center(
          child: Text(
            this.title,
            style: medium14TextStyle.copyWith(
              color: this.fill == false ? gray_999Color : whiteColor,
            ),
          ),
        ),
      ),
    );
  }
}
