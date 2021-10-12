import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/addCareControllers/addCareEtc_controller.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/addCarePages/addCareAddList_page.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_form_submit.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'dart:io';

class AddCareEtcPage extends GetView<AddCareEtcController> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      //resizeToAvoidBottomInset: false,
      backgroundColor: whiteColor,
      appBar: AppBar(
        leading: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: () => controller.backModified(),
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: SvgPicture.asset('assets/icons/btn_arrow_left.svg', width: 18, height: 18,),
          ),
        ),
        title: Text("케어/수선 신청",style: medium16TextStyle.copyWith(color: primaryColor)),
        titleSpacing: 0,
        centerTitle: true,
        titleTextStyle: medium16TextStyle.copyWith(color: primaryColor),
        backgroundColor: whiteColor,
        elevation: 4,
        shadowColor: blackColor.withOpacity(0.05),
        automaticallyImplyLeading: false,
      ),
      body: _renderBody(context),
    );
  }

  _renderBody(context){
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
                      GetBuilder<AddCareEtcController>(builder: (_) => Text(
                        '${controller.addCareList!.length}개의 케어/수선 진행',
                        style: medium14TextStyle,
                      )),
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
                          hintText: "신청 항목의 요청사항을\n자세히 작성해주세요.\n(예. 항목1 - 내용/ 항목2 - 내용)",
                          hintStyle: regular14TextStyle.copyWith(color: gray_999Color),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 120),
                  // GetBuilder<AddCareEtcController>(
                  //     builder: (_) => SizedBox(height: controller.autoHeight(context)))
                ],
              ),
            ),
          ),
          if(MediaQuery.of(context).viewInsets.bottom == 0)
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
    print(idxNum);
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
          Container(
            width: double.infinity,
            height: 120,
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
                Expanded(
                  child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(category, style: medium14TextStyle.copyWith(fontWeight: FontWeight.w700)),
                    const SizedBox(height: 10),
                    Expanded(
                      child: Text("- $options", style: regular14TextStyle),
                    ),
                   ],
                  ),
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
                  child: Text('삭제하기', style: medium14TextStyle.copyWith(
                      color: controller.addCareList!.length > 1 ? Colors.black : gray_D5D7DBColor,
                  )),
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
