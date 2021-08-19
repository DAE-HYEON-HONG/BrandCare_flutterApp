import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:flutter/material.dart';

class InvitePage extends StatelessWidget {
  const InvitePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultAppBarScaffold(title: '친구 초대', child: Container(
      child: Center(
        child: Text('초대 이벤트 페이지 구성 필요\n개인 초대 코드(회원 고유번호) 발급 및 카카오톡 공유 기능 검토'
        , style: medium24TextStyle.copyWith(color: gray_666Color),
        ),
      ),
    ));
  }
}
