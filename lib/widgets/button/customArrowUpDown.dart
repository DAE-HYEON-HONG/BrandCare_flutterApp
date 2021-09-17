import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CustomArrowUpDownBtn extends StatelessWidget {
  const CustomArrowUpDownBtn({Key? key,
    required this.title,
    required this.onTap,
    required this.onDown,
    this.radius=30.0,
  }) : super(key: key);

  final double radius;
  final String title;
  final Function() onTap;
  final bool onDown;

  // final Function() onClick;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 48,
      child: ElevatedButton(
        onPressed: () {
          this.onTap();
        },
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(title, style: medium14TextStyle.copyWith(color: primaryColor),),
            const Spacer(),
            !onDown ?
            SvgPicture.asset('assets/icons/btn_arrow_down.svg'):
            SvgPicture.asset('assets/icons/btn_arrow_up.svg'),
          ],
        ),
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all<Color>(whiteColor),
            shape: MaterialStateProperty.all<RoundedRectangleBorder>(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius),
                  side: BorderSide(color: primaryColor)
              ),
            ),
            elevation: MaterialStateProperty.all(0.0)
        ),),
    );
  }
}
