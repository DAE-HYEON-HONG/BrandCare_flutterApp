import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/coupon_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/my_controller.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/button/custom_button_empty_background_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/button/custom_button_onoff_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/form_input_widget.dart';
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
            Flexible(
              child: Column(
                children: [
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Flexible(
                        flex: 2,
                        child: FormInputWidget(onChange: (value){
                          controller.couponCode.value = value;
                        }, onSubmit: (value){}, controller: TextEditingController(),
                          textInputType: TextInputType.number,
                          hint: '쿠폰 코드 번호를 입력해주세요.',
                        ),
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Obx(() => CustomButtonOnOffWidget(title: '등록', onClick: (){
                        controller.addCoupon();
                        Get.back();
                      }, isOn: controller.isValidCouponCode)),
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
                  controller.couponList!.isNotEmpty
                      ? _couponList()
                      : Expanded(
                        child: Center(
                          child: Text(
                            '등록된 쿠폰이 없습니다.',
                            style: medium16TextStyle.copyWith(
                              color: gray_666Color,
                            ),
                          ))),
                ],
              ),

            ),
            CustomButtonEmptyBackgroundWidget(title: '적용하기', onClick: (){

            }),
          ],
        ),
      ),
    );
  }
  Widget _couponList() => Flexible(
    child: GetBuilder<CouponController>(builder: (_) => ListView.builder(
      itemBuilder: (_, idx) {
        return Padding(
          padding: EdgeInsets.only(
              top: 16.0,
              bottom: idx == controller.couponList!.length - 1 ? 16 : 0),
          child: _couponItem(),
        );
      },
      itemCount: controller.couponList!.length,
      shrinkWrap: true,
    )),
  );

  Widget _couponItem() => Container(
    width: double.infinity,
    height: 120,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(12),
      color: gray_666Color,
    ),
    child: ClipRRect(
      borderRadius: BorderRadius.circular(12),
      child: Placeholder(
        strokeWidth: 1.0,
        color: blackColor,
      ),
    ),
  );
}
