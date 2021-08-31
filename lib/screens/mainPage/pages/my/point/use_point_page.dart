import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/point_controller.dart';
import 'package:brandcare_mobile_flutter_v2/utils/number_format_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/button/custom_button_empty_background_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/form_input_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PointUsePage extends StatelessWidget {
  const PointUsePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    final controller = Get.find<PointController>();
    TextEditingController _textEditingController = TextEditingController();
    return DefaultAppBarScaffold(
      title: '포인트',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Flexible(
              child: GetBuilder<PointController>(
                builder: (_) => Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32),
                      child: Row(
                        children: [
                          Text(
                            '보유 포인트',
                            style: medium16TextStyle,
                          ),
                          const Spacer(),
                          Obx(() => Text(
                                '${NumberFormatUtil.convertNumberFormat(number: controller.myPoint.value)}P',
                                style: medium16TextStyle,
                              )),
                        ],
                      ),
                    ),
                    Container(
                      width: double.infinity,
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: InkWell(
                          onTap: () {
                            _textEditingController.text = controller.myPoint.value.toString();
                            controller.usePoint.value = controller.myPoint.value;
                          },
                          child: Container(
                            width: 72,
                            height: 24,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(24),
                                border: Border.all(color: primaryColor, width: 1)),
                            child: Center(
                              child: Text(
                                "모두사용",
                                style: regular12TextStyle.copyWith(color: primaryColor),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 24,),
                    FormInputWidget(
                      onChange: (value){
                        if(controller.usePoint.value > controller.myPoint.value){
                          _textEditingController.text = controller.myPoint.value.toString();
                          controller.usePoint.value = controller.myPoint.value;
                        }
                        else {
                          controller.usePoint.value = int.parse(value);
                        }
                    }, onSubmit: (value){}, controller: _textEditingController,
                      textInputType: TextInputType.number,
                      hint: '사용할 포인트를 입력해주세요.',
                    ),
                  ],
                ),
              ),
            ),
            CustomButtonEmptyBackgroundWidget(title: '적용하기', onClick: (){

            }),
          ],
        ),
      ),
    );
  }
}
