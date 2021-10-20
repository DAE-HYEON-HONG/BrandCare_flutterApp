import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/shopControllers/shopListController/mainShopListInst_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/shopControllers/shopListController/mainShopListMine_controller.dart';
import 'package:brandcare_mobile_flutter_v2/utils/date_format_util.dart';
import 'package:brandcare_mobile_flutter_v2/utils/number_format_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/shop_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainShopListInstPage extends StatelessWidget {
  final MainShopListInstController controller =
      Get.put(MainShopListInstController());

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            GetBuilder<MainShopListInstController>(
              builder: (_) => controller.shopList!.length != 0
                  ? ListView.separated(
                      controller: controller.pagingScroll,
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: const EdgeInsets.only(left: 16, right: 16),
                      separatorBuilder: (context, idx) {
                        return const Divider(
                          height: 1,
                          color: gray_f5f6f7Color,
                        );
                      },
                      itemCount: controller.shopList!.length,
                      itemBuilder: (context, idx) {
                        return ShopListWidget(
                          title: controller.shopList![idx].title,
                          imageUrl: controller.shopList![idx].image == null
                              ? ""
                              : controller.shopList![idx].image!,
                          brandName: controller.shopList![idx].brand,
                          category: controller.shopList![idx].category,
                          genuine: controller.shopList![idx].gi,
                          money: NumberFormatUtil.convertNumberFormat(
                              number: controller.shopList![idx].price),
                          date: DateFormatUtil.convertDateTimeFormat(
                              date: controller.shopList![idx].createdDate),
                          productIdx: controller.shopList![idx].shopId,
                        );
                      },
                    )
                  : Container(
                      width: double.infinity,
                      height: 150,
                      child: Center(
                        child: Text(
                          "등록된 제품이 없어요.",
                          style: regular14TextStyle.copyWith(
                            color: gray_999Color,
                          ),
                        ),
                      ),
                    ),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 16),
              child: const Divider(
                height: 1,
                color: gray_f5f6f7Color,
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
