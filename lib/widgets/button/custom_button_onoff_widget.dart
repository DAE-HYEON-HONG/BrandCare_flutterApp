import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:flutter/material.dart';

class CustomButtonOnOffWidget extends StatelessWidget {
  const CustomButtonOnOffWidget({Key? key, required this.title, required this.onClick, required this.isOn}) : super(key: key);

  final String title;
  final Function() onClick;
  final bool isOn;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: this.onClick,
      child: Text(title),
      style: ButtonStyle(
          backgroundColor: MaterialStateProperty.all<Color>(isOn ? primaryColor : gray_CCCColor),
          shape: MaterialStateProperty.all<RoundedRectangleBorder>(
            RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(4)),
          ),
          textStyle: MaterialStateProperty.all<TextStyle>(
              medium14TextStyle.copyWith(color: whiteColor))),
    );
  }
}
