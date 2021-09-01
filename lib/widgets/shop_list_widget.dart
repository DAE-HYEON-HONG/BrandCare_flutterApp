import 'package:brandcare_mobile_flutter_v2/apis/base_api_service.dart';
import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ShopListWidget extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String brandName;
  final String category;
  final bool genuine;
  final String money;
  final String date;
  final int productIdx;

  const ShopListWidget({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.brandName,
    required this.category,
    required this.genuine,
    required this.money,
    required this.date,
    required this.productIdx,
  }) :super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => Get.toNamed('/mainShop/Detail', arguments: this.productIdx),
      child: Container(
        width: double.infinity,
        height: 146,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 104,
              height: 104,
              child: imageUrl != "" ? ExtendedImage.network(
                BaseApiService.imageApi+this.imageUrl,
                fit: BoxFit.cover,
                cache: true,
                // ignore: missing_return
                loadStateChanged: (ExtendedImageState state) {
                  switch (state.extendedImageLoadState) {
                    case LoadState.loading :
                      break;
                    case LoadState.completed :
                      break;
                    case LoadState.failed :
                      break;
                  }
                },
              ) : Container(
                width: double.infinity,
                height: double.infinity,
                decoration: BoxDecoration(
                  border: Border.all(color: gray_999Color),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/icons/header_title_logo.svg",
                    height: 10,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 8),
            Flexible(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  //제목
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(this.title, style: medium16TextStyle),
                    ],
                  ),
                  const SizedBox(height: 5),
                  //정품 확인 및 카테고리, 브랜드네임
                  Container(
                    height: 42,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Flexible(
                          flex: 1,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                this.brandName,
                                style: regular12TextStyle.copyWith(
                                    color: gray_333Color),
                              ),
                              const SizedBox(width: 5),
                              Container(width: 1,
                                  height: 12,
                                  color: Color(0xff999999)),
                              const SizedBox(width: 5),
                              Text(
                                this.category,
                                style: regular12TextStyle.copyWith(
                                    color: gray_333Color),
                              ),
                            ],
                          ),
                        ),
                        this.genuine == true ?
                        Container(
                          width: 72,
                          height: 24,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: Color(0xff212B62), width: 1),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: Center(
                            child: Text(
                              "정품",
                              style: medium12TextStyle.copyWith(
                                  color: primaryColor),
                            ),
                          ),
                        ) : Container(
                          width: 72,
                          height: 24,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            color: Color(0xffAFAFAF),
                          ),
                          child: Center(
                            child: Text(
                              "미인증",
                              style: medium12TextStyle.copyWith(
                                  color: whiteColor),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text("거래가", style: regular12TextStyle.copyWith(
                          color: gray_333Color)),
                      const SizedBox(width: 5),
                      Text(this.money, style: medium14TextStyle.copyWith(
                          color: gray_333Color)),
                      const SizedBox(width: 5),
                      Text("원", style: regular12TextStyle.copyWith(
                          color: gray_333Color))
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(this.date, style: regular12TextStyle.copyWith(
                          color: gray_999Color)),
                    ],
                  )
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}