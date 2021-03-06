import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/inquiry_controller.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/button/custom_button_onoff_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/form_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InquiryPage extends StatelessWidget {
  const InquiryPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.find<InquiryController>();
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Container(
        child: Stack(
          children: [
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Padding(
                padding: const EdgeInsets.only(left:16, right: 16),
                child: SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      const SizedBox(height: 24,),
                      FormInputWidget(onChange: (value){
                        controller.title.value = value;
                      }, onSubmit: (value){}, controller: controller.titleCtrl,
                        hint: '제목',
                      ),
                      const SizedBox(height: 16,),
                      TextFormField(
                        controller: controller.contentsCtrl,
                        style: regular12TextStyle,
                        onChanged: (value){
                          controller.content.value = value;
                        },
                        minLines: 15,
                        maxLines: 15,
                        decoration: InputDecoration(
                          isDense: true,
                          contentPadding: const EdgeInsets.all(15),
                          hintText: '내용을 입력하세요.',
                          hintStyle: regular12TextStyle.copyWith(color: gray_999Color),
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
                      GetBuilder<InquiryController>(
                          builder: (_) => SizedBox(height: controller.autoHeight(context))),
                    ],
                  ),
                ),
              ),
            ),
            Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Obx(() =>
                    CustomButtonOnOffWidget(
                      title: '문의하기',
                      onClick: () => controller.reallyAdd(okTap: () async => await controller.addInquiry(context)),
                      isOn: controller.isOn,
                      radius: 0,
                    ),
                )),
          ],
        ),
      ),
    );
  }
}
