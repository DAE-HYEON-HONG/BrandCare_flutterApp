import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/modified_product_controller.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/addProduct_expansionList_feild.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_form_submit.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/form_input_titleRow_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class ModifiedProductPage extends GetView<ModifiedProductController> {
  @override
  Widget build(BuildContext context) {
    return DefaultAppBarScaffold(
      title: "제품 정보 수정",
      child: _renderBody(context),
    );
  }

  _renderBody(context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(
                children: [
                  const SizedBox(height: 32),
                  FormInputTitleRowWidget(
                    hint: controller.myProductDetailCtrl.model!.title,
                    onChange: (value) => controller.nextBtnFill(),
                    onSubmit: (value){},
                    controller: controller.titleCtrl,
                    title: '제품명',
                    subTitle: "제품명을 입력하세요.(제품 애칭)",
                    isShowTitle: true,
                  ),
                  const SizedBox(height: 16),
                  Row(
                    children: [
                      Text('카테고리', style: regular14TextStyle),
                      const SizedBox(width: 8),
                      Text('카테고리를 선택해 주세요.',  style: regular14TextStyle.copyWith(color: gray_999Color)),
                    ],
                  ),
                  const SizedBox(height: 10),
                  GetBuilder<ModifiedProductController>(builder: (_) => AddProductExpansionListField(
                    onTap: () => controller.nextBtnFill(),
                    hintText: controller.category,
                    items: controller.categoryList!,
                    onChange: (value) => controller.hintText(value, "category"),
                    idxChange: (value) => controller.changeCategory(value),
                    hintIdx: (value) {},
                  )),
                  const SizedBox(height: 16),
                  GetBuilder<ModifiedProductController>(builder: (_) => AddProductExpansionListField(
                    onTap: () => controller.nextBtnFill(),
                    hintText: controller.brand,
                    items: controller.brandList!,
                    onChange: (value) => controller.hintText(value, "brand"),
                    idxChange: (value) => controller.changeBrandCategory(value),
                    hintIdx: (value) {},
                  )),
                  const SizedBox(height: 16),
                  FormInputTitleRowWidget(
                    hint: controller.myProductDetailCtrl.model!.serialCode,
                    onChange: (value) => controller.nextBtnFill(),
                    onSubmit: (value){},
                    controller: controller.serialCtrl,
                    title: '일련번호',
                    subTitle: "알지 못하는 경우 '모름'",
                    isShowTitle: true,
                  ),
                  const SizedBox(height: 16),
                  FormInputTitleRowWidget(
                    hint: controller.myProductDetailCtrl.model!.buyDate,
                    onChange: (value) => controller.nextBtnFill(),
                    onSubmit: (value){},
                    controller: controller.buyDateCtrl,
                    title: '구입시기',
                    subTitle: "(예>21년 5월경이면, 2105로 입력해주세요)",
                    isShowTitle: true,
                    textInputType: TextInputType.number,
                    textInputIsAllow: true,
                    maxLength: 4,
                    textInputFormatter: r'[0-9]',
                  ),
                  const SizedBox(height: 16),
                  FormInputTitleRowWidget(
                    hint: controller.myProductDetailCtrl.model!.price,
                    onChange: (value) => controller.nextBtnFill(),
                    onSubmit: (value){},
                    controller: controller.buyPriceCtrl,
                    title: '구입금액',
                    subTitle: "구입금액을 입력하세요.(숫자만 입력해주세요)",
                    isShowTitle: true,
                    textInputType: TextInputType.number,
                  ),
                  const SizedBox(height: 16),
                  FormInputTitleRowWidget(
                    hint: controller.myProductDetailCtrl.model!.buyRoute,
                    onChange: (value) => controller.nextBtnFill(),
                    onSubmit: (value){},
                    controller: controller.buyRouteCtrl,
                    title: '구입경로',
                    subTitle: "구입경로를 입력하세요.",
                    isShowTitle: true,
                  ),
                  const SizedBox(height: 120),
                  //autoHeight
                  // GetBuilder<ModifiedProductController>(
                  //     builder: (_) => SizedBox(height: controller.autoHeight(context)))
                ],
              ),
            ),
          ),
          if(MediaQuery.of(context).viewInsets.bottom == 0)
          Obx(()=> Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomFormSubmit(
              title: "다음",
              onTab: () => controller.nextLevel(),
              fill: controller.nextBtn.value,
            ),
          )),
        ],
      ),
    );
  }
}
