import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CustomArrowBtn extends StatelessWidget {
  const CustomArrowBtn({Key? key,
    required this.title,
    required this.onTap,
    this.radius=30.0,
  }) : super(key: key);

  final double radius;
  final String title;
  final Function() onTap;
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
            SvgPicture.asset('assets/icons/btn_arrow_right.svg'),
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
