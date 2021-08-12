import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class RouteContainerWidget extends StatelessWidget {
  final String route;
  final String title;

  const RouteContainerWidget(
      {Key? key, required this.route, required this.title})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(route);
      },
      behavior: HitTestBehavior.translucent,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.only(top: 9.0, bottom: 9.0),
        child: Row(
          children: [
            Text(
              title,
              style: medium14TextStyle,
            ),
            const Spacer(),
            SvgPicture.asset(
              'assets/icons/btn_arrow_right.svg',
              color: gray_666Color,
            )
          ],
        ),
      ),
    );
  }
}
