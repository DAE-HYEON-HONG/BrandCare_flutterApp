import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/change_product_controller.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/changeProduct/change_product_enum.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/genuine_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeProductHistoryPage extends StatelessWidget {
  ChangeProductHistoryPage({Key? key}) : super(key: key);

  final controller = Get.find<ChangeProductController>();

  @override
  Widget build(BuildContext context) {
    return DefaultAppBarScaffold(
        title: '제품 사용자 변경 내역',
        child: Column(
          children: [
            SizedBox(
              height: 48,
              child: TabBar(controller: controller.tabController, tabs: [
                Tab(
                  text: '보낸 요청',
                ),
                Tab(text: '받은 요청'),
                Tab(text: '변경 완료'),
                Tab(text: '변경 취소'),
              ]),
            ),
            Flexible(
              child: TabBarView(
                controller: controller.tabController,
                children: [
                  ListView.separated(itemBuilder: (context, idx) => GestureDetector(
                    behavior: HitTestBehavior.translucent,
                    onTap: (){
                      Get.toNamed('/main/my/change_product/history/detail', arguments: {'type': ChangeProductEnum.REQUEST});
                    },
                      child: _item(idx)),
                    separatorBuilder: (context, idx) => const Divider(thickness: 1,height: 0,),
                    itemCount: 10,
                    shrinkWrap: true,
                  ),
                  ListView.separated(itemBuilder: (context, idx) => GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: (){
                        Get.toNamed('/main/my/change_product/history/detail', arguments: {'type': ChangeProductEnum.RECEIVED});
                      },
                      child: _item(idx)),
                    separatorBuilder: (context, idx) => const Divider(thickness: 1,height: 0,),
                    itemCount: 10,
                    shrinkWrap: true,
                  ),
                  ListView.separated(itemBuilder: (context, idx) => GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: (){
                        Get.toNamed('/main/my/change_product/history/detail', arguments: {'type': ChangeProductEnum.COMPLETE});
                      },
                      child: _item(idx)),
                    separatorBuilder: (context, idx) => const Divider(thickness: 1,height: 0,),
                    itemCount: 10,
                    shrinkWrap: true,
                  ),
                  ListView.separated(itemBuilder: (context, idx) => _item(idx),
                    separatorBuilder: (context, idx) => const Divider(thickness: 1,height: 0,),
                    itemCount: 10,
                    shrinkWrap: true,
                  ),
                ],
              )
            ),
          ],
        ));
  }

  Widget _item(int idx) => Container(
    padding: const EdgeInsets.all(16),
    child: Row(
      children: [
        Image.asset(
          'assets/icons/sample_product.png',
          width: 72,
          height: 72,
        ),
        const SizedBox(
          width: 32,
        ),
        Flexible(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    '루이비통 | 가방',
                    style: regular12TextStyle.copyWith(color: gray_333Color),
                  ),
                  const Spacer(),
                  if(idx != 3)
                    GenuineBoxWidget(isGenuine: idx.isEven),
                ],
              ),
              const SizedBox(
                height: 16,
              ),
              Text(
                '나의 에쁜이$idx',
                style: medium14TextStyle,
              )
            ],
          ),
        )
      ],
    ),
  );

}
