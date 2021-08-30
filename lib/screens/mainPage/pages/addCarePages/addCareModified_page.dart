import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/addCareControllers/addCarePic_controller.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/care_expansionList_feild.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_form_submit.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddCareModifiedPage extends GetView<AddCarePicController> {
  final String category;
  final String secondCategory;
  final int idx;
  final File img;
  AddCareModifiedPage({required this.category, required this.secondCategory, required this.idx, required this.img});

  @override
  Widget build(BuildContext context) {
    controller.modifiedInit(img, category, secondCategory);
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
                  Text(
                    "케어/수선 서비스 참고 사진첨부",
                    style: medium14TextStyle,
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "케어/수선을 원하는 위치의 이미지를 추가해주세요.",
                    style: medium14TextStyle.copyWith(color: gray_999Color),
                  ),
                  const SizedBox(height: 18),
                  _photoApply(),
                  const SizedBox(height: 16),
                  const Divider(height: 1, color: gray_f5f6f7Color),
                  const SizedBox(height: 16),
                  Text(
                    "케어항목",
                    style: medium14TextStyle,
                  ),
                  const SizedBox(height: 9),
                  CareExpansionListField(
                      onTap: () => controller.chkFill(),
                      hintText: "$category",
                      items: controller.careList,
                      onChange: (value) => controller.firstCategory(value),
                      onPriceChange: (value) {},
                  ),
                  const SizedBox(height: 8),
                  Obx(() => CareExpansionListField(
                    onTap: () => controller.chkFill(),
                    hintText: "$secondCategory",
                    items: controller.checkType(controller.firstCareCategory.value),
                    onChange: (value) => controller.secondCategory(value),
                    onPriceChange: (value) => controller.choicePrice(value),
                  )),
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
              title: "수정",
              onTab: () => controller.modifiedList(idx),
              fill: controller.fill.value,
            ),
          )),
        ],
      ),
    );
  }

  _photoApply(){
    return Obx(() => Container(
      width: double.infinity,
      height: 328,
      child: GestureDetector(
        onTap: () => _loadAssetsMode(),
        child: controller.careImg.value.path == "" ?
        DottedBorder(
          color: gray_D5D7DBColor,
          strokeWidth: 1,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SvgPicture.asset(
                  "assets/icons/add_image.svg",
                  height: 20,
                ),
                const SizedBox(height: 13),
                Text(
                  "이미지를 수정 시 눌러주세요.",
                  style: medium14TextStyle.copyWith(color: gray_333Color),
                ),
              ],
            ),
          ),
        ):
        Container(
          width: double.infinity,
          height: 328,
          child: Stack(
            children: [
              Container(
                width: double.infinity,
                height: double.infinity,
                child: Image.file(
                  controller.careImg.value,
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: 8,
                right: 8,
                child: GestureDetector(
                  onTap: () => controller.removeImg(),
                  child: SvgPicture.asset(
                    "assets/icons/btn_x.svg",
                    height: 20,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ));
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
