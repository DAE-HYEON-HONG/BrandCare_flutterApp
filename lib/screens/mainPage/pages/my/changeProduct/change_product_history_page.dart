import 'package:brandcare_mobile_flutter_v2/apis/global_api_service.dart';
import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/change_product_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/product/product_change_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/product/product_model.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/changeProduct/change_product_enum.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/genuine_box_widget.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeProductHistoryPage extends StatelessWidget {
  ChangeProductHistoryPage({Key? key}) : super(key: key);

  final controller = Get.put(ChangeProductController());

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
                GetBuilder<ChangeProductController>(
                  builder: (_) => ListView.separated(
                    itemBuilder: (context, idx) => GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          Get.toNamed('/main/my/change_product/history/detail',
                              arguments: {'type': ChangeProductEnum.REQUEST, 'id': controller.sendProductChangeList[idx].id, 'status': 'SEND'});
                        },
                        child: _item(controller.sendProductChangeList[idx])),
                    separatorBuilder: (context, idx) => const Divider(
                      thickness: 1,
                      height: 0,
                    ),
                    itemCount: controller.sendProductChangeList.length,
                    shrinkWrap: true,
                  ),
                ),
                GetBuilder<ChangeProductController>(
                  builder: (_) => ListView.separated(
                    itemBuilder: (context, idx) => GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          Get.toNamed('/main/my/change_product/history/detail',
                              arguments: {'type': ChangeProductEnum.RECEIVED, 'id': controller.receiveProductChangeList[idx].id, 'status': 'RECEIVE'});
                        },
                        child: _item(controller.receiveProductChangeList[idx])),
                    separatorBuilder: (context, idx) => const Divider(
                      thickness: 1,
                      height: 0,
                    ),
                    itemCount: controller.receiveProductChangeList.length,
                    shrinkWrap: true,
                  ),
                ),
                GetBuilder<ChangeProductController>(
                  builder: (_) => ListView.separated(
                    itemBuilder: (context, idx) => GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () {
                          Get.toNamed('/main/my/change_product/history/detail',
                              arguments: {'type': ChangeProductEnum.COMPLETE, 'id': controller.completeProductChangeList[idx].id, 'status': 'COMPLETE'});
                        },
                        child: _item(controller.completeProductChangeList[idx])),
                    separatorBuilder: (context, idx) => const Divider(
                      thickness: 1,
                      height: 0,
                    ),
                    itemCount: controller.completeProductChangeList.length,
                    shrinkWrap: true,
                  ),
                ),
                GetBuilder<ChangeProductController>(
                  builder: (_) => ListView.separated(
                    itemBuilder: (context, idx) =>
                        _item(controller.cancelProductChangeList[idx]),
                    separatorBuilder: (context, idx) => const Divider(
                      thickness: 1,
                      height: 0,
                    ),
                    itemCount: controller.cancelProductChangeList.length,
                    shrinkWrap: true,
                  ),
                )
              ],
            )),
          ],
        ));
  }

  Widget _item(ProductChangeModel productModel) => Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            if(productModel != null &&
                productModel.image != null)
              ExtendedImage.network(GlobalApiService.getImage(
                  productModel.image!),
                width: 72,
                height: 72,
                cache: true,
              )
            else
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
                        '${productModel.brand} | ${productModel.category}',
                        style:
                            regular12TextStyle.copyWith(color: gray_333Color),
                      ),
                      const Spacer(),
                      GenuineBoxWidget(
                          isGenuine: productModel.genuine != 'UNCERTIFIED'),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    '${productModel.title}',
                    style: medium14TextStyle,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              ),
            )
          ],
        ),
      );
}
