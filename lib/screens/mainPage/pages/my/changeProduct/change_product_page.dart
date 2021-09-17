import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/change_product_controller.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/changeProduct/custom_route_button.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/button/customArrowBtn.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeProductPage extends GetView<ChangeProductController> {
  const ChangeProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultAppBarScaffold(
      title: '제품 사용자 변경',
      child: Padding(
        padding: const EdgeInsets.only(left: 16, right: 16, top: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('- 등록한 제품만 사용자 변경 신청을 하실 수 있습니다.', style: medium12TextStyle.copyWith(color: gray_666Color)),
            const SizedBox(height: 10,),
            Text('- 제품 사용자 변경 시 변경할 사용자에게 모든 제품 정보가 이동되며 복구할 수 없습니다.', style: medium12TextStyle.copyWith(color: gray_666Color)),
            const SizedBox(height: 10,),
            Text('- 제품 사용자 변경 내역에서 보낸 요청, 받은 요청, 취소, 완료 내역을 확인하실 수 있습니다.', style: medium12TextStyle.copyWith(color: gray_666Color)),
            const SizedBox(height: 36,),
            CustomArrowBtn(
              title: '제품 사용자 변경 신청',
              onTap: () {
                controller.initInfo();
                Get.toNamed("/main/my/change_product/apply");
              },
            ),
            const SizedBox(height: 16,),
            CustomRouteButton(title: '제품 사용자 변경 내역', route: '/main/my/change_product/history'),
          ],
    ),
      ),
    );
  }

}
