import 'package:brandcare_mobile_flutter_v2/controllers/my/my_controller.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/button/custom_button_onoff_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/form_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PasswordChangePage extends StatelessWidget {
  const PasswordChangePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myController = Get.find<MyController>();
    //myController.initMyController();
    return DefaultAppBarScaffold(
        title: '비밀번호 변경',
        child: Stack(
          children: [
            Container(
              width: double.infinity,
              height: double.infinity,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: [
                    const SizedBox(height: 32,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: FormInputWidget(
                        onChange: (value) {
                          myController.nowPassword.value = value;
                        },
                        onSubmit: (value) {},
                        textInputType: TextInputType.visiblePassword,
                        controller: myController.currentPwController,
                        isShowTitle: true,
                        title: '현재 비밀번호',
                        hint: '현재 비밀번호를 입력해주세요',
                        isObscureText: true,

                      ),
                    ),
                    const SizedBox(height: 24,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: FormInputWidget(
                        onChange: (value) {
                          myController.password.value = value;
                        },
                        onSubmit: (value) {},
                        controller: myController.pwController,
                        textInputType: TextInputType.visiblePassword,
                        isShowTitle: true,
                        title: '새로운 비밀번호',
                        hint: '새로운 비밀번호를 입력해주세요',
                        isObscureText: true,
                      ),
                    ),
                    const SizedBox(height: 24,),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: FormInputWidget(
                        onChange: (value) {
                          myController.rePassword.value = value;
                        },
                        onSubmit: (value) {},
                        controller: myController.rePwController,
                        textInputType: TextInputType.visiblePassword,
                        isShowTitle: true,
                        title: '비밀번호 확인',
                        hint: '새로운 비밀번호를 한번 더 입력해주세요.',
                        isObscureText: true,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text('영문, 숫자, 특수문자로 8~20자리 입력해주세요.')
                  ],
                ),
              ),
            ),
            if(MediaQuery.of(context).viewInsets.bottom == 0)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: GetBuilder<MyController>(builder: (_) =>CustomButtonOnOffWidget(
                title: '확인',
                onClick: () async => myController.changePassword(),
                isOn: myController.changeColor(),
              )),
            ),
          ],
        ),
    );
  }
}
