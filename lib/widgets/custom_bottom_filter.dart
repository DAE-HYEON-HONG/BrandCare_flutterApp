import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:flutter/material.dart';

class CustomBottomFilter extends StatelessWidget {
  final Function() sort1;
  final Function() sort2;

  CustomBottomFilter({required this.sort1, required this.sort2});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      color: whiteColor,
      child: Column(
        children: <Widget>[
          ListTile(
            onTap: () => this.sort1(),
            title: Text(
              "최신 순",
              style: medium14TextStyle,
            ),
          ),
          ListTile(
            onTap: () => this.sort2(),
            title: Text(
              "오래된 순",
              style: medium14TextStyle,
            ),
          ),
        ],
      ),
    );
  }
}
