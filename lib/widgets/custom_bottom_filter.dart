import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:flutter/material.dart';

class CustomBottomFilter extends StatelessWidget {
  // final Function() atLeast;
  // final Function() sort;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 150,
      color: whiteColor,
      child: Column(
        children: <Widget>[
          ListTile(
            onTap: () {},
            title: Text(
              "최신 순",
              style: medium14TextStyle,
            ),
          ),
          ListTile(
            onTap: () {},
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
