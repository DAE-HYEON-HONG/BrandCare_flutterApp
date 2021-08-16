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

class LoginPage extends GetView<LoginController> {
  const LoginPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
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
                  hint: '이메일을 입력해주세요,',
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 8,
                ),
                FormInputWidget(
                  onChange: (value) {},
                  onSubmit: (value) {},
                  controller: controller.passwordController,
                  hint: '비밀번호를 입력해주세요.',
                  isObscureText: true,
                ),
                const SizedBox(
                  height: 20,
                ),
                CustomButtonWidget(
                  onClick: () {},
                  title: '로그인',
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
                              '로그인 유지',
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
                    '- 비회원 둘러보기 -',
                    style:
                        medium14TextStyle.copyWith(color: gray_8E8F95Color),
                  ),
                ),
                const SizedBox(
                  height: 24,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...controller.textList.map((e) => Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            _itemTextButton(
                                title: e.keys.first, link: e.values.first),
                            if (controller.textList.indexOf(e) != 2)
                              Container(
                                width: 1,
                                height: 13.w,
                                color: gray_D5D7DBColor,
                              )
                          ],
                        ))
                  ],
                ),
                const SizedBox(
                  height: 32,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    ...controller.snsLoginItem.map((e) => Padding(
                          padding: EdgeInsets.only(
                              right: controller.snsLoginItem.indexOf(e) != 3
                                  ? 24
                                  : 0),
                          child: _itemSnsLogin(
                              svgLink: 'assets/icons/$e', onClick: () {}),
                        ))
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _itemTextButton({
    required String title,
    required String link,
  }) =>
      Container(
        child: TextButton(
          onPressed: () {
            if(title == '회원가입'){
              controller.openSignUpDialog();
            }else {
              Get.toNamed(link);
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
