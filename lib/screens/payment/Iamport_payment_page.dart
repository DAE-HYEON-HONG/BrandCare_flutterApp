import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/addCareControllers/addCarePayment_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/addGenuinePayment_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/payment/iamport_payment_controller.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:iamport_flutter/iamport_payment.dart';

class IamportPaymentPage extends GetView<IamportPaymentController> {
  const IamportPaymentPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        child: IamportPayment(
          appBar: _appBar(),
          initialChild: Container(
            child: Center(
              child: Text(
                "결제를 준비중입니다....",
                style: medium16TextStyle.copyWith(color: gray_999Color),
              ),
            ),
          ),
          //가맹점 식별코드를 넣어주시면 됩니다.
          userCode: "imp27305896",
          data: Get.arguments['paymentInfo'],
          callback: (Map<String, String> result) async {
            print(result.toString());
            if (result['imp_success'] == "true") {
              if (Get.arguments['type'] == "care") {
                final carePayCtrl = Get.find<AddCarePaymentController>();
                await carePayCtrl.uploadAddCare();
              } else {
                final genuinePayCtrl = Get.find<AddGenuinePaymentController>();
                await genuinePayCtrl.uploadAdd();
              }
            } else {
              Get.back();
              Get.dialog(
                CustomDialogWidget(
                    content: '결제가 실패되었습니다.\n다시 시도해주세요.',
                    onClick: () {
                      Get.back();
                    }),
              );
            }
          },
        ),
        //onWillPop: () => Future(() => false),
        onWillPop: () {
          Get.dialog(
            CustomDialogWidget(
              content: '결제를 취소하시겠습니까?',
              isSingleButton: false,
              okTxt: '확인',
              cancelTxt: '취소',
              onClick: () {
                Get.back();
                Get.back();
                Get.dialog(
                  CustomDialogWidget(
                      content: '결제를 취소하였습니다.',
                      onClick: () {
                        Get.back();
                      }),
                );
                return Future.value(true);
              },
              onCancelClick: () {
                Get.back();
                return Future.value(false);
              },
            ),
          );

          return Future.value(false);
        });
  }

  _appBar() {
    return AppBar(
      leading: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          Get.dialog(
            CustomDialogWidget(
              content: '결제를 취소하시겠습니까?',
              isSingleButton: false,
              okTxt: '확인',
              cancelTxt: '취소',
              onClick: () {
                Get.back();
                Get.back();
                Get.dialog(
                  CustomDialogWidget(
                      content: '결제를 취소하였습니다.',
                      onClick: () {
                        Get.back();
                      }),
                );
              },
              onCancelClick: () {
                Get.back();
                return Future.value(false);
              },
            ),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(18.0),
          child: SvgPicture.asset(
            'assets/icons/btn_arrow_left.svg',
            width: 18,
            height: 18,
          ),
        ),
      ),
      title: Text("결제", style: medium16TextStyle.copyWith(color: primaryColor)),
      titleSpacing: 0,
      centerTitle: true,
      titleTextStyle: medium16TextStyle.copyWith(color: primaryColor),
      backgroundColor: whiteColor,
      elevation: 4,
      shadowColor: blackColor.withOpacity(0.05),
      automaticallyImplyLeading: false,
    );
  }
}
