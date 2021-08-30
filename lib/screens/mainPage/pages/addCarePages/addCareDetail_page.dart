import 'package:brandcare_mobile_flutter_v2/apis/base_api_service.dart';
import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/addCareControllers/addCareDetail_controller.dart';
import 'package:brandcare_mobile_flutter_v2/utils/date_format_util.dart';
import 'package:brandcare_mobile_flutter_v2/utils/status_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AddCareDetailPage extends StatelessWidget {
  final AddCareDetailController controller = Get.put(AddCareDetailController());
  @override
  Widget build(BuildContext context) {
    return DefaultAppBarScaffold(
      title: "제품케어 결과 보기",
      child: _renderBody(),
    );
  }

  _renderBody() {
    return GetBuilder<AddCareDetailController>(builder: (_) => Container(
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
                  imgPath: "${_.model?.results[0].afterImage}",
                  title: "${_.model?.careInfo.title} 외 ${_.model?.results.length}건",
                  type: StatusUtil.statusChk(status: "${_.model?.careInfo.status}"),
                  clock: DateFormatUtil.convertOnlyTime(date: "${_.model?.careInfo.createdDate ?? "2021-08-31T00:39:24.562773"}"),
                  date: DateFormatUtil.convertOnlyDate(date: "${_.model?.careInfo.createdDate ?? "2021-08-31T00:39:24.562773"}"),
                ),
                const SizedBox(height: 24),
                ListView.builder(
                  physics: NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  itemCount: _.model?.results.length,
                  itemBuilder: (context, idx){
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('케어/수선 ${idx+1} - 케어/수선 전'),
                        const SizedBox(height: 10),
                        _detailImage('${_.model?.results[idx].beforeImage}'),
                        const SizedBox(height: 10),
                        Text('케어/수선 ${idx+1} - 케어/수선 후'),
                        _detailImage('${_.model?.results[idx].afterImage}'),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 16),
                const Divider(height: 1, color: gray_D5D7DBColor),
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
                      controller: TextEditingController(text: "${_.model?.comment}"),
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
                const SizedBox(height: 120),
              ],
            ),
          )
      ),
    ));
  }

  _productInfo({required String imgPath, required String title, required String type, required String clock, required String date}){
    return Container(
      width: double.infinity,
      height: 150,
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
              ExtendedImage.network(
                BaseApiService.imageApi+imgPath,
                fit: BoxFit.cover,
                cache: true,
                width: 72,
                height: 72,
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

  _detailImage(String imgPath){
    return Container(
      width: double.infinity,
      height: 328,
      child: GestureDetector(
        onTap: () => _dialogImage(imgPath),
        child: imgPath == "" ?
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
        ExtendedImage.network(
          BaseApiService.imageApi+imgPath,
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
      ),
    );
  }

  _dialogImage(String imgPath){
    return Get.dialog(
      Dialog(
        child: Container(
          width: double.infinity,
          height: double.infinity,
          child: Center(
            child: Container(
              width: double.infinity,
              height: 360,
              child: Stack(
                children: [
                  CarouselSlider(
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
                          controller.changeBannerImg(index);
                        }),
                    items: (controller.model!.results).map((e) {
                      return Builder(
                        builder: (context) {
                          return Container(
                            width: double.infinity,
                            height: 360,
                            child: ExtendedImage.network(
                              BaseApiService.imageApi+e.afterImage,
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
                    child: Obx(() => Container(
                      width: 40,
                      height: 18,
                      decoration: BoxDecoration(
                        color: Colors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(50),
                      ),
                      child: Center(
                        child: Text(
                          "${controller.pageNum.value+1}/${controller.model?.results.length}",
                          style: regular12TextStyle.copyWith(color: whiteColor),
                        ),
                      ),
                    )),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
