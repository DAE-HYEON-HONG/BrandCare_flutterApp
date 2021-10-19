import 'package:brandcare_mobile_flutter_v2/apis/base_api_service.dart';
import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/addGenuineDetail_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/addGenuineStatus_controller.dart';
import 'package:brandcare_mobile_flutter_v2/utils/date_format_util.dart';
import 'package:brandcare_mobile_flutter_v2/utils/status_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/button/customArrowBtn.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/button/custom_button_onoff_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:brandcare_mobile_flutter_v2/models/idPathImages_model.dart';

class AddGenuineDetailPage extends StatelessWidget {
  final AddGenuineDetailController controller = Get.put(AddGenuineDetailController());
  AddGenuineStatusController genuineStatusCtrl = Get.find<AddGenuineStatusController>();
  @override
  Widget build(BuildContext context) {
    return DefaultAppBarScaffold(
      title: "정품인증 결과 보기",
      child: _renderBody(),
    );
  }

  _renderBody() {
    return GetBuilder<AddGenuineDetailController>(builder: (_) => Container(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 32),
                _productInfo(
                  imgPath: "${controller.model?.product.frontImage ?? ""}",
                  title: "${controller.model?.product.title ?? "로딩중"}",
                  type: StatusUtil.statusChk(status: genuineStatusCtrl.genuineStatus!.status),
                  clock: DateFormatUtil.convertOnlyTime(date: "${controller.model?.product.createdDate ?? "2021-08-31T00:39:24.562773"}"),
                  date: DateFormatUtil.convertOnlyDate(date: "${controller.model?.product.createdDate ?? "2021-08-31T00:39:24.562773"}"),
                ),
                const SizedBox(height: 24),
                _productGridPicture(),
                const SizedBox(height: 24),
                _genuineGridPicture(),
                const SizedBox(height: 16),
                Text('전문가 코멘트', style: medium14TextStyle),
                const SizedBox(height: 9),
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
                      maxLines: null,
                      readOnly: true,
                      controller: TextEditingController(text: "${_.model?.comment ?? "없음"}"),
                      style: regular14TextStyle.copyWith(color: gray_999Color),
                      decoration: InputDecoration(
                        border: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        disabledBorder: InputBorder.none,
                        enabledBorder: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                if(controller.certificateList.length != 0)
                CustomArrowBtn(
                  title: '인증서 확인',
                  onTap: () {
                    _certDialogImage(imgList: controller.certificateList, type: "down");
                    controller.pageNum.value = 0;
                    controller.update();
                  },
                )
                else
                  Text("가품인 경우 인증서가 제공되지 않습니다.", style: medium16TextStyle.copyWith(color: gray_999Color)),
                const SizedBox(height: 16),
              ],
            ),
          )
      ),
    ));
  }

  _productInfo({required String imgPath, required String title, required String type, required String clock, required String date}){
    return Container(
      width: double.infinity,
      height: 160,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 2),
            color: Color.fromRGBO(0, 0, 0, 0.08),
            blurRadius: 8.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              imgPath == "" ?
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  border: Border.all(color: gray_999Color),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/icons/header_title_logo.svg",
                    height: 10,
                  ),
                ),
              ):
              Container(
                width: 72,
                height: 72,
                child: ExtendedImage.network(
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
              ),
              const SizedBox(width: 32),
              Text(
                '$title',
                style: medium14TextStyle,
              )
            ],
          ),
          const SizedBox(height: 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$type',
                    style: medium14TextStyle.copyWith(
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Text(
                        clock,
                        style: regular14TextStyle,
                      ),
                      const SizedBox(width: 8),
                      Container(width: 1, height: 12, color: gray_999Color),
                      const SizedBox(width: 8),
                      Text(
                        date,
                        style: regular14TextStyle,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  _productGridPicture() => GetBuilder<AddGenuineDetailController>(builder:(_)=>Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('제품사진'),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _pictureItem(controller.model?.product.frontImage ?? ''),
            const SizedBox(width: 7),
            _pictureItem(controller.model?.product.backImage ?? ''),
          ],
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _pictureItem(controller.model?.product.leftImage ?? ''),
            const SizedBox(width: 7),
            _pictureItem(controller.model?.product.rightImage ?? ''),
          ],
        ),
      ],
    ),
  ));

  _genuineGridPicture() => GetBuilder<AddGenuineDetailController>(builder:(_)=>Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text('제품사진'),
        GridView.builder(
          physics: NeverScrollableScrollPhysics(),
          itemCount: controller.model?.genuineImages.length ?? 0,
          shrinkWrap: true,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 32,
            crossAxisSpacing: 8,
          ),
          itemBuilder: (context, idx){
            return GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                _dialogImage(imgPath: controller.model?.genuineImages[idx].path ?? "", type: "normal");
              },
              child: _pictureItem(controller.model?.genuineImages[idx].path ?? ""),
            );
          },
        ),
      ],
    ),
  ));

  _pictureItem(String imgPath) => GetBuilder<AddGenuineDetailController>(builder:(_)=>
      GestureDetector(
        onTap: () => _dialogImage(imgPath: imgPath, type: "normal"),
        child: Container(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                imgPath != ""
                    ? ExtendedImage.network(
                        BaseApiService.imageApi + imgPath,
                        fit: BoxFit.cover,
                        cache: true,
                        height: 160,
                        width: 160,
                      )
                    : Container(
                        width: 160,
                        height: 160,
                        child: Center(
                          child: SvgPicture.asset(
                            'assets/icons/header_title_logo.svg',
                            width: 10,
                            height: 10,
                          ),
                        ),
                      ),
              ],
            ),
          ),
      ),
      );

  _dialogImage({required String imgPath, required String type}){
    return Get.dialog(
      GetBuilder<AddGenuineDetailController>(builder: (_) =>
          Dialog(
            child: GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () {
                Get.back();
              },
              child: Container(
                color: Colors.black,
                width: double.infinity,
                height: double.infinity,
                child: Container(
                  width: double.infinity,
                  height: double.infinity,
                  child: Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        height: double.infinity,
                        child: imgPath == "" ?
                        Center(
                          child: SvgPicture.asset(
                            "assets/icons/header_title_logo.svg",
                            height: 10,
                          ),
                        ):
                        ExtendedImage.network(
                          BaseApiService.imageApi+imgPath,
                          fit: BoxFit.fitWidth,
                          cache: true,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
      ),
    );
  }

  _certDialogImage({required List<IdPathImagesModel> imgList, required String type}){
    return Get.dialog(
      GetBuilder<AddGenuineDetailController>(builder: (_) =>
          Dialog(
            child: Container(
              color: Colors.black,
              width: double.infinity,
              height: double.infinity,
              child: Container(
                width: double.infinity,
                child: Stack(
                  children: [
                    Center(
                      child: CarouselSlider(
                        options: CarouselOptions(
                            height: 360,
                            aspectRatio: 16 / 9,
                            initialPage: 0,
                            enableInfiniteScroll: false,
                            autoPlay: true,
                            reverse: false,
                            autoPlayInterval: Duration(seconds: 5),
                            autoPlayCurve: Curves.fastOutSlowIn,
                            scrollDirection: Axis.horizontal,
                            viewportFraction: 1,
                            onPageChanged: (index, reason) {
                              controller.pageNum.value = index;
                              controller.update();
                            }),
                        items: (imgList).map((e) {
                          return Builder(
                            builder: (context) {
                              return Container(
                                width: double.infinity,
                                height: 360,
                                child: e.path == "" ?
                                Container(
                                  width: 300,
                                  height: 300,
                                  decoration: BoxDecoration(
                                    border: Border.all(color: gray_999Color),
                                  ),
                                  child: Center(
                                    child: SvgPicture.asset(
                                      "assets/icons/header_title_logo.svg",
                                      height: 10,
                                    ),
                                  ),
                                ):
                                ExtendedImage.network(
                                  BaseApiService.imageApi+e.path!,
                                  fit: BoxFit.fitWidth,
                                  cache: true,
                                ),
                              );
                            },
                          );
                        }).toList(),
                      ),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 15,
                      child: Container(
                        width: double.infinity,
                        child: Center(
                          child: Obx(() => Container(
                            width: 40,
                            height: 18,
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(50),
                            ),
                            child: Center(
                              child: Text(
                                "${controller.pageNum.value+1}/${imgList.length}",
                                style: regular12TextStyle.copyWith(color: whiteColor),
                              ),
                            ),
                          )),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 20,
                      top: 20,
                      child: Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          color: redColor.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Center(
                          child: Icon(
                            Icons.clear_sharp,
                            color: whiteColor,
                            size: 30,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
      ),
    );
  }
}
