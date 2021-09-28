import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/invite_controller.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class InvitePage extends GetView<InviteController> {
  const InvitePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultAppBarScaffold(
      title: '친구 초대 하기',
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                Padding(
                  padding: const EdgeInsets.only(left: 22, right: 22),
                  child: Container(
                    width: double.infinity,
                    height: 104,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          offset: Offset(0, 5),
                          color: Color.fromRGBO(0, 0, 0, 0.18),
                          blurRadius: 8.0,
                        ),
                      ],
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(14),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text("친구 초대 포인트", style: regular12TextStyle.copyWith(color: whiteColor)),
                          Row(
                            mainAxisSize: MainAxisSize.max,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text("3,000원 적립", style: medium24TextStyle.copyWith(fontSize: 28, color: whiteColor, fontWeight: FontWeight.w900),),
                              Text("브랜드케어", style: regular12TextStyle.copyWith(color: whiteColor)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 26),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text("초대 받은 친구가 회원가입 시", style: regular14TextStyle.copyWith(fontSize: 18, color: gray_333Color)),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("각각 3,000포인트", style: medium16TextStyle.copyWith(fontSize: 18, color: primaryColor, fontWeight: FontWeight.w700)),
                        Text("를 드립니다.", style: regular14TextStyle.copyWith(fontSize: 18, color: gray_333Color)),
                      ],
                    ),
                  ],
                ),
                const SizedBox(height: 53),
                Text("참여 방법", style: medium16TextStyle.copyWith(color: gray_333Color, fontWeight: FontWeight.w700)),
                const SizedBox(height: 12),
                Text("1. 친구에게 브랜드케어를 공유", style: medium12TextStyle.copyWith(color: gray_333Color)),
                const SizedBox(height: 16),
                Text("2. 초대받은 친구가 회원가입 시 내가 보내준 초대코드를 입력", style: medium12TextStyle.copyWith(color: gray_333Color)),
                const SizedBox(height: 16),
                Text("3. 회원가입 완료 후 각각 포인트 지급", style: medium12TextStyle.copyWith(color: gray_333Color)),
                const SizedBox(height: 49),
                const Divider(height: 2, color: gray_8E8F95Color),
                const SizedBox(height: 29),
                Container(
                  width: double.infinity,
                  height: 198,
                  padding: const EdgeInsets.all(24),
                  decoration: BoxDecoration(
                    color: whiteColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        offset: Offset(0, 2),
                        color: Color.fromRGBO(0, 0, 0, 0.09),
                        blurRadius: 8.0,
                      ),
                    ],
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text("나의 초대 코드", style: medium16TextStyle.copyWith(color: gray_333Color, fontWeight: FontWeight.w600)),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text("ABCD1234", style: medium24TextStyle.copyWith(color: primaryColor, fontSize: 32, fontWeight: FontWeight.w700)),
                          const SizedBox(width: 10),
                          GestureDetector(
                            behavior: HitTestBehavior.translucent,
                            onTap: () => controller.copyString("ABCD1234"),
                            child: Container(
                              width: 50,
                              height: 27,
                              decoration: BoxDecoration(
                                border: Border.all(width: 1, color: gray_999Color),
                                borderRadius: BorderRadius.circular(5),
                              ),
                              child: Center(
                                child: Text("복사", style: medium16TextStyle.copyWith(color: gray_333Color)),
                              ),
                            ),
                          ),
                        ],
                      ),
                      GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () => controller.shareMyCode(),
                        child: Container(
                          width: double.infinity,
                          height: 48,
                          decoration: BoxDecoration(
                            color: Color(0xffFFE812),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              SvgPicture.asset("assets/icons/login_kakao.svg"),
                              const SizedBox(width: 1),
                              Text("카카오톡으로 공유", style: medium16TextStyle.copyWith(color: brown_3B2725)),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 35),
                const Divider(height: 2, color: gray_8E8F95Color),
                const SizedBox(height: 44),
                Text("주의 사항", style: medium16TextStyle.copyWith(color: gray_333Color, fontWeight: FontWeight.w700)),
                const SizedBox(height: 12),
                Text("1. 신규 가입 회원만 인정 됩니다.", style: medium12TextStyle.copyWith(color: gray_333Color)),
                const SizedBox(height: 16),
                Text("2. 초대 가능한 친구 수의 제한은 없습니다.", style: medium12TextStyle.copyWith(color: gray_333Color)),
                const SizedBox(height: 16),
                Text("3. 포인트는 회원가입 완료 즉시 적립됩니다.", style: medium12TextStyle.copyWith(color: gray_333Color)),
                const SizedBox(height: 16),
                Text("4. 중복가입 회원에게는 적용되지 않습니다.", style: medium12TextStyle.copyWith(color: gray_333Color)),
                const SizedBox(height: 16),
                Text("5. 해당 이벤트는 사전고지 없이 변경 또는 중단될 수 있습니다.", style: medium12TextStyle.copyWith(color: gray_333Color)),
                const SizedBox(height: 76),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
