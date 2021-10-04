import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/shopControllers/shopAddProductController/shopAddProduct_controller.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/addShop_expansionList_feild.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_form_submit.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/form_input_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ShopAddProductPage extends GetView<ShopAddProductController> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: DefaultAppBarScaffold(
        title: "글쓰기",
        child: _renderBody(context),
      ),
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
              onTap: () => _loadAssetsMode(),
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
                      child: Image.file(File(e.path), fit: BoxFit.fill),
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
                    GetBuilder<ShopAddProductController>(builder: (_) => AddShopExpansionListField(
                      onTap: () {},
                      hintText: controller.myProductIdx == null ? "등록된 제품을 선택해주세요" : controller.myProductList[controller.currentIdx!].title,
                      items: controller.myProductList,
                      onChange: (value) => controller.currentListIdx(value),
                      idxChange: (value) => controller.changeProductIdx(value),
                      controller: controller.pagingScroll,
                    )),
                    GetBuilder<ShopAddProductController>(builder: (_) =>
                        Container(
                          width: double.infinity,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              if(controller.myProductIdx != null)
                                const SizedBox(height: 8),
                              if(controller.myProductIdx != null)
                                GestureDetector(
                                  behavior: HitTestBehavior.translucent,
                                  child: Text(
                                    "제품 정보",
                                    style: medium12TextStyle.copyWith(
                                      color: primaryColor,
                                      fontWeight: FontWeight.w700,
                                      decoration: TextDecoration.underline,
                                    ),
                                  ),
                                  onTap: () {
                                    Get.toNamed('/main/my/change_product/history/product/info',
                                        arguments: {'id': controller.myProductIdx});
                                  },
                                ),
                            ],
                          ),
                        ),
                    ),
                    const SizedBox(height: 12),
                    FormInputWidget(
                      onChange: (value) {},
                      onSubmit: (value) => controller.chkField(),
                      controller: controller.priceCtrl,
                      textInputType: TextInputType.numberWithOptions(signed: false, decimal: false),
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
                            hintText: "내용을 입력하세요.",
                            hintStyle: regular14TextStyle.copyWith(color: gray_999Color),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(height: 100),
                    //autoHeight
                    // GetBuilder<ShopAddProductController>(
                    //     builder: (_) => SizedBox(height: controller.autoHeight(context))),
                  ],
                ),
              ),
          ),
          if(MediaQuery.of(context).viewInsets.bottom == 0)
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

  _loadAssetsMode(){
    return Get.bottomSheet(
      Container(
        width: double.infinity,
        height: 150,
        color: whiteColor,
        child: Column(
          children: <Widget>[
            ListTile(
              onTap: () async => await controller.loadAssets(ImageSource.camera),
              title: Text(
                "직접 촬영",
                style: medium14TextStyle,
              ),
            ),
            ListTile(
              onTap: () async => await controller.loadAssets(ImageSource.gallery),
              title: Text(
                "갤러리에서 사진 선택",
                style: medium14TextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
