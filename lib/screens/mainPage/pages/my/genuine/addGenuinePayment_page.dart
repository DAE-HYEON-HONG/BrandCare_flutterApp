import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/addCareControllers/addCareEtc_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/addCareControllers/addCarePayment_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/addCareControllers/mainAddCare_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/addGenuinePayment_controller.dart';
import 'package:brandcare_mobile_flutter_v2/utils/number_format_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_form_submit.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AddGenuinePaymentPage extends StatelessWidget {
  AddGenuinePaymentController controller = Get.put(AddGenuinePaymentController());
  @override
  Widget build(BuildContext context) {
    return DefaultAppBarScaffold(
      title: "정품인증 결제",
      child: _renderBody(),
    );
  }

  _renderBody() {
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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 12),
                  //보내는 분
                  Text(
                    '보내는 분',
                    style: medium14TextStyle,
                  ),
                  const SizedBox(height: 9),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: gray_D5D7DBColor,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20, top: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(controller.addGenuineCtrl.senderName.text, style: regular14TextStyle),
                        const SizedBox(height: 2),
                        Text(controller.addGenuineCtrl.senderPhNum.text, style: regular14TextStyle),
                        const SizedBox(height: 2),
                        Text('${controller.addGenuineCtrl.senderAddress.text} ${controller.addGenuineCtrl.senderAddressDetail.value}', style: regular14TextStyle),
                      ],
                    ),
                  ),
                  //받는 분
                  const SizedBox(height: 16),
                  Text(
                    '받는 분',
                    style: medium14TextStyle,
                  ),
                  const SizedBox(height: 9),
                  Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: gray_D5D7DBColor,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    padding: const EdgeInsets.only(left: 16, right: 16, bottom: 20, top: 16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(controller.addGenuineCtrl.receiverName.text, style: regular14TextStyle),
                        const SizedBox(height: 2),
                        Text(controller.addGenuineCtrl.receiverPhNum.text, style: regular14TextStyle),
                        const SizedBox(height: 2),
                        Text('${controller.addGenuineCtrl.receiverAddress.text} ${controller.addGenuineCtrl.receiverAddressDetail.value}', style: regular14TextStyle),
                      ],
                    ),
                  ),
                  //택배 반송 주소
                  const SizedBox(height: 16),
                  Text(
                    '택배 반송 주소',
                    style: medium14TextStyle,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    width: double.infinity,
                    height: 53,
                    padding: const EdgeInsets.only(left: 16, right: 16),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: gray_D5D7DBColor,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _backPost(controller.addGenuineCtrl.returnSender.value, "보내는 분"),
                        const SizedBox(width: 47),
                        _backPost(controller.addGenuineCtrl.returnReceiver.value, "받는 분")
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Divider(height: 1, color: gray_f5f6f7Color),
                  const SizedBox(height: 16),
                  Text(
                    '정품인증 신청 정보',
                    style: medium14TextStyle,
                  ),
                  const SizedBox(height: 10),
                  Container(
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
                            itemCount: controller.addGenuineEtcCtrl.priceList.length,
                            itemBuilder: (context, idx){
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(height: 10),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        '${idx+1}. ${controller.addGenuineEtcCtrl.priceList[idx].title}',
                                        style: medium14TextStyle,
                                      ),
                                      Text(
                                        '+ ${NumberFormatUtil.convertNumberFormat(number: controller.addGenuineEtcCtrl.priceList[idx].price)}원',
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
                                '${controller.addGenuineEtcCtrl.priceList.length}개 선택됨',
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
                                    '${NumberFormatUtil.convertNumberFormat(number: controller.addGenuineEtcCtrl.addPrices())}원',
                                    style: medium16TextStyle.copyWith(color: redColor),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 16),
                  const Divider(color: gray_f5f6f7Color, height: 1),
                  const SizedBox(height: 16),
                  _saleTile(
                    onTap: (){
                      Get.toNamed("/main/my/coupon");
                    },
                    title: '브랜드케어 쿠폰',
                    subTitle: '0개 보유',
                  ),
                  const SizedBox(height: 16),
                  const Divider(color: gray_f5f6f7Color, height: 1),
                  const SizedBox(height: 16),
                  _saleTile(
                    onTap: (){
                      Get.toNamed("/main/my/point");
                    },
                    title: '브랜드케어 포인트',
                    subTitle: '0P 사용가능',
                  ),
                  const SizedBox(height: 16),
                  const Divider(color: gray_f5f6f7Color, height: 1),
                  const SizedBox(height: 16),
                  Text(
                    '결제금액',
                    style: medium14TextStyle,
                  ),
                  const SizedBox(height: 10),
                  Container(
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
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '정품인증 신청',
                                    style: medium14TextStyle,
                                  ),
                                  Text(
                                    '${NumberFormatUtil.convertNumberFormat(number: controller.addGenuineEtcCtrl.addPrices())}원',
                                    style: medium14TextStyle,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '배송비',
                                    style: medium14TextStyle,
                                  ),
                                  Text(
                                    '+ 3,000원',
                                    style: medium14TextStyle,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '쿠폰',
                                    style: medium14TextStyle,
                                  ),
                                  Text(
                                    '- ${NumberFormatUtil.convertNumberFormat(number: controller.couponDiscount.value)}원',
                                    style: medium14TextStyle,
                                  ),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    '포인트 사용',
                                    style: medium14TextStyle,
                                  ),
                                  Text(
                                    '- ${NumberFormatUtil.convertNumberFormat(number: controller.pointDiscount.value)}원',
                                    style: medium14TextStyle,
                                  ),
                                ],
                              ),
                            ],
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
                                '총 결제금액',
                                style: medium14TextStyle,
                              ),
                              Text(
                                '${NumberFormatUtil.convertNumberFormat(number: controller.allPrice())}원',
                                style: medium16TextStyle.copyWith(color: redColor),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 32),
                  Text(
                    '아래 개인정보 제공에 동의하시면 매니저에게 개인정보가 제공되어 서비스가 진행됩니다.',
                    style: medium14TextStyle,
                  ),
                  const SizedBox(height: 28),
                  const Divider(color: gray_f5f6f7Color, height: 1),
                  const SizedBox(height: 30),
                  Obx(() => GestureDetector(
                    onTap: () => controller.changeUserInfo(),
                    child: Row(
                      children: [
                        SvgPicture.asset(
                          controller.chkUserInfo.value ? 'assets/icons/check_on.svg' : 'assets/icons/check_off.svg',
                          height: 20,
                        ),
                        const SizedBox(width: 12),
                        Text(
                          '개인정보 제공에 동의합니다.',
                          style: medium14TextStyle,
                        ),
                      ],
                    ),
                  )),
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
              title: "신청하기",
              onTab: () => controller.nextLevel(),
              fill: controller.fill.value,
            ),
          )),
        ],
      ),
    );
  }

  _backPost(bool isChecked, String title){
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isChecked ? primaryColor : whiteColor,
            border: Border.all(width: 1, color: primaryColor),
          ),
        ),
        const SizedBox(width: 8),
        Text(title, style: regular14TextStyle.copyWith(color: gray_666Color)),
      ],
    );
  }

  _saleTile({required Function() onTap, required String title, required subTitle}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: medium14TextStyle,
        ),
        GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () {
            onTap();
          },
          child: Row(
            children: [
              Text(
                subTitle,
                style: medium14TextStyle,
              ),
              const SizedBox(width: 8),
              SvgPicture.asset(
                'assets/icons/btn_arrow_right.svg',
                height: 6,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
