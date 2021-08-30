import 'dart:math';
import 'dart:io';
import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/shopControllers/shopDetail/shopDetail_controller.dart';
import 'package:brandcare_mobile_flutter_v2/utils/date_format_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/add_genuineLogo.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_like_btn.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ShopDetailPage extends GetView<ShopDetailController> {
  @override
  Widget build(BuildContext context) {
    return DefaultAppBarScaffold(
      title: "SHOP",
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
            child: Column(
              children: [
                //배너
                GetBuilder<ShopDetailController>(builder: (_) => Stack(
                  children: [
                    CarouselSlider(
                      carouselController: controller.slideCtrlBtn,
                      options: CarouselOptions(
                        height: 240,
                        aspectRatio: 16/9,
                        initialPage: 0,
                        enableInfiniteScroll: true,
                        autoPlay: true,
                        reverse: false,
                        autoPlayInterval: Duration(seconds: 5),
                        autoPlayCurve: Curves.fastOutSlowIn,
                        scrollDirection: Axis.horizontal,
                        viewportFraction: 1,
                        onPageChanged: (index, reason) => controller.pageChanged(index),
                      ),
                      items: (controller.model.images).map((e) {
                        return Builder(
                          builder: (context){
                            return Container(
                              width: double.infinity,
                              height: 360,
                              child: ExtendedImage.network(
                                e.path,
                                fit: BoxFit.cover,
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
                            );
                          },
                        );
                      }).toList(),
                    ),
                    Positioned(
                      left: 0,
                      right: 0,
                      bottom: 0,
                      child: Container(
                        height: 50,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 40,
                              height: 18,
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.6),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: Obx(() => Center(
                                child: Text(
                                  "${controller.pageNum.value+1}/${controller.model.images.length}",
                                  style: regular12TextStyle.copyWith(color: whiteColor),
                                ),
                              )),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      top: 0,
                      left: 15,
                      child: InkWell(
                        onTap: () => controller.slideCtrlBtn.previousPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        ),
                        child: Container(
                          height: double.infinity,
                          width: 25,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Transform.rotate(
                                angle: 180* pi / 180,
                                child: SvgPicture.asset('assets/icons/slider_next.svg', height: 25),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      top: 0,
                      right: 15,
                      child: InkWell(
                        onTap: () => controller.slideCtrlBtn.nextPage(
                          duration: Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        ),
                        child: Container(
                          height: double.infinity,
                          width: 25,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              SvgPicture.asset('assets/icons/slider_next.svg', height: 25),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 15,
                      top: 15,
                      child: GenuineLogo(genuine: controller.model.gi == "UNCERTIFIED" ? false : true),
                    ),
                  ],
                )),
                Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      ListTile(
                        contentPadding: const EdgeInsets.only(left: 0, right: 0, top: 5, bottom: 5),
                        leading: Container(
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                            color: Color(0xffF4F0FF),
                            shape: BoxShape.circle,
                          ),
                          child: Center(
                            child: SvgPicture.asset("assets/icons/mypage_on.svg", height: 13),
                          ),
                        ),
                        title: Text(
                          controller.model.nickName,
                        ),
                      ),
                      const Divider(color: gray_f5f6f7Color, height: 1),
                      const SizedBox(height: 24),
                      Text(
                        controller.model.title,
                        style: medium16TextStyle,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: <Widget>[
                          Text(controller.model.brand, style: regular12TextStyle.copyWith(color: gray_999Color)),
                          const SizedBox(width: 8),
                          VerticalDivider(width: 1, color: Color(0xff999999)),
                          const SizedBox(width: 8),
                          Text(controller.model.category, style: regular12TextStyle.copyWith(color: gray_999Color)),
                          const SizedBox(width: 8),
                          VerticalDivider(width: 1, color: Color(0xff999999)),
                          const SizedBox(width: 8),
                          Text(
                            DateFormatUtil.convertDateTimeFormat(date: controller.model.createdDate),
                            style: regular12TextStyle.copyWith(color: gray_999Color),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      ConstrainedBox(
                        constraints: BoxConstraints(
                          minWidth: double.infinity,
                          minHeight: 189,
                        ),
                        child: Text(
                          controller.model.nickName,
                          maxLines: 60,
                          style: regular14TextStyle.copyWith(color: gray_333Color),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Container(
              width: double.infinity,
              height: Platform.isIOS ? 80 : 64,
              padding: const EdgeInsets.only(left: 16, right: 16),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 4, offset: Offset(0.0, -5.0)),
                ],
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  GetBuilder<ShopDetailController>(builder: (_) => CustomLikeBtn(
                    isLiked: controller.model.hasLike,
                    onTap: () => controller.changeIsLiked(),
                  )),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
