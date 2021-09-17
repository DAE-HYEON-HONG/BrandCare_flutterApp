import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/auth/find_controller.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/button/custom_button_onoff_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/button/custom_button_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/form_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FindPwComponent extends StatelessWidget {
  const FindPwComponent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final FindController controller = Get.find<FindController>();
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: AnimatedSwitcher(
                      duration: Duration(seconds: 1),
                      child: GetBuilder<FindController>(
                        builder: (_) {
                          if (controller.isPwAuth == false)
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 24,
                                ),
                                Text(
                                  '아이디(이메일)와 휴대전화 번호 인증을 하시면\n비밀번호 재설정을 하실 수 있습니다.',
                                  style: regular14TextStyle,
                                ),
                                const SizedBox(
                                  height: 24,
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    FormInputWidget(
                                      onChange: (value) {},
                                      onSubmit: (value) {},
                                      controller: controller.emailController,
                                      isShowTitle: true,
                                      title: '아이디(이메일)',
                                    ),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    Row(children: [
                                      Flexible(
                                        flex: 3,
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
                                      Obx(() => AnimatedContainer(
                                        duration: Duration(milliseconds: 500),
                                        width: ((!controller.isAuth ? 2 : 0) *
                                            (Get.width - 32)) /
                                            ((!controller.isAuth ? 2 : 0) + 3),
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              top: 8.0, left: 8.0),
                                          child: Column(
                                            children: [
                                              Text(
                                                '',
                                                style: medium14TextStyle,
                                              ),
                                              CustomButtonOnOffWidget(
                                                onClick: () => controller.smsAuth(),
                                                title: '인증번호 받기',
                                                radius: 4,
                                                isOn: controller.isPhone.value,
                                              ),
                                            ],
                                          ),
                                        ),
                                      )),
                                    ]),
                                    const SizedBox(
                                      height: 16,
                                    ),
                                    if (!controller.isAuth)
                                      Row(children: [
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
                                            padding: const EdgeInsets.only(
                                                top: 8.0, left: 8.0),
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
                                      ])
                                    else
                                      Text(
                                        '인증되었습니다.',
                                        style: medium14TextStyle.copyWith(
                                            color: Color(0xff169F00)),
                                      )
                                  ],
                                ),
                              ],
                            );
                          else
                            return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  Text(
                                    '새로운 비밀번호를 입력해주세요.',
                                    style: regular14TextStyle,
                                  ),
                                  const SizedBox(
                                    height: 24,
                                  ),
                                  FormInputWidget(
                                    onChange: (value) {
                                      controller.pwTxt.value = value;
                                    },
                                    onSubmit: (value) {},
                                    controller: controller.pwController,
                                    title: '비밀번호',
                                    isShowTitle: true,
                                    isObscureText: true,
                                  ),
                                  const SizedBox(height: 16,),
                                  FormInputWidget(
                                    onChange: (value) {
                                      controller.rePwTxt.value = value;
                                    },
                                    onSubmit: (value) {},
                                    controller: controller.rePwController,
                                    title: '비밀번호 확인',
                                    isShowTitle: true,
                                    isObscureText: true,
                                  )
                                ]);
                        },
                      ),
                    ),
                  ),
                  // GetBuilder<FindController>(
                  //     builder: (_) => SizedBox(height: controller.autoHeight(context)))
                  const SizedBox(height: 60),
                ],
              ),
            ),
          ),
          if(MediaQuery.of(context).viewInsets.bottom == 0)
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Obx(() => CustomButtonOnOffWidget(
                title: '확인',
                onClick: () {
                  controller.pwConfirm();
                },
                isOn: controller.pwState.value == FindPwStateEnum.AUTH ? controller.pwCheck : controller.enableButton.value)),
          ),
        ],
      ),
    );
  }
}
