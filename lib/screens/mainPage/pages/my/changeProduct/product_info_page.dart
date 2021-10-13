import 'package:brandcare_mobile_flutter_v2/apis/global_api_service.dart';
import 'package:brandcare_mobile_flutter_v2/consts/box_shadow.dart';
import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/product_info_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/product/productDetail_model.dart';
import 'package:brandcare_mobile_flutter_v2/utils/number_format_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/form_input_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/genuine_box_widget.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProductInfoPage extends GetView<ProductInfoController> {
  const ProductInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    controller.getDetailProduct(Get.arguments['id']);
    return DefaultAppBarScaffold(
        title: '제품 정보',
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
              child: GetBuilder<ProductInfoController>(
            builder: (_) => Column(
              children: [
                const SizedBox(
                  height: 32,
                ),
                _item(controller.model),
                const SizedBox(
                  height: 24,
                ),
                FormInputWidget(
                  onChange: (value) {},
                  onSubmit: (value) {},
                  controller: TextEditingController(
                      text: '${controller.model?.title ?? "로딩중"}'),
                  readOnly: true,
                  title: '제품명',
                  isShowTitle: true,
                ),
                const SizedBox(
                  height: 24,
                ),
                FormInputWidget(
                  onChange: (value) {},
                  onSubmit: (value) {},
                  controller: TextEditingController(
                      text: '${controller.model?.serialCode ?? "0"}'),
                  readOnly: true,
                  title: '일련번호',
                  isShowTitle: true,
                ),
                const SizedBox(
                  height: 24,
                ),
                FormInputWidget(
                  onChange: (value) {},
                  onSubmit: (value) {},
                  controller: TextEditingController(
                      text: '${controller.model?.buyDate ?? "2020-12-31"}'),
                  readOnly: true,
                  title: '구입시기',
                  isShowTitle: true,
                ),
                const SizedBox(
                  height: 24,
                ),
                FormInputWidget(
                  onChange: (value) {},
                  onSubmit: (value) {},
                  controller: TextEditingController(
                      text:
                          '${NumberFormatUtil.convertNumberFormat(number: int.parse(controller.model?.price ?? "0"))}원'),
                  readOnly: true,
                  title: '구입금액',
                  isShowTitle: true,
                ),
                const SizedBox(
                  height: 24,
                ),
                FormInputWidget(
                  onChange: (value) {},
                  onSubmit: (value) {},
                  controller: TextEditingController(
                      text: '${controller.model?.buyRoute ?? "로딩중"}'),
                  readOnly: true,
                  title: '구입경로',
                  isShowTitle: true,
                ),
                const SizedBox(
                  height: 24,
                ),
                _gridPicture(
                    controller.model?.frontImage,
                    controller.model?.backImage,
                    controller.model?.leftImage,
                    controller.model?.rightImage),
                const SizedBox(
                  height: 32,
                ),
                Text(
                  '추가정보',
                  style: medium14TextStyle,
                ),
                const SizedBox(
                  height: 17,
                ),
                _productAddInfo(
                    '제품 컨디션',
                    controller.model != null
                        ? controller.model!.conditionList
                            .map((e) => e.title)
                            .toList()
                        : []),
                const SizedBox(
                  height: 30,
                ),
                _productAddInfo(
                    '제품 구성품',
                    controller.model != null
                        ? controller.model!.additionList
                            .map((e) => e.title)
                            .toList()
                        : []),
                const SizedBox(
                  height: 27,
                ),
                _etc('${controller.model?.etc}'),
                const SizedBox(
                  height: 32,
                ),
              ],
            ),
          )),
        ));
  }

  Widget _item(ProductDetailModel? model) => Container(
        height: 104,
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              defaultBoxShadow,
            ]),
        child: Row(
          children: [
            if (model != null && model.thumbnail != null)
              ExtendedImage.network(
                GlobalApiService.getImage(model.thumbnail!),
                width: 72,
                height: 72,
                cache: true,
              )
            else
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  border: Border.all(color: gray_999Color),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/icons/header_title_logo.svg",
                    height: 10,
                  ),
                ),
              ),
            const SizedBox(
              width: 16,
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${model?.brand ?? ""} | ${model?.category ?? ""}',
                      style: regular12TextStyle.copyWith(color: gray_333Color),
                    ),
                    const SizedBox(
                      width: 19,
                    ),
                    if(model?.genuine != "REFUSAL")
                    GenuineBoxWidget(isGenuine: model?.genuine == "GENUINE" ? true : false),
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '${model?.title ?? "로딩중"}',
                  style: medium14TextStyle,
                  overflow: TextOverflow.ellipsis,
                ),
              ],
            )
          ],
        ),
      );

  Widget _gridPicture(
          String? front, String? back, String? left, String? right) =>
      Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _pictureItem('정면 사진', front),
                _pictureItem('뒷면 사진', back),
              ],
            ),
            const SizedBox(
              height: 24,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                _pictureItem('좌측면 사진', left),
                _pictureItem('우측면 사진', right),
              ],
            ),
          ],
        ),
      );

  Widget _pictureItem(String title, String? url) => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: medium14TextStyle,
            ),
            const SizedBox(
              height: 10,
            ),
            if (url != null)
              ExtendedImage.network(
                GlobalApiService.getImage(url),
                width: 160,
                height: 160,
                cache: true,
              )
            else
              Container(
                width: 160,
                height: 160,
                child: Center(
                  child: SvgPicture.asset('assets/icons/header_title_logo.svg', width: 10, height: 10,),
                ),
              ),
          ],
        ),
      );

  Widget _productAddInfo(String title, List<String> list) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: medium14TextStyle,
        ),
        const SizedBox(
          height: 17,
        ),
        Row(
          children: [
            ...list.map((e) => Flexible(
                  child: Row(
                    children: [
                      SvgPicture.asset('assets/icons/check_on.svg'),
                      const SizedBox(width: 8),
                      Text(
                        e,
                        style: medium12TextStyle,
                      ),
                    ],
                  ),
                )),
          ],
        )
      ],
    );
  }

  Widget _etc(String etc) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '기타',
            style: medium14TextStyle,
          ),
          const SizedBox(
            height: 17,
          ),
          TextField(
            controller: TextEditingController(text: '$etc'),
            style: regular14TextStyle.copyWith(color: gray_999Color),
            maxLines: 8,
            decoration: InputDecoration(
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 13.42),
              disabledBorder: OutlineInputBorder(
                borderSide: BorderSide(color: gray_D5D7DBColor),
                borderRadius: BorderRadius.circular(4),
              ),
            ),
            enabled: false,
          )
        ],
      );
}
