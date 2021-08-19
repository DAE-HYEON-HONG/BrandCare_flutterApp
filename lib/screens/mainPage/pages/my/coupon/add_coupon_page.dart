import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/coupon_controller.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/button/custom_button_onoff_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/form_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CouponAddPage extends StatelessWidget {
  const CouponAddPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<CouponController>();
    return DefaultAppBarScaffold(title: '쿠폰 등록', child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 32,),
          Text('브랜드케어\n쿠폰 코드가 있으신가요?', style: medium16TextStyle,),
          const SizedBox(height: 8,),
          Text('쿠폰은 코드 번호 입력 즉시 등록 됩니다.', style: medium12TextStyle.copyWith(color: gray_666Color),),
          const SizedBox(height: 24,),
          FormInputWidget(onChange: (value){
            controller.couponCode.value = value;
          }, onSubmit: (value){}, controller: TextEditingController(),
            textInputType: TextInputType.number,
              hint: '쿠폰 코드 번호를 입력해주세요.',
          ),
          const SizedBox(height: 24,),
          Obx(() => CustomButtonOnOffWidget(title: '등록하기', onClick: (){
            controller.addCoupon();
            Get.back();
          }, isOn: controller.isValidCouponCode)),
        ],
      ),
    ));
  }
}
