import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/AddProductControllers/mainAddProduct_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/mainPage_controller.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/Custom_expansionList_feild.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/addProduct_expansionList_feild.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_expansion_field.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_form_submit.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/form_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class MainAddProductPage extends StatelessWidget {
  final MainAddProductController controller =
      Get.put(MainAddProductController());

  //final MainPageController mainPageController = Get.find<MainPageController>();
  int? brandIdx;

  static const _locale = 'ko';

  String _formatNumber(String s) =>
      NumberFormat.decimalPattern(_locale).format(int.parse(s));

  String get _currency =>
      NumberFormat.compactSimpleCurrency(locale: _locale).currencySymbol;

  @override
  //textFormField랑 textEditingctrl은 stless에서 사용 시 rebuild를 하게 됩니다.
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: _appBar(),
        body:  _body(context),
        ),

    );
  }

  //앱바 부분
  _appBar() {
    final mainPageCtrl = Get.find<MainPageController>();
    return AppBar(
      leading: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {},
        child: Container(),
      ),
      title:
          Text("제품 등록", style: medium16TextStyle.copyWith(color: primaryColor)),
      titleSpacing: 0,
      centerTitle: true,
      titleTextStyle: medium16TextStyle.copyWith(color: primaryColor),
      backgroundColor: whiteColor,
      elevation: 4,
      shadowColor: blackColor.withOpacity(0.05),
      automaticallyImplyLeading: false,
      actions: [
        GestureDetector(
          onTap: () {
            mainPageCtrl.onItemTaped(5);
          },
          child: SvgPicture.asset(
            'assets/icons/mainNotice.svg',
            height: 19,
          ),
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  //바디 부분
  _body(BuildContext context) {
    return Container(
      color: whiteColor,
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                const SizedBox(height: 32),
                Text(
                  "제품 정보를 입력하세요.",
                  style: regular14TextStyle,
                ),
                const SizedBox(height: 17),
                FormInputWidget(
                  onChange: (value) => controller.nextBtnFill(),
                  onSubmit: (value) {},
                  controller: controller.titleCtrl,
                  hint: "제품의 이름을 적어주세요.(필수입력)",
                ),
                const SizedBox(height: 16),
                AddProductExpansionListField(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                    },
                    hintText: controller.categoryIdx == null
                        ? "카테고리를 선택해주세요. (필수입력)"
                        : controller
                            .categoryList[controller.categoryIdx! - 1].title,
                    items: controller.categoryList,
                    onChange: (value) => controller.nextBtnFill(),
                    idxChange: (value) => controller.changeCategory(value),
                    hintIdx: (value) {}),
                const SizedBox(height: 16),
                AddProductExpansionListField(
                  onTap: () {
                    FocusScope.of(context).unfocus();
                  },
                  hintText: controller.brandCategoryIdx == null
                      ? "브랜드명을 선택해주세요. (필수입력)"
                      : controller.brandList[brandIdx!].title,
                  items: controller.brandList,
                  onChange: (value) => controller.nextBtnFill(),
                  idxChange: (value) => controller.changeBrandCategory(value),
                  hintIdx: (value) {
                    brandIdx = value;
                  },
                ),
                const SizedBox(height: 16),
                Text(
                  "아래 항목은 입력하지 않으셔도 됩니다.(선택입력)",
                  style: regular14TextStyle,
                ),
                const SizedBox(height: 16),
                FormInputWidget(
                  onChange: (value) => controller.nextBtnFill(),
                  onSubmit: (value) {},
                  controller: controller.serialCtrl,
                  hint: "일련번호를 입력하세요.(알지 못하는 경우 '모름')",
                ),
                const SizedBox(height: 16),
                FormInputWidget(
                  onChange: (value) => controller.nextBtnFill(),
                  onSubmit: (value) {},
                  controller: controller.sinceBuyCtrl,
                  textInputType: TextInputType.number,
                  hint: "구입시기(예>21년 5월경이면, 2105로 입력해주세요.)",
                ),
                const SizedBox(height: 16),
                FormInputWidget(
                  maxLength: 11,
                  onChange: (value) {
                    if (value.length > 0) {
                      value = '${_formatNumber(value.replaceAll(',', ''))}';
                      controller.priceCtrl.value = TextEditingValue(
                        text: value,
                        selection:
                            TextSelection.collapsed(offset: value.length),
                      );
                    }
                    controller.nextBtnFill();
                  },
                  onSubmit: (value) {},
                  controller: controller.priceCtrl,
                  hint: "구입금액을 입력하세요.(숫자만 입력해주세요.)",
                  textInputType: TextInputType.number,
                ),
                const SizedBox(height: 16),
                FormInputWidget(
                  onChange: (value) => controller.nextBtnFill(),
                  onSubmit: (value) {},
                  controller: controller.connectBuyCtrl,
                  hint: "구입경로를 입력하세요.",
                ),
                const SizedBox(height: 24),
                Obx(() => CustomFormSubmit(
                      title: "다음",
                      onTab: () => controller.nextBtnFunc(context),
                      fill: controller.nextBtn.value,
                    )),
                const SizedBox(height: 50),
              ],
            ),
          )),
    );
  }
}
