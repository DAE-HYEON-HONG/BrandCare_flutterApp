import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/auth/signup_controller.dart';
import 'package:brandcare_mobile_flutter_v2/utils/regex_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/button/custom_button_empty_background_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/button/custom_button_onoff_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_checkbox_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/form_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class SignUpPage extends GetView<SignUpController> {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultAppBarScaffold(
      title: '회원가입',
      child: SafeArea(
        child: Form(
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      FormInputWidget(
                        onChange: (value) {
                          controller.emailTxt.value =
                              controller.emailController.text;
                          controller.duplicateEmail.value =
                              SignUpCheckEmail.NONE;
                        },
                        onSubmit: (value) {},
                        controller: controller.emailController,
                        textInputType: TextInputType.emailAddress,
                        isShowTitle: true,
                        title: '아이디(이메일)',
                        hint: '이메일 주소를 입력해주세요.',
                      ),
                      const SizedBox(height: 16),
                      Obx(() =>
                          _emailCheckWidget(controller.duplicateEmail.value)),
                      const SizedBox(height: 16),
                      FormInputWidget(
                        onChange: (value) {
                        },
                        onSubmit: (value) {
                        },
                        controller: controller.passwordController,
                        isShowTitle: true,
                        title: '비밀번호',
                        hint: '영문, 숫자, 특수문자로 8~20자리 입력해주세요.',
                        isObscureText: true,
                      ),
                      const SizedBox(height: 16),
                      FormInputWidget(
                        onChange: (value) {},
                        onSubmit: (value) {},
                        controller: controller.rePasswordController,
                        isShowTitle: true,
                        title: '비밀번호 확인',
                        hint: '비밀번호를 확인하세요.',
                        isObscureText: true,
                      ),
                      const SizedBox(height: 16),
                      FormInputWidget(
                        onChange: (value) {},
                        onSubmit: (value) {},
                        controller: controller.nameController,
                        isShowTitle: true,
                        title: '이름(닉네임)',
                        hint: '이름(닉네임)을 입력해주세요.(8자리 이하)',
                      ),
                      const SizedBox(height: 16),
                      _itemPhoneInput(),
                      const SizedBox(height: 16),
                      _itemAuthNumber(),
                      const SizedBox(height: 16),
                      FormInputWidget(
                        onChange: (value) {},
                        onSubmit: (value) {},
                        controller: controller.friendCodeController,
                        isShowTitle: true,
                        title: '친구 초대 코드(선택)',
                        hint: '친구에게 받은 초대 코드를 입력해주세요.',
                        isObscureText: true,
                      ),
                      const SizedBox(height: 16),
                      _itemAgreeContainer(),
                      const SizedBox(height: 32),
                    ],
                  ),
                ),
                Obx(() => CustomButtonOnOffWidget(
                      title: '회원가입',
                      onClick: () => controller.registerChk(),
                      isOn: controller.allAgree,
                      radius: 0,
                    )),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _itemPhoneInput() => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
                margin: const EdgeInsets.only(bottom: 8),
                child: Text(
                  '전화번호',
                  style: medium14TextStyle,
                )),
            Row(
              children: [
                Flexible(
                  flex: 3,
                  child: TextFormField(
                    controller: controller.phoneController,
                    style: regular12TextStyle,
                    keyboardType: TextInputType.phone,
                    onChanged: (value) {
                      controller.phoneTxt.value =
                          controller.phoneController.text;
                    },
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.all(15),
                      hintText: '전화번호를 입력하세요.',
                      hintStyle:
                          regular12TextStyle.copyWith(color: gray_999Color),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(color: Color(0xffD5D7DB)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(color: primaryColor),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Flexible(
                    flex: 2,
                    child: Obx(() => CustomButtonOnOffWidget(
                        title: '인증번호 받기',
                        onClick: () {},
                        isOn: controller.isPhone.value)))
              ],
            ),
          ],
        ),
      );

  Widget _itemAuthNumber() => Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                    margin: const EdgeInsets.only(right: 16),
                    child: Text(
                      '인증번호',
                      style: medium14TextStyle,
                    )),
                Text(
                  '3:00:00',
                  style: medium14TextStyle.copyWith(color: redColor),
                )
              ],
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                Flexible(
                  flex: 2,
                  child: TextFormField(
                    controller: controller.authNumberController,
                    style: regular12TextStyle,
                    keyboardType: TextInputType.number,
                    onChanged: (value) {},
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.all(15),
                      hintText: '인증번호를 입력하세요',
                      hintStyle:
                          regular12TextStyle.copyWith(color: gray_999Color),
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(color: Color(0xffD5D7DB)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(4),
                        borderSide: BorderSide(color: primaryColor),
                      ),
                    ),
                  ),
                ),
                const SizedBox(
                  width: 8,
                ),
                Flexible(
                    flex: 1,
                    child: CustomButtonOnOffWidget(
                        title: '인증확인',
                        onClick: () {},
                        isOn: controller.authCode.value))
              ],
            ),
          ],
        ),
      );

  Widget _itemAgreeContainer() => Container(
        width: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          border: Border.all(color: gray_D5D7DBColor),
        ),
        child: Column(
          children: [
            GestureDetector(
              onTap: () {
                controller.allUpdate();
              },
              child: Padding(
                  padding: const EdgeInsets.only(left: 16, top: 12, bottom: 8),
                  child: Obx(
                    () => Row(
                      children: [
                        CustomCheckBoxWidget(isChecked: controller.allAgree),
                        const SizedBox(
                          width: 12,
                        ),
                        Text(
                          '전체동의',
                          style: medium14TextStyle,
                        ),
                      ],
                    ),
                  )),
            ),
            const Divider(
              height: 0,
              thickness: 1,
              color: Color(0xffF5F6F7),
            ),
            const SizedBox(
              height: 27,
            ),
            Obx(() => _itemAgree(controller.agree.value, '이용약관 동의(필수)')),
            const SizedBox(
              height: 19,
            ),
            Obx(() =>
                _itemAgree(controller.privacyAgree.value, '개인정보 취급방침 동의(필수)')),
            const SizedBox(
              height: 25,
            ),
          ],
        ),
      );

  Widget _itemAgree(bool isChecked, String title) => Container(
        padding: const EdgeInsets.only(left: 16, right: 17),
        child: Row(
          children: [
            GestureDetector(
              onTap: () {
                if (title.contains('이용약관'))
                  controller.agreeUpdate();
                else if (title.contains('개인정보')) controller.privacyUpdate();
              },
              behavior: HitTestBehavior.translucent,
              child: Row(
                children: [
                  CustomCheckBoxWidget(isChecked: isChecked),
                  const SizedBox(
                    width: 12,
                  ),
                  Text(
                    '$title',
                    style: medium14TextStyle.copyWith(color: gray_666Color),
                  ),
                ],
              ),
            ),
            const Spacer(),
            SvgPicture.asset(
              'assets/icons/btn_arrow_right.svg',
              color: gray_666Color,
            )
          ],
        ),
      );

  Widget _emailCheckWidget(SignUpCheckEmail emailCheck) {
    if (emailCheck == SignUpCheckEmail.DONE) {
      return CustomButtonEmptyBackgroundWidget(
        title: '사용 가능합니다',
        radius: 4,
        onClick: () {},
      );
    } else if (emailCheck == SignUpCheckEmail.DUPLICATE) {
      return CustomButtonEmptyBackgroundWidget(
        title: '이미 등록된 계정입니다.',
        radius: 4,
        onClick: () {},
      );
    } else {
      return CustomButtonOnOffWidget(
        title: '중복확인',
        onClick: () =>
            controller.chkDuplicateEmail(controller.emailController.text),
        radius: 4,
        isOn: controller.isEmail.value,
      );
    }
  }
}
