import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class CustomChkAddress extends StatelessWidget {
  final String title;
  final String postCode;
  final String address;
  final String detail;
  final bool isChecked;
  final Function() onTap;

  CustomChkAddress({
    required this.onTap,
    required this.title,
    required this.postCode,
    required this.address,
    required this.detail,
    required this.isChecked,
  });
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        this.onTap();
      },
      child: Container(
        width: double.infinity,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "$title",
                  style: medium14TextStyle.copyWith(color: primaryColor),
                ),
                const SizedBox(height: 4),
                Container(
                  width: double.infinity,
                  height: 1,
                  color: primaryColor,
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('내 주소', style: medium12TextStyle.copyWith(color: gray_999Color)),
                      Text(
                        '$postCode, $address $detail', style: regular12TextStyle.copyWith(color: gray_999Color),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 10),
                SvgPicture.asset(
                  isChecked ? 'assets/icons/check_on.svg' : 'assets/icons/check_off.svg',
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Divider(height: 1, color: gray_f5f6f7Color),
          ],
        ),
      ),
    );
  }
}
