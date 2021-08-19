import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/coupon_controller.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/button/custom_button_empty_background_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CouponPage extends GetView<CouponController> {
  const CouponPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultAppBarScaffold(title: '쿠폰함', child: Container(
      height: double.infinity,
      padding: const EdgeInsets.only(left: 16, right: 16, top: 32),
      child: GetBuilder<CouponController>(
        builder: (_) =>  Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomButtonEmptyBackgroundWidget(title: '+ 쿠폰 등록하기', onClick: (){
              Get.toNamed('/main/my/coupon/add');
            }),
            const SizedBox(height: 32,),
            Text('보유 쿠폰 ${controller.couponList.length}장', style: medium14TextStyle,),
            const SizedBox(height: 16,),
            const Divider(height: 0,thickness: 1, color: gray_F1F3F5Color,),
            controller.couponList.isNotEmpty ? _couponList() : Expanded(child: Center(child: Text('등록된 쿠폰이 없습니다.',style: medium16TextStyle.copyWith(color: gray_666Color,),))),
            const SizedBox(height: 16,),
          ],
        ),
      )
    ));
  }

  Widget _couponList() => ListView.builder(itemBuilder: (_,__) {
    return Padding(
      padding: EdgeInsets.only(top: 16.0),
      child: _couponItem(),
    );
  }, itemCount: controller.couponList.length, shrinkWrap: true,);

  Widget _couponItem() => Container(
    width:double.infinity,
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
