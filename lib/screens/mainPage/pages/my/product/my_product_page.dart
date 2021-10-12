import 'package:brandcare_mobile_flutter_v2/apis/base_api_service.dart';
import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/my_product_controller.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_bottom_filter.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/genuine_box_widget.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MyProductPage extends GetView<MyProductController> {
  const MyProductPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return DefaultAppBarScaffold(
      title: '나의 제품 전체 보기',
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 32, right: 16, bottom: 8),
              child: GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  Get.bottomSheet(
                    CustomBottomFilter(
                      sort1: () async {
                        await controller.filter(type: "LATEST");
                      },
                      sort2: () async {
                        await controller.filter(type: "a");
                      },
                      mode: "nameBy",
                    ),
                  );
                },
                child: SvgPicture.asset('assets/icons/filter.svg'),
              ),
            ),
            const Divider(
              height: 0,
              thickness: 1,
            ),
            Flexible(
              child: GetBuilder<MyProductController>(
                builder: (_) => ListView.separated(
                  controller: controller.pagingScroll,
                  shrinkWrap: true,
                  itemBuilder: (context, idx) => _item(
                    imgPath: controller.myProductList?[idx].thumbnail ?? '',
                    brand: controller.myProductList![idx].brand,
                    category: controller.myProductList![idx].category,
                    title: controller.myProductList![idx].title,
                    genuine: controller.myProductList![idx].genuine,
                    idx: controller.myProductList![idx].productId,
                  ),
                  separatorBuilder: (context, idx) => const Divider(height: 0, thickness: 1,),
                  itemCount: controller.myProductList?.length ?? 0,
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Widget _item({
  required String imgPath,
  required String brand,
  required String category,
  required String title,
  required String genuine,
  required int idx}) => GestureDetector(
    behavior: HitTestBehavior.translucent,
    onTap: () => Get.toNamed("/main/my/product/gi/detail", arguments: idx),
    child: Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        children: [
          imgPath == "" ?
          Container(
            width: 72,
            height: 72,
            decoration: BoxDecoration(
              border: Border.all(color: gray_999Color),
            ),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  // Get.bottomSheet(
                  //   CustomBottomFilter(
                  //     sort1: () async {
                  //       await controller.filter(type: "LATEST");
                  //     },
                  //     sort2: () async {
                  //       await controller.filter(type: "");
                  //     },
                  //     mode: "nameBy",
                  //   ),
                  // );
                },
                child: SvgPicture.asset(
                  "assets/icons/header_title_logo.svg",
                  height: 10,
                ),
              ),
            ),
          ):
          Container(
            width: 72,
            height: 72,
            child: ExtendedImage.network(
              BaseApiService.imageApi+imgPath,
              fit: BoxFit.cover,
              cache: true,
              // ignore: missing_return
              loadStateChanged: (ExtendedImageState state) {
                switch(state.extendedImageLoadState) {
                  case LoadState.loading :
                    break;
                  case LoadState.completed :
                    break;
                  case LoadState.failed :
                    break;
                }
              },
            ),
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
                      '$brand | $category',
                      style: regular12TextStyle.copyWith(color: gray_333Color),
                    ),
                    const Spacer(),
                    if(genuine != "REFUSAL")
                    GenuineBoxWidget(isGenuine: genuine == "GENUINE" ? true : false),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  '$title',
                  style: medium14TextStyle,
                )
              ],
            ),
          )
        ],
      ),
    ),
  );
}
