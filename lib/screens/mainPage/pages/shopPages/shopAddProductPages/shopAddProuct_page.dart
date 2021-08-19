import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/shopControllers/shopAddProductController/shopAddProduct_controller.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_expansion_field.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_form_submit.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/form_input_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'dart:io';

class ShopAddProductPage extends GetView<ShopAddProductController> {
  @override
  Widget build(BuildContext context) {
    return DefaultAppBarScaffold(
      title: "거래등록",
      child: _renderBody(context),
    );
  }

  _photoApply() {
    return GetBuilder<ShopAddProductController>(builder:(_) => SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 15),
            width: 80,
            height: 80,
            color: whiteColor,
            child: GestureDetector(
              onTap: () async{
                await controller.loadAssets();
              },
              child: DottedBorder(
                  color: gray_D5D7DBColor,
                  strokeWidth: 1,
                  child: SizedBox(
                    width: 80,
                    height: 80,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        SvgPicture.asset(
                          "assets/icons/camera.svg",
                          height: 31,
                        ),
                        Text(
                          "${controller.pickImgList?.length}/10",
                          style: medium14TextStyle.copyWith(color: primaryColor),
                        ),
                      ],
                    ),
                  )
              ),
            ),
          ),
          Row(
            children: controller.pickImgList!.map((e) {
              return Stack(
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.only(right: 15),
                    child: SizedBox(
                      width: 80,
                      height: 80,
                      child: Image.file(File(e.path)),
                    ),
                  ),
                  Positioned(
                      top: 8,
                      right: 8,
                      child: GestureDetector(
                        onTap: () => controller.removePics(obj: e),
                        child: SvgPicture.asset(
                          "assets/icons/btn_x.svg",
                          height: 16,
                        ),
                      )
                  ),
                ],
              );
            }).toList(),
          ),
        ],
      ),
    ));
  }

  _renderBody(BuildContext context) {
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
                    _photoApply(),
                    const SizedBox(height: 40),
                    FormInputWidget(
                      onChange: (value) => controller.chkField(),
                      onSubmit: (value) {},
                      controller: controller.titleCtrl,
                      hint: "제목",
                    ),
                    const SizedBox(height: 12),
                    CustomExpansionFeild(
                      controller: controller.categoryCtrl,
                      placeholder: "등록된 제품을 선택해주세요.",
                      onTap: (){},
                      readMode: true,
                    ),
                    const SizedBox(height: 12),
                    FormInputWidget(
                      onChange: (value) {},
                      onSubmit: (value) => controller.chkField(),
                      controller: controller.priceCtrl,
                      hint: "가격",
                    ),
                    const SizedBox(height: 12),
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
                          onChanged: (value) => controller.chkField(),
                          maxLines: null,
                          controller: controller.bodyCtrl,
                          style: regular14TextStyle.copyWith(color: gray_999Color),
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            disabledBorder: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            hintText: "내용을 입력하세요. (100자 미만)",
                            hintStyle: regular14TextStyle.copyWith(color: gray_999Color),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 100),
                  ],
                ),
              ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomFormSubmit(
              title: "확인",
              onTab: () => controller.chkForm(context),
              fill: controller.fill.value,
            ),
          ),
        ],
      ),
    );
  }
}