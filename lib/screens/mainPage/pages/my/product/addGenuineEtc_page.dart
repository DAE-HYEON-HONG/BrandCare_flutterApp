import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/addCareControllers/mainAddCare_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/addGenuineEtc_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/addGenuine_controller.dart';
import 'package:brandcare_mobile_flutter_v2/utils/date_format_util.dart';
import 'package:brandcare_mobile_flutter_v2/utils/number_format_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/button/custom_button_empty_background_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/button/custom_button_onoff_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_chk_address.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_form_submit.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/form_input_otherTitle_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/form_input_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/genuine_expansionList_feild.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kpostal/kpostal.dart';

class AddGenuineEtcPage extends StatelessWidget {
  final AddGenuineEtcController controller = Get.put(AddGenuineEtcController());
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: DefaultAppBarScaffold(
          title: "정품인증 신청",
          child: _renderBody(context),
        )
    );
  }

  _renderBody(BuildContext context){
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: whiteColor,
        child: Stack(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Padding(
                padding: const EdgeInsets.only(left: 16, right: 16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 32),
                        FormInputWidget(
                          onChange: (value) => controller.fillChange(),
                          onSubmit: (value) {},
                          controller: controller.productName,
                          isShowTitle: true,
                          title: "제품명",
                          hint: "제품명을 입력해주세요.",
                        ),
                        const SizedBox(height: 16),
                        FormInputWidget(
                          onChange: (value) => controller.fillChange(),
                          onSubmit: (value) {},
                          controller: controller.serialCode,
                          isShowTitle: true,
                          title: "일련번호",
                          hint: "일련번호를 입력해주세요.",
                        ),
                        const SizedBox(height: 16),
                        FormInputWidget(
                          onChange: (value) => controller.fillChange(),
                          onSubmit: (value) {},
                          controller: controller.buyDate,
                          isShowTitle: true,
                          textInputType: TextInputType.number,
                          title: "구입시기",
                          hint: "예) 2105",
                        ),
                        const SizedBox(height: 16),
                        Text("인증항목", style: medium14TextStyle,),
                        const SizedBox(height: 9),
                        GenuineExpansionListField(
                          onTap: () {},
                          hintText: "1. 인증항목을 선택하세요.",
                          items: controller.genuineList!,
                          onChange: (value) {},
                          onIdChange: (value) => controller.changeFirstGenuine(value),
                        ),
                        const SizedBox(height: 16),
                        GenuineExpansionListField(
                          onTap: () {},
                          hintText: "2. 인증항목을 선택하세요. (추가선택)",
                          items: controller.genuineList!,
                          onChange: (value) {},
                          onIdChange: (value) => controller.changeSecondGenuine(value),
                        ),
                        const SizedBox(height: 32),
                        GetBuilder<AddGenuineEtcController>(builder: (_) =>Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: gray_D5D7DBColor,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 18),
                                child: ListView.builder(
                                  physics: NeverScrollableScrollPhysics(),
                                  shrinkWrap: true,
                                  itemCount: controller.priceList.length,
                                  itemBuilder: (context, idx){
                                    return Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                              '$idx. ${controller.priceList[idx].title}',
                                              style: medium14TextStyle,
                                            ),
                                            Text(
                                              '+ ${NumberFormatUtil.convertNumberFormat(number: controller.priceList[idx].price)}원',
                                              style: medium14TextStyle,
                                            ),
                                          ],
                                        ),
                                        const SizedBox(height: 10),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              Container(
                                width: double.infinity,
                                height: 1,
                                color: gray_D5D7DBColor,
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 16, right: 16, top: 16, bottom: 18),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      '${controller.priceList.length}개 선택됨',
                                      style: medium14TextStyle,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          '총 금액',
                                          style: medium14TextStyle,
                                        ),
                                        const SizedBox(width: 27),
                                        Text(
                                          '${NumberFormatUtil.convertNumberFormat(number: controller.addPrices())}원',
                                          style: medium16TextStyle.copyWith(color: redColor),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        )),
                        const SizedBox(height: 16),
                        Text(
                          '케어/수선 요청사항',
                          style: medium14TextStyle,
                        ),
                        const SizedBox(height: 10),
                        Container(
                          padding: EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: gray_D5D7DBColor,
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(5),
                          ),
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              minHeight: 160,
                              maxHeight: 700,
                            ),
                            child: TextFormField(
                              onChanged: (value) => controller.fillChange(),
                              maxLines: null,
                              controller: controller.des,
                              style: regular14TextStyle.copyWith(color: gray_999Color),
                              decoration: InputDecoration(
                                border: InputBorder.none,
                                focusedBorder: InputBorder.none,
                                disabledBorder: InputBorder.none,
                                enabledBorder: InputBorder.none,
                                hintText: "신청 항목 별로 케어/수선 요청사항을\n자세하게 작성해주세요.",
                                hintStyle: regular14TextStyle.copyWith(color: gray_999Color),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 120),
                  ],
                ),
              ),
            ),
            Obx(()=> Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: CustomFormSubmit(
                title: "다음",
                onTab: () => controller.nextLevel(),
                fill: controller.fill.value,
              ),
            )),
          ],
        ),
    );
  }
}
