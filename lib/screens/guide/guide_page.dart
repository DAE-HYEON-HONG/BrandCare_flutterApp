import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/guide/guide_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class GuidePage extends GetView<GuideController> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: whiteColor,
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            child: CarouselSlider(
              carouselController: controller.sliderCtrl,
              options: CarouselOptions(
                  height: double.infinity,
                  aspectRatio: 16 / 9,
                  initialPage: 0,
                  enableInfiniteScroll: false,
                  autoPlay: false,
                  reverse: false,
                  autoPlayInterval: Duration(seconds: 5),
                  autoPlayCurve: Curves.fastOutSlowIn,
                  scrollDirection: Axis.vertical,
                  viewportFraction: 1,
                  onPageChanged: (index, reason) {
                    controller.changeBannerImg(index);
                  }),
              items: (controller.bannerList).map((e) {
                return Builder(
                  builder: (context) {
                    return Container(
                      width: double.infinity,
                      height: double.infinity,
                      child: Image.asset(
                        e,
                        fit: BoxFit.fitWidth,
                      )
                    );
                  },
                );
              }).toList(),
            ),
          ),
          Obx(() => Positioned(
            right: 17,
            top: 30,
            child: controller.pageNum.value == 3 ? const SizedBox() : GestureDetector(
              behavior: HitTestBehavior.translucent,
              onTap: () => controller.sliderCtrl.animateToPage(
                3,
                duration: Duration(seconds: 1),
                curve: Curves.easeInOutCubic,
              ),
              child: Text(
                'SKIP',
                style: medium16TextStyle.copyWith(
                  color: controller.pageNum.value != 1 ? whiteColor : gray_999Color,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          )),
          Obx(() => Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: controller.pageNum.value != 3 ?
            const SizedBox():
            GestureDetector(
              onTap: () => controller.saveGuideToken(),
              behavior: HitTestBehavior.translucent,
              child: Container(
                width: double.infinity,
                height: 60,
                color: primaryColor,
                child: Center(
                  child: Text(
                    '시작하기',
                    style: medium16TextStyle.copyWith(color: whiteColor),
                  ),
                ),
              ),
            ),
          )),
        ],
      ),
    );
  }
}
