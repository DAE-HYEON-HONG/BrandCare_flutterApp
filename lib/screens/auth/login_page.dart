import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/auth/login_controller.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/button/custom_button_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_checkbox_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/form_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'dart:io';

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: Container(
            width: double.infinity,
            height: double.infinity,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  const SizedBox(height: 109),
                  Padding(
                    padding:
                    const EdgeInsets.only(left: 16, right: 16,),
                    child: Form(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SvgPicture.asset(
                            'assets/icons/title_logo.svg',
                            color: primaryColor,
                          ),
                          const SizedBox(
                            height: 60,
                          ),
                          FormInputWidget(
                            onChange: (value) {},
                            onSubmit: (value) {},
                            controller: controller.emailController,
                            hint: '???????????? ??????????????????.',
                            textInputType: TextInputType.emailAddress,
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          FormInputWidget(
                            onChange: (value) {},
                            onSubmit: (value) {},
                            controller: controller.passwordController,
                            hint: '??????????????? ??????????????????.',
                            isObscureText: true,
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          CustomButtonWidget(
                            onClick: () async => await controller.login(),
                            title: '?????????',
                            isBold: true,
                            radius: 24,
                          ),
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.only(top: 13, bottom: 22),
                            child: Align(
                              alignment: AlignmentDirectional.centerEnd,
                              child: Obx(() => GestureDetector(
                                  onTap: () {
                                    controller.changeAutoLogin();
                                  },
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      CustomCheckBoxWidget(
                                          isChecked: controller.isAutoLogin.value),
                                      const SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        '????????? ??????',
                                        style: medium14TextStyle,
                                      )
                                    ],
                                  ))),
                            ),
                          ),
                          TextButton(
                            onPressed: () {
                              controller.notLoginMain();
                            },
                            child: Text(
                              '- ????????? ???????????? -',
                              style:
                              medium14TextStyle.copyWith(color: gray_8E8F95Color),
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ...controller.textList.map((e) => Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      _itemTextButton(
                                          title: e.keys.first, link: e.values.first, argument: e.values.last),
                                      if (controller.textList.indexOf(e) != 2)
                                        Container(
                                          width: 1,
                                          height: 13.w,
                                          color: gray_D5D7DBColor,
                                        )
                                    ],
                                  )),
                                ],
                              ),
                              const SizedBox(height: 10),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  ...controller.snsLoginItem.map((e) => Padding(
                                    padding: const EdgeInsets.symmetric(horizontal: 15),
                                    child: _itemSnsLogin(
                                        svgLink: 'assets/icons/$e', onClick: () => controller.loginButton(e)),
                                  ))
                                ],
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 32,
                          ),
                        ],
                      ),
                    ),
                  ),
                  if(Platform.isAndroid) const SizedBox(height: 64,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _itemTextButton({
    required String title,
    required String link,
    required String argument,
  }) =>
      Container(
        child: TextButton(
          onPressed: () {
            if(title == '????????????'){
              controller.openSignUpDialog();
            }else {
              Get.toNamed(link, arguments: argument);
            }
          },
          child: Text(
            '$title',
            style: medium14TextStyle.copyWith(color: gray_333Color),
          ),
        ),
      );

  Widget _itemSnsLogin(
          {required String svgLink, required Function() onClick}) =>
      GestureDetector(
        onTap: onClick,
        child: Container(
          child: SvgPicture.asset(svgLink),
        ),
      );
}
