import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/mainHome_controller.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_expansion_tile_widget.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class MainHome extends StatelessWidget {
  final MainHomeController controller = Get.put(MainHomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      body: SafeArea(
        child: _body(),
      ),
    );
  }

  _body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          Positioned(
            child: Container(
              width: double.infinity,
              height: double.infinity,
              color: backgroundColor,
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Column(
                  children: <Widget>[
                    //배너
                    Container(
                      width: double.infinity,
                      height: 360,
                      child: Stack(
                        children: [
                          CarouselSlider(
                            options: CarouselOptions(
                                height: 360,
                                aspectRatio: 16 / 9,
                                initialPage: 0,
                                enableInfiniteScroll: true,
                                autoPlay: true,
                                reverse: false,
                                autoPlayInterval: Duration(seconds: 5),
                                autoPlayCurve: Curves.fastOutSlowIn,
                                scrollDirection: Axis.horizontal,
                                viewportFraction: 1,
                                onPageChanged: (index, reason) {
                                  controller.changeBannerImg(index);
                                }),
                            items: (controller.bannerImageList).map((e) {
                              return Builder(
                                builder: (context) {
                                  return Container(
                                    width: double.infinity,
                                    height: 360,
                                    child: ExtendedImage.network(
                                      e,
                                      fit: BoxFit.cover,
                                      cache: true,
                                      // ignore: missing_return
                                      loadStateChanged: (ExtendedImageState state) {
                                        switch (state.extendedImageLoadState) {
                                          case LoadState.loading:
                                            break;
                                          case LoadState.completed:
                                            break;
                                          case LoadState.failed:
                                            return GestureDetector(
                                              child: Center(
                                                child: Container(
                                                  width: 100,
                                                  height: 100,
                                                  color: primaryColor,
                                                ),
                                              ),
                                              onTap: () {
                                                state.reLoadImage();
                                              },
                                            );
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
                                  //AnimatedPositioned를 사용 시 무조건 Stack안에 있어야 합니다.
                                  Stack(
                                    children: [
                                      Container(
                                        width: 30.0 * controller.bannerImageList.length,
                                        height: 3,
                                        decoration: BoxDecoration(
                                          color: Colors.white.withOpacity(0.6),
                                        ),
                                      ),
                                      Obx(() => AnimatedPositioned(
                                        left: 30.0 * controller.pageNum.value,
                                        child: Container(
                                          width: 30,
                                          height: 3,
                                          color: Colors.white,
                                        ),
                                        duration: Duration(milliseconds: 200),
                                        curve: Curves.fastOutSlowIn,
                                      )),
                                    ],
                                  ),
                                  SizedBox(
                                    width: 10.0.w,
                                  ),
                                  Obx(() => Container(
                                    width: 40,
                                    height: 18,
                                    decoration: BoxDecoration(
                                      color: Colors.black.withOpacity(0.6),
                                      borderRadius: BorderRadius.circular(50),
                                    ),
                                    child: Center(
                                      child: Text(
                                        "${controller.pageNum.value+1}/${controller.bannerImageList.length}",
                                        style: regular12TextStyle.copyWith(color: whiteColor),
                                      ),
                                    ),
                                  )),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    //하단 이용 안내 및 브랜드 케어 설명
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.only(top: 32, bottom: 70, left: 16, right: 16),
                      child: Column(
                        children: <Widget>[
                          //이용안내
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("이용 안내", style: regular14TextStyle.copyWith(color: gray_333Color, fontSize: 16)),
                              SizedBox(height: 7.0),
                              Container(
                                width: double.infinity,
                                height: 99,
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
                                child: Row(
                                  mainAxisSize: MainAxisSize.max,
                                  children: [
                                    _useInfomation(0, "price_list_on.svg", "가격표"),
                                    _useInfomation(1, "howtouse_on.svg", "이용방법"),
                                    _useInfomation(2, "delivery_on.svg", "택배 유의사항"),
                                    _useInfomation(3, "event_on.svg", "이벤트"),
                                  ],
                                ),
                              )
                            ],
                          ),
                          SizedBox(
                            height: 80,
                          ),
                          CustomExpantionTile2(
                            title: Text(
                              "브랜드케어",
                              style: medium12TextStyle.copyWith(
                                color: gray_999Color,
                              ),
                            ),
                            child: Container(
                              width: double.infinity,
                              height: 80.h,
                              child: Column(
                                children: [

                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            child: Container(
              color: whiteColor,
              width: double.infinity,
              height: 48.h,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset('assets/icons/header_title_logo.svg', width:120.w, height: 15.w, color: primaryColor),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  _useInfomation(int idx, String imgAdds, String title) {
    return Expanded(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SvgPicture.asset(
            'assets/icons/$imgAdds',
            height: 40.h,
            color: primaryColor,
          ),
          Text(
            title,
            style: regular12TextStyle.copyWith(color: gray_333Color),
          ),
        ],
      ),
    );
  }
}