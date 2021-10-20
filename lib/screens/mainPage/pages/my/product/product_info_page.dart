import 'package:brandcare_mobile_flutter_v2/apis/base_api_service.dart';
import 'package:brandcare_mobile_flutter_v2/consts/box_shadow.dart';
import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/productInfo_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/product_info_controller.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/changeProduct/changeProduct_in_productInfo.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/changeProduct/change_product_apply_info_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/changeProduct/custom_route_button.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/genuine/addGenuineStatus_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/genuine/addGenuine_page.dart';
import 'package:brandcare_mobile_flutter_v2/utils/number_format_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/button/customArrowBtn.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/button/customArrowUpDown.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/form_input_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/genuine_box_widget.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ProductGiDetailPage extends GetView<ProductInfoDetailController> {
  Widget build(BuildContext context) {
    return GetBuilder<ProductInfoDetailController>(builder: (_) => DefaultAppBarScaffold(
        title: '제품 정보',
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 32),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _item("${controller.model?.thumbnail ?? ""}"),
                const SizedBox(height: 24,),
                if(controller.model?.genuine == "GENUINE" || controller.model?.genuine == "REFUSAL")
                CustomArrowBtn(title: '정품인증 현황보기', onTap: () {
                  Get.to(() => AddGenuineStatusPage(), arguments: {
                    'back' : true,
                    'idx' : controller.model?.activationId ?? 0,
                  });
                }),
                if(controller.model?.genuine != "GENUINE" &&
                    controller.model?.genuine != "REFUSAL" &&
                    controller.model?.genuine != "GOING" &&
                    controller.model?.genuine == "REJECT" ||
                  controller.model?.genuine == "UNCERTIFIED"
                )
                CustomArrowBtn(title: '정품인증 신청하기', onTap: () {
                  Get.to(() => AddGenuinePage(), arguments: controller.productIdx);
                }),
                if(controller.model?.genuine == "GOING")
                CustomArrowBtn(title: '정품 확인중', onTap: () {}),
                const SizedBox(height: 16,),
                CustomArrowBtn(
                  title: '제품 사용자 변경',
                  onTap: () {
                    Get.to(() => ChangeProductInProductInfo(), arguments: {
                      'back' : true,
                      'idx' : controller.productIdx,
                    });
                  },
                ),
                const SizedBox(height: 16,),
                Obx(() => CustomArrowUpDownBtn(
                  onTap: () {
                    controller.onDown();
                  },
                  title: '제품 상세 내용',
                  onDown: controller.downDetail.value,
                )),
                if (controller.downDetail.value == true)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16,),
                    const Divider(height: 1, color: gray_D5D7DBColor),
                    const SizedBox(height: 16,),
                    FormInputWidget(
                      onChange: (value){},
                      onSubmit: (value){},
                      controller: TextEditingController(text: controller.model?.title),
                      readOnly: true,
                      title: '제품명',
                      isShowTitle: true,
                    ),
                    const SizedBox(height: 24,),
                    FormInputWidget(
                      onChange: (value){},
                      onSubmit: (value){},
                      controller: TextEditingController(text: controller.model?.serialCode),
                      readOnly: true,
                      title: '일련번호',
                      isShowTitle: true,
                    ),
                    const SizedBox(height: 24,),
                    FormInputWidget(
                      onChange: (value){},
                      onSubmit: (value){},
                      controller: TextEditingController(text: controller.model?.buyDate),
                      readOnly: true,
                      title: '구입시기',
                      isShowTitle: true,
                    ),
                    const SizedBox(height: 24,),
                    FormInputWidget(
                      onChange: (value){},
                      onSubmit: (value){},
                      controller: TextEditingController(text:
                      '${NumberFormatUtil.convertNumberFormat(number: int.parse("${controller.model?.price ?? 0}"))}원'),
                      readOnly: true,
                      title: '구입금액',
                      isShowTitle: true,
                    ),
                    const SizedBox(height: 24),
                    FormInputWidget(
                      onChange: (value){},
                      onSubmit: (value){},
                      controller: TextEditingController(text: controller.model?.buyRoute),
                      readOnly: true,
                      title: '구입경로',
                      isShowTitle: true,
                    ),
                    const SizedBox(height: 24),
                    _gridPicture(),
                    const SizedBox(height: 10),
                    if(controller.model?.image != null)
                    GetBuilder<ProductInfoDetailController>(
                      builder: (_) => GridView.builder(
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: controller.model?.image?.length ?? 0,
                        shrinkWrap: true,
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                        ),
                        itemBuilder: (context, idx){
                          return _networkImage(controller.model?.image?[idx].path ?? "");
                        },
                      ),
                    ),
                    const SizedBox(height: 32,),
                    Text('추가정보', style: medium14TextStyle,),
                    const SizedBox(height: 17,),
                    _productAddInfo(
                        '제품 컨디션',
                        controller.model != null
                            ? controller.model!.conditionList
                            .map((e) => e.title)
                            .toList()
                            : []),
                    const SizedBox(height: 30,),
                    _productAddInfo(
                        '제품 구성품',
                        controller.model != null
                            ? controller.model!.additionList
                            .map((e) => e.title)
                            .toList()
                            : []),
                    const SizedBox(height: 27,),
                    _etc(),
                    const SizedBox(height: 32,),
                    CustomArrowBtn(title: '제품 정보 수정', onTap: () {
                      if(controller.model?.genuine == "GENUINE" || controller.model?.genuine == "GOING"){
                        Get.dialog(
                          CustomDialogWidget(content: '정품인증을 진행 중이거나\n완료된 경우 수정이 불가능 합니다.', onClick: (){
                            Get.back();
                          }),
                        );
                        return;
                      }
                      Get.toNamed(
                        "/modified/product/info",
                        arguments: {
                          'title' : controller.model?.title,
                          "category" : controller.model?.category,
                          "brand" : controller.model?.brand,
                          "serial" :controller.model?.serialCode,
                          "buyDate" : controller.model?.buyDate,
                          "buyPrice" : controller.model?.price,
                          "buyRoute" : controller.model?.buyRoute,
                          "imgList" : controller.model?.image,
                          "categoryId" :controller.model?.categoryId,
                          "brandId" : controller.model?.brandId,
                        }
                      );
                    }),
                    const SizedBox(height: 16,),
                    CustomArrowBtn(title: '제품 삭제', onTap: () async => await controller.removeProduct()),
                    const SizedBox(height: 32,),
                  ],
                ),
              ],
            ),
          ),
        )
    ));
  }

  Widget _item(String imgPath) => GetBuilder<ProductInfoDetailController>(builder: (_) => Container(
    height: 104,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          defaultBoxShadow,
        ]
    ),
    child: Row(
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
            cache: true,
          ),
        ),
        const SizedBox(width: 16,),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('${controller.model?.brand ?? ""} | ${controller.model?.category ?? ""}', style: regular12TextStyle.copyWith(color: gray_333Color),),
                const SizedBox(width: 19,),
                if(controller.model?.genuine != "REFUSAL")
                  GenuineBoxWidget(isGenuine: controller.model?.genuine == "GENUINE" ? true : false),
              ],
            ),
            const SizedBox(height: 5,),
            Text("${controller.model?.title ?? "로딩중"}", style: medium14TextStyle,),
          ],
        )
      ],
    ),
  ));

  Widget _gridPicture() => GetBuilder<ProductInfoDetailController>(builder:(_)=>Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _pictureItem('정면 사진', controller.model?.frontImage ?? ''),
            _pictureItem('뒷면 사진', controller.model?.backImage ?? ''),
          ],
        ),
        const SizedBox(height: 24,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _pictureItem('좌측면 사진', controller.model?.leftImage ?? ''),
            _pictureItem('우측면 사진', controller.model?.rightImage ?? ''),
          ],
        ),
      ],
    ),
  ));

  Widget _networkImage(String imgPath) => Container(
    width: 160,
    height: 160,
    child: imgPath != "" ? ExtendedImage.network(
      BaseApiService.imageApi+imgPath,
      fit: BoxFit.cover,
      cache: true,
      height: 160,
      width: 160,
    ) : Container(
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
  );

  Widget _pictureItem(String title, String imgPath) => GetBuilder<ProductInfoDetailController>(builder:(_)=>Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: medium14TextStyle,),
        const SizedBox(height: 10,),
        imgPath != "" ?
        ExtendedImage.network(
          BaseApiService.imageApi+imgPath,
          fit: BoxFit.cover,
          cache: true,
          height: 160,
          width: 160,
        ):
        Container(
          width: 160,
          height: 160,
          child: Center(
            child: SvgPicture.asset('assets/icons/header_title_logo.svg', width: 10, height: 10,),
          ),
        ),
      ],
    ),
  ));

  Widget _productAddInfo(String title, List<String> list) {
    return GetBuilder<ProductInfoDetailController>(builder:(_)=>Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: medium14TextStyle,),
        const SizedBox(height: 17,),
        Row(
          children: [
            ...list.map((e) => Flexible(
              child: Row(
                children: [
                  SvgPicture.asset('assets/icons/check_on.svg'),
                  const SizedBox(width: 8),
                  Text(e, style: medium12TextStyle,),
                ],
              ),
            )),
          ],
        )
      ],
    ));
  }
  Widget _etc() =>   GetBuilder<ProductInfoDetailController>(builder:(_)=>Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('기타', style: medium14TextStyle,),
      const SizedBox(height: 17,),
      TextField(
        controller: TextEditingController(text: controller.model?.etc),
        style: regular14TextStyle.copyWith(color: gray_999Color),
        maxLines: 8,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13.42),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: gray_D5D7DBColor),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        enabled: false,
      )
    ],
  ));
}


