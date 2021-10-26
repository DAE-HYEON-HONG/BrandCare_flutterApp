import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/AddProductControllers/addProductDescription_controller.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_form_submit.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class AddProductDescriptionPage
    extends GetView<AddProductDescriptionController> {
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () {
        Get.dialog(CustomDialogWidget(
          isSingleButton: false,
          content: '제품 추가정보 등록을 취소하시겠습니까?',
          okTxt: '확인',
          cancelTxt: '취소',
          onClick: () {
            Get.back();
            Get.back();
            return Future(() => true);
          },
          onCancelClick: () {
            Get.back();
            return Future(() => false);
          },
        ));

        return Future(() => false);
      },
      child: GestureDetector(
        onTap: () => FocusScope.of(context).unfocus(),
        child: DefaultAppBarScaffold(
          title: "제품 등록",
          child: _renderBody(context),
          backButtonDialog: true,
          backButtonDialogText: '제품 추가정보 등록을 취소하시겠습니까?',
        ),
      ),
    );
  }

  _renderBody(context) {
    return Obx(() => controller.runningServer.value ? new FutureBuilder<void>(
        future: controller.uploadAddProduct(),
        builder: (context, snapshot) {
          if (snapshot.hasError) print(snapshot.error);
          return snapshot.hasData
              ? MainContainer(context)
              : Stack(
                children: [
                  MainContainer(context),
                  Container(
                      width: double.infinity,
                      height: double.infinity,
                      color: Colors.grey.withOpacity(0.6),
                      child: Center(child: CircularProgressIndicator())),
                ],
              );
        },
      ) : MainContainer(context),
    );

    //   FutureBuilder(builder: builder)(
    //   builder: (context, snapshot) {
    //     return Container(
    //       width: double.infinity,
    //       height: double.infinity,
    //       child: Stack(
    //         children: <Widget>[
    //           SingleChildScrollView(
    //             scrollDirection: Axis.vertical,
    //             child: Padding(
    //               padding: const EdgeInsets.only(left: 16, right: 16),
    //               child: Column(
    //                 crossAxisAlignment: CrossAxisAlignment.start,
    //                 children: <Widget>[
    //                   const SizedBox(height: 32),
    //                   Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: <Widget>[
    //                       Text(
    //                         "추가정보를 입력하세요.",
    //                         style: medium14TextStyle,
    //                       ),
    //                       const SizedBox(height: 16),
    //                       Text(
    //                         "제품 컨디션(중복 선택 가능)",
    //                         style: medium14TextStyle,
    //                       ),
    //                     ],
    //                   ),
    //                   const SizedBox(height: 15),
    //                   Obx(() => GridView.count(
    //                         childAspectRatio: 8 / 2,
    //                         physics: NeverScrollableScrollPhysics(),
    //                         shrinkWrap: true,
    //                         crossAxisCount: 3,
    //                         crossAxisSpacing: 2,
    //                         children: [
    //                           _choice("오염", controller.dirty.value),
    //                           _choice("파손", controller.broken.value),
    //                           _choice("문제 없음", controller.nothing.value),
    //                         ],
    //                       )),
    //                   Divider(height: 1, color: gray_f5f6f7Color),
    //                   const SizedBox(height: 16),
    //                   Text(
    //                     "제품 구성품(중복 선택 가능)",
    //                     style: medium14TextStyle,
    //                   ),
    //                   const SizedBox(height: 15),
    //                   Obx(() => GridView.count(
    //                         childAspectRatio: 8 / 2,
    //                         physics: NeverScrollableScrollPhysics(),
    //                         shrinkWrap: true,
    //                         crossAxisCount: 3,
    //                         crossAxisSpacing: 2,
    //                         children: [
    //                           _choice("더스트백", controller.dustBag.value),
    //                           _choice("보증서", controller.guarantee.value),
    //                           _choice("없음", controller.notExist.value),
    //                         ],
    //                       )),
    //                   Divider(height: 1, color: gray_f5f6f7Color),
    //                   const SizedBox(height: 16),
    //                   Text(
    //                     "기타",
    //                     style: medium14TextStyle,
    //                   ),
    //                   const SizedBox(height: 16),
    //                   Container(
    //                     padding: EdgeInsets.symmetric(horizontal: 10),
    //                     decoration: BoxDecoration(
    //                       border: Border.all(
    //                         color: Color(0xffD5D7DB),
    //                         width: 1.0,
    //                       ),
    //                       borderRadius: BorderRadius.circular(5),
    //                     ),
    //                     child: ConstrainedBox(
    //                       constraints: BoxConstraints(
    //                         minHeight: 290,
    //                         maxHeight: 700,
    //                       ),
    //                       child: TextFormField(
    //                         onChanged: (value) => controller.formChk(),
    //                         maxLines: null,
    //                         controller: controller.desBody,
    //                         maxLength: 200,
    //                         style:
    //                             regular14TextStyle.copyWith(color: gray_999Color),
    //                         decoration: InputDecoration(
    //                           border: InputBorder.none,
    //                           focusedBorder: InputBorder.none,
    //                           disabledBorder: InputBorder.none,
    //                           enabledBorder: InputBorder.none,
    //                           hintText: "내용을 입력하세요. (200자 미만)",
    //                           hintStyle:
    //                               regular14TextStyle.copyWith(color: gray_999Color),
    //                           counterText: "",
    //                         ),
    //                       ),
    //                     ),
    //                   ),
    //                   const SizedBox(height: 110),
    //                   // GetBuilder<AddProductDescriptionController>(
    //                   //     builder: (_) => SizedBox(height: controller.autoHeight(context)))
    //                 ],
    //               ),
    //             ),
    //           ),
    //           if (MediaQuery.of(context).viewInsets.bottom == 0)
    //             Positioned(
    //               left: 0,
    //               right: 0,
    //               bottom: 0,
    //               child: Obx(() => CustomFormSubmit(
    //                     title: "확인",
    //                     onTab: () {
    //                       controller.reallyAdd();
    //                     },
    //                     fill: controller.fill.value,
    //                   )),
    //             )
    //         ],
    //       ),
    //     );
    //   }
    // );
  }

  _choice(String title, bool isChecked) {
    return GestureDetector(
      onTap: () => controller.choiceChk(title),
      child: Container(
        width: double.infinity,
        height: 20,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SvgPicture.asset(
              isChecked
                  ? 'assets/icons/check_on.svg'
                  : 'assets/icons/check_off.svg',
              height: 20,
            ),
            const SizedBox(width: 8),
            Text(
              title,
              style: regular12TextStyle,
            ),
          ],
        ),
      ),
    );
  }

  Widget MainContainer(context){
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: <Widget>[
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 32),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        "추가정보를 입력하세요.",
                        style: medium14TextStyle,
                      ),
                      const SizedBox(height: 16),
                      Text(
                        "제품 컨디션(중복 선택 가능)",
                        style: medium14TextStyle,
                      ),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Obx(() => GridView.count(
                    childAspectRatio: 8 / 2,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    crossAxisSpacing: 2,
                    children: [
                      _choice("오염", controller.dirty.value),
                      _choice("파손", controller.broken.value),
                      _choice("문제 없음", controller.nothing.value),
                    ],
                  )),
                  Divider(height: 1, color: gray_f5f6f7Color),
                  const SizedBox(height: 16),
                  Text(
                    "제품 구성품(중복 선택 가능)",
                    style: medium14TextStyle,
                  ),
                  const SizedBox(height: 15),
                  Obx(() => GridView.count(
                    childAspectRatio: 8 / 2,
                    physics: NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    crossAxisCount: 3,
                    crossAxisSpacing: 2,
                    children: [
                      _choice("더스트백", controller.dustBag.value),
                      _choice("보증서", controller.guarantee.value),
                      _choice("없음", controller.notExist.value),
                    ],
                  )),
                  Divider(height: 1, color: gray_f5f6f7Color),
                  const SizedBox(height: 16),
                  Text(
                    "기타",
                    style: medium14TextStyle,
                  ),
                  const SizedBox(height: 16),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xffD5D7DB),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: 290,
                        maxHeight: 700,
                      ),
                      child: TextFormField(
                        onChanged: (value) => controller.formChk(),
                        maxLines: null,
                        controller: controller.desBody,
                        maxLength: 200,
                        style:
                        regular14TextStyle.copyWith(color: gray_999Color),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintText: "내용을 입력하세요. (200자 미만)",
                          hintStyle:
                          regular14TextStyle.copyWith(color: gray_999Color),
                          counterText: "",
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 110),
                  // GetBuilder<AddProductDescriptionController>(
                  //     builder: (_) => SizedBox(height: controller.autoHeight(context)))
                ],
              ),
            ),
          ),
          if (MediaQuery.of(context).viewInsets.bottom == 0)
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Obx(() => CustomFormSubmit(
                title: "확인",
                onTab: () {
                  controller.reallyAdd();
                },
                fill: controller.fill.value,
              )),
            )
        ],
      ),
    );
  }
}
