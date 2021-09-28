import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:flutter/material.dart';

class CustomButtonWidget extends StatelessWidget {
  CustomButtonWidget({Key? key,
    required this.onClick,
    required this.title,
    this.radius = 0.0,
    this.isBold = false,
    this.textStyle,
    this.width = double.infinity,
    this.height = 48
  })
      : super(key: key);

  final double radius;
  final String title;
  final Function() onClick;
  final bool isBold;
  final double width;
  final double height;
  TextStyle? textStyle;

  @override
  Widget build(BuildContext context) {
    if(textStyle == null) textStyle = medium16TextStyle;
      return SizedBox(
        width: double.infinity,
        height: height,
        child: ElevatedButton(
          onPressed: this.onClick,
          child: Text(title, overflow: TextOverflow.ellipsis,),
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all<Color>(primaryColor),
              shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(radius)),
              ),
              textStyle: MaterialStateProperty.all<TextStyle>(
                  textStyle!.copyWith(color: whiteColor))),
        ),
      );
  }
}
