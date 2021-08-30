import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/AddProductControllers/mainAddProduct_controller.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/Custom_expansionList_feild.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_expansion_field.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_form_submit.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/form_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainAddProductPage extends StatelessWidget {
  final MainAddProductController controller = Get.put(MainAddProductController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: _appBar(),
        body: _body(context),
      ),
    );
  }
  //앱바 부분
  _appBar() {
    return AppBar(
      leading: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: (){},
        child: Container(),
      ),
      title: Text("제품 등록", style: medium16TextStyle.copyWith(color: primaryColor)),
      titleSpacing: 0,
      centerTitle: true,
      titleTextStyle: medium16TextStyle.copyWith(color: primaryColor),
      backgroundColor: whiteColor,
      elevation: 4,
      shadowColor: blackColor.withOpacity(0.05),
      automaticallyImplyLeading: false,
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
                "제품 정보를 입력하세요.(모든 항목 필수 입력)",
                style: regular14TextStyle,
              ),
              const SizedBox(height: 17),
              FormInputWidget(
                onChange: (value) => controller.nextBtnFill(),
                onSubmit: (value) {},
                controller: controller.titleCtrl,
                hint: "제품명을 입력하세요.(제품 애칭)",
              ),
              const SizedBox(height: 16),
              // CustomExpansionListField(
              //   onTap: () {},
              //   hintText: "카테고리를 선택해주세요.",
              //   items: items,
              //   onChange: (value) {},
              // ),
              // const SizedBox(height: 16),
              // CustomExpansionListField(
              //   onTap: () {},
              //   hintText: "브랜드명을 선택해주세요.",
              //   items: items,
              //   onChange: (value) {},
              // ),
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
                hint: "구입시기(예>21년 5월경이면, 2105로 입력해주세요.)",
              ),
              const SizedBox(height: 16),
              FormInputWidget(
                onChange: (value) => controller.nextBtnFill(),
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
              const SizedBox(height: 30),
            ],
          ),
        )
      ),
    );
  }
}
