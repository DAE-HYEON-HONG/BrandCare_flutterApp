import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/addCareControllers/addCareEtc_controller.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/addCarePages/addCareAddList_page.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_form_submit.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

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
                        '${controller.addCareList!.length}개의 케어/수선 진행',
                        style: medium14TextStyle,
                      ),
                      GestureDetector(
                        onTap: () => Get.to(() => AddCareAddListPage()),
                        child: Text(
                          '+ 케어/수선할 제품 추가',
                          style: medium14TextStyle.copyWith(
                            color: primaryColor,
                          ),
                        ),
                      ),
                    ],
                  ),
                  GetBuilder<AddCareEtcController>(builder: (_) => ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    itemCount: controller.addCareList!.length,
                    itemBuilder: (context, idx){
                      return _careProduct(
                        controller.addCareList![idx],
                        controller.addCareList![idx].picture,
                        controller.addCareList![idx].category,
                        controller.addCareList![idx].secondCategory,
                        idx,
                      );
                    },
                  )),
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
                        onChanged: (value) => controller.fillChange(),
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
                  const SizedBox(height: 120),
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

  _careProduct(dynamic idx, File img, String category, String options, int idxNum){
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 24),
      width: double.infinity,
      height: 158,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(width: 1, color: gray_D5D7DBColor),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 88,
                  height: 88,
                  child: Image.file(img,fit: BoxFit.cover),
                ),
                const SizedBox(width: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(category, style: medium14TextStyle.copyWith(fontWeight: FontWeight.w700)),
                    const SizedBox(height: 10),
                    Text("- $options", style: regular14TextStyle),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            height: 1,
            color: gray_D5D7DBColor,
          ),
          Expanded(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisSize: MainAxisSize.max,
              children: [
                GestureDetector(
                  onTap: () => controller.removeList(idx),
                  child: Text('삭제하기', style: medium14TextStyle.copyWith(color: gray_D5D7DBColor)),
                ),
                const SizedBox(width: 8),
                GestureDetector(
                  onTap: () => controller.modifiedProduct(idxNum),
                  child: Text('수정하기', style: medium14TextStyle),
                ),
                const SizedBox(width: 16),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
