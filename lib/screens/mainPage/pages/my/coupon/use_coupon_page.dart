import 'package:brandcare_mobile_flutter_v2/apis/base_api_service.dart';
import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/addCareControllers/addCarePayment_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/addGenuinePayment_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/coupon_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/my_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/point_controller.dart';
import 'package:brandcare_mobile_flutter_v2/utils/number_format_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/button/custom_button_empty_background_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/button/custom_button_onoff_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/form_input_widget.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CouponUsePage extends GetView<CouponController> {
  const CouponUsePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return DefaultAppBarScaffold(
      title: '쿠폰함',
      child: Container(
        width: double.infinity,
        height: double.infinity,
        color: Colors.white,
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(
                children: [
                  Row(
                    children: [
                      Flexible(
                        flex: 2,
                        child: FormInputWidget(
                          onChange: (value){controller.couponCode.value = value;},
                          onSubmit: (value){},
                          controller: TextEditingController(),
                          textInputType: TextInputType.number,
                          hint: '쿠폰 코드 번호를 입력해주세요.',
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Flexible(
                        flex: 1,
                        child: Obx(() => CustomButtonOnOffWidget(title: '등록', onClick: (){
                          controller.couponAddPayment(controller.couponCode.value);
                        }, isOn: controller.isValidCouponCode)),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Divider(
                    height: 0,
                    thickness: 1,
                    color: gray_F1F3F5Color,
                  ),
                ],
              ),
            ),
            Expanded(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    controller: controller.pagingScroll,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 16, right: 16, top: 32),
                      child: GetBuilder<CouponController>(builder: (_) => Column(
                        children: [
                          controller.couponList!.isNotEmpty ?
                          ListView.builder(
                            physics: NeverScrollableScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            itemBuilder: (_, idx) {
                              return _couponItem(idx);
                            },
                            itemCount: controller.couponList!.length,
                            shrinkWrap: true,
                          ) : Container(
                            width: double.infinity,
                            height: 150,
                            child: Center(
                              child: Text(
                                '등록된 쿠폰이 없습니다.',
                                style: medium16TextStyle.copyWith(
                                  color: gray_666Color,
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                        ],
                      )),
                    ),
                  ),
                  if(MediaQuery.of(context).viewInsets.bottom == 0)
                    Obx(() => Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: CustomButtonOnOffWidget(
                        title: '적용하기',
                        onClick: () => controller.couponAddWhere(),
                        isOn: controller.couponId.value != 0,
                      ),
                    )),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _couponItem(int idx) => GestureDetector(
    behavior: HitTestBehavior.translucent,
    onTap: () => controller.couponUse(idx),
    child: Container(
      margin: const EdgeInsets.only(top: 10),
      width: double.infinity,
      height: 120,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: primaryColor,
      ),
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Obx(() => Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text("${controller.couponList![idx].title}", style: regular12TextStyle.copyWith(color: whiteColor)),
                if(controller.couponId.value == controller.couponList![idx].id)
                  Text("사용됨", style: regular12TextStyle.copyWith(color: whiteColor)),
              ],
            )),
            const SizedBox(height: 8),
            Text("${NumberFormatUtil.convertNumberFormat(number: controller.couponList![idx].discount)}원 할인", style: medium24TextStyle.copyWith(fontSize: 30, color: whiteColor, fontWeight: FontWeight.w900)),
            Row(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.end,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text("브랜드케어", style: regular12TextStyle.copyWith(color: whiteColor)),
              ],
            ),
          ],
        ),
      ),
    )
  );
}
