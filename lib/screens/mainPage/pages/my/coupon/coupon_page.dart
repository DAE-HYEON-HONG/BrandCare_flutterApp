import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/coupon_controller.dart';
import 'package:brandcare_mobile_flutter_v2/utils/number_format_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/button/custom_button_empty_background_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CouponPage extends GetView<CouponController> {
  const CouponPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultAppBarScaffold(
        title: '쿠폰함',
        child: Container(
            height: double.infinity,
            padding: const EdgeInsets.only(left: 16, right: 16, top: 32),
            child: GetBuilder<CouponController>(
              builder: (_) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomButtonEmptyBackgroundWidget(
                      title: '+ 쿠폰 등록하기',
                      onClick: () {
                        Get.toNamed('/main/my/coupon/add');
                      }),
                  const SizedBox(
                    height: 32,
                  ),
                  Text(
                    '보유 쿠폰 ${controller.couponList!.length}장',
                    style: medium14TextStyle,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  const Divider(
                    height: 0,
                    thickness: 1,
                    color: gray_F1F3F5Color,
                  ),
                  controller.couponList!.length != 0
                      ? _couponList()
                      : Expanded(
                          child: Center(
                              child: Text(
                          '등록된 쿠폰이 없어요.',
                          style: regular14TextStyle.copyWith(
                            color: gray_999Color,
                          ),
                        ))),
                ],
              ),
            )));
  }

  Widget _couponList() => Flexible(
        child: GetBuilder<CouponController>(builder: (_) => ListView.builder(
          itemBuilder: (_, idx) {
            return Padding(
              padding: EdgeInsets.only(
                  top: 16.0,
                  bottom: idx == controller.couponList!.length - 1 ? 16 : 0),
              child: _couponItem(controller.couponList![idx].title, controller.couponList![idx].discount),
            );
          },
          itemCount: controller.couponList!.length,
          shrinkWrap: true,
        )),
      );

  Widget _couponItem(String title, int discount) => Container(
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
              Text("$title", style: regular12TextStyle.copyWith(color: whiteColor)),
              const SizedBox(height: 8),
              Text("${NumberFormatUtil.convertNumberFormat(number: discount)}원 할인", style: medium24TextStyle.copyWith(fontSize: 30, color: whiteColor, fontWeight: FontWeight.w900)),
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
      );
}
