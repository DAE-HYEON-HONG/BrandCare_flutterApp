import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class InvitePage extends StatelessWidget {
  const InvitePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultAppBarScaffold(
      title: '친구 초대',
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset('assets/icons/title_logo.svg', width: 131, height: 30, color: primaryColor),
            const SizedBox(height: 40),
            Text("새로운 기능으로 탄생하기 위해서\n준비중인 기능이에요"
              , style: medium16TextStyle.copyWith(color: gray_666Color),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
