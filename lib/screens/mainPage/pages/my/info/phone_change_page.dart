import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/global_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/my_controller.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/button/custom_button_onoff_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/button/custom_button_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/form_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PhoneChangePage extends StatelessWidget {
  const PhoneChangePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myController = Get.find<MyController>();
    final globalCtrl = Get.find<GlobalController>();
    //myController.initMyController();
    return DefaultAppBarScaffold(
        title: '전화번호 변경',
        child: GetBuilder<MyController>(
          builder: (_) {
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
                          child: FormInputWidget(
                            onChange: (value) {},
                            onSubmit: (value) {},
                            controller: TextEditingController(),
                            readOnly: true,
                            isShowTitle: true,
                            title: '등록된 전화번호',
                            hint: globalCtrl.userInfoModel!.phNum,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          child: Row(
                              children: [
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 500),
                                  width: ((!myController.isAuth.value ? 3 : 1) *
                                      (Get.width - 32)) /
                                      ((!myController.isAuth.value ? 3 : 1) + (!myController.isAuth.value ? 2 : 0)),
                                  child: FormInputWidget(
                                    onChange: (value) {
                                      myController.phone.value = value;
                                    },
                                    onSubmit: (value) {},
                                    readOnly: myController.isAuth.value,
                                    controller: myController.phoneController,
                                    textInputType: TextInputType.phone,
                                    isShowTitle: true,
                                    title: '전화번호 변경',
                                    hint: '전화번호를 입력하세요',
                                  ),
                                ),
                                AnimatedContainer(
                                  duration: Duration(milliseconds: 500),
                                  width: ((!myController.isAuth.value ? 2 : 0) *
                                      (Get.width - 32)) /
                                      ((!myController.isAuth.value ? 2 : 0) + (!myController.isAuth.value ? 3 : 1)),
                                  child: Padding(
                                    padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                                    child: Column(
                                      children: [
                                        Text(
                                          '',
                                          style: medium14TextStyle,
                                        ),
                                        Obx(() => CustomButtonOnOffWidget(
                                          onClick: () async => await myController.smsAuth(),
                                          title: '인증번호 받기',
                                          radius: 4,
                                          isOn: myController.isPhone,
                                        )),
                                      ],
                                    ),
                                  ),
                                ),
                              ]),
                        ),
                        const SizedBox(height: 10),
                        if(!myController.isAuth.value)
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),
                            child: Row(
                                children: [
                                  Flexible(
                                    flex: 2,
                                    child: FormInputWidget(
                                      onChange: (value) {
                                        myController.code.value = value;
                                      },
                                      onSubmit: (value) {},
                                      controller: myController.codeController,
                                      textInputType: TextInputType.number,
                                      isShowTitle: true,
                                      title: '인증번호',
                                      hint: '인증번호를 입력하세요',
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
                                            onClick: () => myController.smsAuthChk(),
                                            title: '인증확인',
                                            radius: 4,
                                            isOn: myController.isCode,
                                          )),
                                        ],
                                      ),
                                    ),
                                  ),

                                ]),
                          )
                        else
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 16),

                            child: Text('인증되었습니다.', style: medium14TextStyle.copyWith(color: Color(0xff169F00)),),
                          ),
                      ],
                    ),
                  ),
                  if(MediaQuery.of(context).viewInsets.bottom == 0)
                  Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: GetBuilder<MyController>(builder: (_) => CustomButtonOnOffWidget(
                      title: '확인',
                      onClick: () async => await myController.changePhone(),
                      isOn: myController.changeColor(),
                    )),
                  ),
                ],
              ),
            );
          },
        )

    );
  }
}
