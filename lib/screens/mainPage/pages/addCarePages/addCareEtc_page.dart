import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/addCareControllers/addCareEtc_controller.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_form_submit.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCareEtcPage extends GetView<AddCareEtcController> {
  @override
  Widget build(BuildContext context) {
    return DefaultAppBarScaffold(
      title: "케어/수선 신청",
      child: _renderBody(),
    );
  }

  _renderBody(){
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'n개의 케어/수선 진행',
                        style: medium14TextStyle,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Text(
                          '+ 케어/수선할 제품 추가',
                          style: medium14TextStyle.copyWith(
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  //리스트뷰 추가
                  const SizedBox(height: 24),
                  Text(
                    '케어/수선 요청사항',
                    style: medium14TextStyle,
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: gray_D5D7DBColor,
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: 160,
                        maxHeight: 700,
                      ),
                      child: TextFormField(
                        onChanged: (value) => {},
                        maxLines: null,
                        controller: controller.etcDescription,
                        style: regular14TextStyle.copyWith(color: gray_999Color),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintText: "신청 항목 별로 케어/수선 요청사항을\n자세하게 작성해주세요.",
                          hintStyle: regular14TextStyle.copyWith(color: gray_999Color),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          Obx(()=> Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomFormSubmit(
              title: "다음",
              onTab: () => controller.nextLevel(),
              fill: controller.fill.value,
            ),
          )),
        ],
      ),
    );
  }
}
