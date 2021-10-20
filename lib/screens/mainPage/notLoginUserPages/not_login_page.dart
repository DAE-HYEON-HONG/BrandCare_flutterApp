import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/route_container_widget.dart';
import 'package:flutter/material.dart';

class NotLoginPage extends StatelessWidget {
  const NotLoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final String desc = '고객님의 소중한 명품의 가치를 더욱 높여드립니다.'
        '\n오랫동안 간직하고 관리할 수 있는 방법은 브랜드케어입니다.'
        '\n사업자정보'
        '\n상호 : (주) 리드고'
        '\n대표 : 박명관'
        '\n주소 : 서울특별시 구로구 디지털로 33길 28, 1211호'
        '\n사업자등록번호 : 816-81-02299'
        '\n통신판매업신고번호 : 제2021-서울구로-0433호';

    return DefaultAppBarScaffold(title: '로그인 안내', child: SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 40,),
            Text('로그인 하신 후 이용하실 수 있습니다.', style: medium12TextStyle,),
            const SizedBox(height: 47,),
            RouteContainerWidget(route: '/auth/login', title: '로그인 페이지로 이동하시겠습니까?', isRoot: true),
            const SizedBox(height: 9),
            const Divider(thickness: 1, height: 0,),
            const SizedBox(height: 47,),
            RouteContainerWidget(route: '/main/my/notice', title: '공지사항'),
            RouteContainerWidget(route: '/main/my/question', title: '자주 묻는 질문'),
            const SizedBox(height: 29,),
            RouteContainerWidget(route: '/main/my/term', title: '이용약관',arguments: {'title': '이용약관'},),
            RouteContainerWidget(route: '/main/my/term', title: '개인정보 취급방침',arguments: {'title': '개인정보 취급방침'},),
            const SizedBox(height: 40,),
            Text('브랜드케어', style: medium12TextStyle.copyWith(color: gray_999Color),),
            const SizedBox(height: 12,),
            Text(desc,
            style: regular10TextStyle.copyWith(color: gray_999Color),),
            const SizedBox(height: 30),
          ],
        ),
      ),
    ));
  }
}
