import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/addGenuineEtc_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/payment/genuine_price_controller.dart';
import 'package:brandcare_mobile_flutter_v2/utils/number_format_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_form_submit.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/form_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';

class AddGenuineEtcPage extends StatelessWidget {
  final AddGenuineEtcController controller = Get.put(AddGenuineEtcController());
  final genuinePriceController = Get.find<GenuinePriceController>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () {
      Get.dialog(
          CustomDialogWidget(
        isSingleButton: false,
        content: '정품인증 요청사항 작성을 취소하시겠습니까?',
        okTxt: '확인',
        cancelTxt: '취소',
        onClick: () {
          Get.back();
          Get.back();
          return Future(() => true);
        },
        onCancelClick: () {
          Get.back();
          return Future(() => false);
        },
      ));
      return Future(() => true);
    },
    child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: DefaultAppBarScaffold(
          title: "정품인증 신청",
          child: _renderBody(context),
          backButtonDialog: true,
          backButtonDialogText: '정품인증 요청사항 작성을 취소하시겠습니까?',
        )
    ),);
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
                          readOnly: true,
                          onChange: (value) => controller.fillChange(),
                          onSubmit: (value) {},
                          controller: controller.productName,
                          isShowTitle: true,
                          title: "제품명",
                          hint: "${controller.productInfoDetailCtrl.model?.title}",
                        ),
                        const SizedBox(height: 16),
                        FormInputWidget(
                          readOnly: true,
                          onChange: (value) => controller.fillChange(),
                          onSubmit: (value) {},
                          controller: controller.serialCode,
                          isShowTitle: true,
                          title: "일련번호",
                          hint: "${controller.productInfoDetailCtrl.model?.serialCode}",
                        ),
                        const SizedBox(height: 16),
                        FormInputWidget(
                          readOnly: true,
                          onChange: (value) => controller.fillChange(),
                          onSubmit: (value) {},
                          controller: controller.buyDate,
                          isShowTitle: true,
                          textInputType: TextInputType.number,
                          title: "구입시기",
                          hint: "${controller.productInfoDetailCtrl.model?.buyDate}",
                        ),
                        //const SizedBox(height: 16),
                        // Text("인증항목", style: medium14TextStyle,),
                        // const SizedBox(height: 9),
                        // GenuineExpansionListField(
                        //   onTap: () {},
                        //   hintText: "1. 인증항목을 선택하세요.",
                        //   items: controller.genuineList!,
                        //   onChange: (value) {},
                        //   onIdChange: (value) => controller.changeFirstGenuine(value),
                        // ),
                        // const SizedBox(height: 16),
                        // GenuineExpansionListField(
                        //   onTap: () {},
                        //   hintText: "2. 인증항목을 선택하세요. (추가선택)",
                        //   items: controller.genuineList!,
                        //   onChange: (value) {},
                        //   onIdChange: (value) => controller.changeSecondGenuine(value),
                        // ),
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
                                              '정품인증',
                                              style: medium14TextStyle,
                                            ),
                                            Row(
                                              children: [
                                                Text(
                                                  '+ ${NumberFormatUtil.convertNumberFormat(number: genuinePriceController.genuinePrice.value)}원',
                                                  style: medium14TextStyle,
                                                ),
                                                // const SizedBox(width: 15),
                                                // GestureDetector(
                                                //   onTap: () {
                                                //     controller.removeGenuine(controller.priceList[idx]);
                                                //   },
                                                //   child: SvgPicture.asset(
                                                //     "assets/icons/btn_x.svg",
                                                //     height: 15,
                                                //   ),
                                                // ),
                                              ],
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
                                      // '${controller.priceList.length}개 선택됨',
                                      '',
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
                                          '${NumberFormatUtil.convertNumberFormat(number: genuinePriceController.genuinePrice.value)}원',
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
                          '요청사항',
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
                                hintText: "요청사항을 작성해주세요.",
                                hintStyle: regular14TextStyle.copyWith(color: gray_999Color),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 120),
                    GetBuilder<AddGenuineEtcController>(
                        builder: (_) => SizedBox(height: controller.autoHeight(context))),
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
                fill: controller.fill.value,
              ),
            )),
          ],
        ),
    );
  }
}
