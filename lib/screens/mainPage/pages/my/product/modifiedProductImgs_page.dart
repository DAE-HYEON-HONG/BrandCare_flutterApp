import 'package:brandcare_mobile_flutter_v2/apis/base_api_service.dart';
import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/AddProductControllers/addProductImgs_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/modifiedProductImgs_controller.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_form_submit.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class ModifiedProductImgsPage extends StatelessWidget {
  ModifiedProductImgsController controller = Get.put(ModifiedProductImgsController());
  @override
  Widget build(BuildContext context) {
    return DefaultAppBarScaffold(
      title: "제품 정보 수정",
      child: _renderBody(),
    );
  }

  _renderBody() {
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
                        "제품 사진을 수정하세요.",
                        style: medium14TextStyle,
                      ),
                      const SizedBox(height: 8),
                      Text(
                        "사진을 등록하지 않으시면 기본 이미지를 사용합니다.",
                        style: regular14TextStyle.copyWith(
                          color: gray_8E8F95Color,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  GetBuilder<ModifiedProductImgsController>(builder: (_) => GridView.count(
                    physics: NeverScrollableScrollPhysics(),
                    childAspectRatio: 8 / 9,
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    crossAxisCount: 2,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 32.0,
                    children: [
                      _photoApply(
                        controller.frontImg,
                        "front",
                        "정면 사진",
                        controller.frontImgPath,
                      ),
                      _photoApply(
                        controller.backImg,
                        "back",
                        "뒷면 사진",
                        controller.backImgPath,
                      ),
                      _photoApply(
                        controller.leftImg,
                        "left",
                        "좌측 사진",
                        controller.leftImgPath,
                      ),
                      _photoApply(
                        controller.rightImg,
                        "right",
                        "우측 사진",
                        controller.rightImgPath,
                      ),
                    ],
                  )),
                  const SizedBox(height: 32),
                  GetBuilder<ModifiedProductImgsController>(
                    builder: (_) => GridView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      itemCount: controller.imgList!.length + 1,
                      shrinkWrap: true,
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 32,
                        crossAxisSpacing: 8,
                      ),
                      itemBuilder: (context, idx){
                        return _photoListApply(idx);
                      },
                    ),
                  ),
                  const SizedBox(height: 90),
                ],
              ),
            ),
          ),
          Obx(() => Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomFormSubmit(
              title: "확인",
              onTab: () => controller.nextLevel(),
              fill: controller.fill.value,
            ),
          )),
        ],
      ),
    );
  }

  _photoApply(Rx<File> img, String chkImg, String title, String imgPath) {
    return SizedBox(
      height: 180,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: regular14TextStyle,
          ),
          const SizedBox(height: 8),
          Expanded(
            child: imgPath == "" ?
            img.value.path == "" ?
            GestureDetector(
              onTap: () => _normalMode(chkImg),
              child: Container(
                width: double.infinity,
                height: 160,
                child: DottedBorder(
                  color: gray_D5D7DBColor,
                  strokeWidth: 1,
                  child: Container(
                    width: double.infinity,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        SvgPicture.asset(
                          "assets/icons/add_image.svg",
                          height: 31,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "이미지 추가",
                          style: medium14TextStyle.copyWith(color: primaryColor),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ):
            Container(
              width: double.infinity,
              height: 180,
              child: Stack(
                children: [
                  Container(
                    width: double.infinity,
                    height: 190,
                    child: Image.file(File(img.value.path), fit: BoxFit.cover, height: 160),
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () => controller.removeImg(chkImg),
                      child: SvgPicture.asset(
                        "assets/icons/btn_x.svg",
                        height: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ) :
            Container(
              width: double.infinity,
              height: 180,
              child: Stack(
                children: [
                  ExtendedImage.network(
                    BaseApiService.imageApi+imgPath,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    cache: true,
                    // ignore: missing_return
                    loadStateChanged: (ExtendedImageState state) {
                      switch(state.extendedImageLoadState) {
                        case LoadState.loading :
                          break;
                        case LoadState.completed :
                          break;
                        case LoadState.failed :
                          break;
                      }
                    },
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: GestureDetector(
                      onTap: () => controller.removeUploadedImg(chkImg),
                      child: SvgPicture.asset(
                        "assets/icons/btn_x.svg",
                        height: 16,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _photoListApply(int idx){
    return Container(
      height: 180,
      child: controller.imgList!.length < idx + 1 ?
      GestureDetector(
        onTap: () => _listMode(),
        child: Container(
          width: double.infinity,
          height: 160,
          child: DottedBorder(
            color: gray_D5D7DBColor,
            strokeWidth: 1,
            child: Container(
              width: double.infinity,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  SvgPicture.asset(
                    "assets/icons/add_image.svg",
                    height: 31,
                  ),
                  const SizedBox(height: 12),
                  Text(
                    "이미지 추가",
                    style: medium14TextStyle.copyWith(color: primaryColor),
                  ),
                ],
              ),
            ),
          ),
        ),
      ):
      Container(
        width: double.infinity,
        height: 180,
        child: Stack(
          children: [
            controller.imgList![idx].path == "" ?
            Container(
              width: double.infinity,
              height: double.infinity,
              child: Image.file(File(controller.imgList![idx].file!.path), fit: BoxFit.cover),
            ):
            Container(
              child: ExtendedImage.network(
                BaseApiService.imageApi+controller.imgList![idx].path!,
                fit: BoxFit.cover,
                width: double.infinity,
                cache: true,
                // ignore: missing_return
                loadStateChanged: (ExtendedImageState state) {
                  switch(state.extendedImageLoadState) {
                    case LoadState.loading :
                      break;
                    case LoadState.completed :
                      break;
                    case LoadState.failed :
                      break;
                  }
                },
              ),
            ),
            Positioned(
              top: 8,
              right: 8,
              child: GestureDetector(
                onTap: () => controller.removeListAssets(controller.imgList![idx]),
                child: SvgPicture.asset(
                  "assets/icons/btn_x.svg",
                  height: 16,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  _normalMode(String chkImg){
    return Get.bottomSheet(
      Container(
        width: double.infinity,
        height: 150,
        color: whiteColor,
        child: Column(
          children: <Widget>[
            ListTile(
              onTap: () async => await controller.loadAssets(chkImg, ImageSource.camera),
              title: Text(
                "직접 촬영",
                style: medium14TextStyle,
              ),
            ),
            ListTile(
              onTap: () async => await controller.loadAssets(chkImg, ImageSource.gallery),
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

  _listMode(){
    return Get.bottomSheet(
        Container(
          width: double.infinity,
          height: 150,
          color: whiteColor,
          child: Column(
            children: <Widget>[
              ListTile(
                onTap: () async => await controller.loadMoreAssets(ImageSource.camera),
                title: Text(
                  "직접 촬영",
                  style: medium14TextStyle,
                ),
              ),
              ListTile(
                onTap: () async => await controller.loadMoreAssets(ImageSource.gallery),
                title: Text(
                  "갤러리에서 사진 선택",
                  style: medium14TextStyle,
                ),
              ),
            ],
          ),
        )
    );
  }
}