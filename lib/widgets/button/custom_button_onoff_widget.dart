import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:flutter/material.dart';

class CustomButtonOnOffWidget extends StatelessWidget {
  const CustomButtonOnOffWidget({Key? key, required this.title, required this.onClick, required this.isOn, this.radius=4}) : super(key: key);

  final String title;
  final Function() onClick;
  final bool isOn;
  final double radius;

  @override
  Widget build(BuildContext context) {
    print('isOn = $isOn');
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: this.onClick,
        child: Text(title,
            style: medium14TextStyle.copyWith(color: isOn ? whiteColor : gray_999Color)),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(isOn ? primaryColor : whiteColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                side: BorderSide(
                  color: isOn ? primaryColor : gray_999Color
                ),
                  borderRadius: BorderRadius.circular(radius)),
            ),
          elevation: MaterialStateProperty.all(0.0),
        ),
      ),
    );
  }
}
