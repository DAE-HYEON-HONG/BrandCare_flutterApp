import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:flutter/material.dart';

class CustomButtonEmptyBackgroundWidget extends StatelessWidget {
  const CustomButtonEmptyBackgroundWidget(
      {Key? key, required this.title, this.radius = 0.0, required this.onClick})
      : super(key: key);

  final double radius;
  final String title;
  final Function() onClick;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: this.onClick,
      child: Text(title),
      style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all<Color>(whiteColor),
      shape: MaterialStateProperty.all<RoundedRectangleBorder>(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radius),
          side: BorderSide(color: primaryColor)
        ),
      ),
        textStyle: MaterialStateProperty.all<TextStyle>(medium14TextStyle.copyWith(color: primaryColor))
    ),);
  }
}
