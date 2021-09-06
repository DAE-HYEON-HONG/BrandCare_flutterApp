import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/auth/find_controller.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/button/custom_button_onoff_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/button/custom_button_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/form_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FindIdComponent extends StatelessWidget {
  const FindIdComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FindController controller = Get.find<FindController>();
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 24,
                      ),
                      Text(
                        '휴대전화 번호를 입력하시면\n아이디를 확인하실 수 있습니다.',
                        style: regular14TextStyle,
                      ),
                      const SizedBox(
                        height: 24,
                      ),
                      GetBuilder<FindController>(builder: (_) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                                children: [
                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 500),
                                    width: ((controller.idState.value == FindIdStateEnum.FIND_ALL_ID ? 3 : 1) * (Get.width - 32)) / ((controller.idState.value == FindIdStateEnum.FIND_ALL_ID ? 3 : 1) + (controller.idState.value == FindIdStateEnum.FIND_ALL_ID ? 2 : 0)),
                                    child: FormInputWidget(
                                      onChange: (value) {
                                        controller.phoneTxt.value = value;
                                      },
                                      onSubmit: (value) {},
                                      controller: controller.phoneController,
                                      isShowTitle: true,
                                      title: '전화번호',
                                      textInputType: TextInputType.number,
                                    ),
                                  ),
                                  AnimatedContainer(
                                    duration: Duration(milliseconds: 500),
                                    width: ((controller.idState.value == FindIdStateEnum.FIND_ALL_ID ? 2 : 0) * (Get.width - 32)) / ((controller.idState.value == FindIdStateEnum.FIND_ALL_ID ? 2 : 0) + (controller.idState.value == FindIdStateEnum.FIND_ALL_ID ? 3 : 1)),
                                    child: Padding(
                                      padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                                      child: Column(
                                        children: [
                                          Text(
                                            '',
                                            style: medium14TextStyle,
                                          ),
                                          CustomButtonWidget(
                                            onClick: () => controller.smsAuth(),
                                            title: '재발송',
                                            radius: 4,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ]),
                            const SizedBox(height: 16,),
                            if(!controller.isAuth)
                              AnimatedOpacity(
                                opacity: (controller.idState.value == FindIdStateEnum.FIND_ALL_ID) ? 1.0 : 0.0,
                                duration: Duration(milliseconds: 500),
                                child: Row(
                                    children: [
                                      Flexible(
                                        flex: 2,
                                        child: FormInputWidget(
                                          onChange: (value) {
                                            controller.codeTxt.value = value;
                                          },
                                          onSubmit: (value) {},
                                          controller: controller.authCodeController,
                                          isShowTitle: true,
                                          title: '인증번호',
                                          textInputType: TextInputType.number,
                                        ),
                                      ),

                                      Flexible(
                                        flex: 1,
                                        child: Padding(
                                          padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                                          child: Column(
                                            children: [
                                              Text(
                                                '',
                                                style: medium14TextStyle,
                                              ),
                                              Obx(() => CustomButtonOnOffWidget(
                                                onClick: () {
                                                  controller.smsAuthChk();
                                                },
                                                title: '인증확인',
                                                radius: 4,
                                                isOn: controller.isCode.value,
                                              )),
                                            ],
                                          ),
                                        ),
                                      ),

                                    ]),
                              )
                            else
                              Text('인증되었습니다.', style: medium14TextStyle.copyWith(color: Color(0xff169F00)),)
                          ],
                        );
                      }),
                    ],
                  ),
                ),
                GetBuilder<FindController>(
                    builder: (_) => SizedBox(height: controller.autoHeight(context)))
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Obx(() =>
                CustomButtonOnOffWidget(
                    title: '확인', onClick: () {
                  controller.idConfirm();
                }, isOn: controller.enableButton.value)),
          )
        ],
      ),
    );
  }
}
