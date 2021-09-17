import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:flutter/material.dart';

class CustomBottomFilter extends StatelessWidget {
  final Function() sort1;
  final Function() sort2;
  final String mode;

  CustomBottomFilter({required this.sort1, required this.sort2, required this.mode});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      color: whiteColor,
      child: Column(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              this.sort1();
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    "최신 순",
                    style: medium14TextStyle,
                  ),
                ],
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              this.sort2();
            },
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    mode == "nameBy" ? "항목별" : "오래된 순",
                    style: medium14TextStyle,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
