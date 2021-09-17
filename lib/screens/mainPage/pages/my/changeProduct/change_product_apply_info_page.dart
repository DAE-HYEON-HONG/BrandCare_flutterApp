import 'package:brandcare_mobile_flutter_v2/apis/global_api_service.dart';
import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/global_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/change_product_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/product/product_model.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/button/custom_button_onoff_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/change_product_expansionList_feild.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_expansion_tile_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/form_input_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/genuine_box_widget.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ChangeProductApplyInfoPage extends StatelessWidget {
  ChangeProductApplyInfoPage({Key? key}) : super(key: key);

  final controller = Get.put(ChangeProductController());
  final globalController = Get.find<GlobalController>();
  //late Widget customExpansionTile;
  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return DefaultAppBarScaffold(
      title: '제품 사용자 변경',
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('나의 제품', style: medium14TextStyle,),
                    const SizedBox(height: 10,),
                    GetBuilder<ChangeProductController>(builder: (_) {
                      return _myProduct();
                    }),
                    const SizedBox(height: 16,),
                    FormInputWidget(
                      onChange: (value) {},
                      onSubmit: (value) {},
                      controller: TextEditingController(),
                      title: '현재 사용자 아이디(이메일)',
                      isShowTitle: true,
                      hint: '${globalController.userInfoModel?.email}',
                      readOnly: true,
                    ),
                    const SizedBox(height: 16,),
                    FormInputWidget(
                      onChange: (value) {
                        controller.userEmail.value = value;
                        print(controller.userEmail.value);
                      },
                      onSubmit: (value) {},
                      controller: TextEditingController(),
                      title: '변경할 사용자 아이디(이메일)',
                      isShowTitle: true,
                      hint: '변경할 사용자 아이디(이메일)를 입력해주세요.',
                      textInputType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 60,),
                    GetBuilder<ChangeProductController>(
                        builder: (_) => SizedBox(height: controller.autoHeight(context))),
                  ],
                ),
              ),
            ),
            if(MediaQuery.of(context).viewInsets.bottom == 0)
            Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Obx(() =>
                    CustomButtonOnOffWidget(
                      title: '확인',
                      onClick: () {
                        controller.changeProductOwner();
                      },
                      isOn: controller.isOn,
                      radius: 0,
                    ),)
            ),
          ],
        ),
      ),
    );
  }

  // Widget _my_product() =>
  //     Container(
  //       padding: const EdgeInsets.only(top: 14, bottom: 15),
  //       decoration: BoxDecoration(
  //         borderRadius: BorderRadius.circular(4),
  //         border: Border.all(color: gray_D5D7DBColor),
  //       ),
  //       child: CustomExpantionTile2(
  //         isShowShadow: false,
  //         title: _title(),
  //         child: _child(),
  //       ),
  //     );

  _myProduct() {
    return ChangeProductExpansionListField(
        onTap: () {},
        hintText: "등록된 제품을 선택해주세요.",
        items: controller.myProductData,
        onChange: (value) {},
        idxChange: (value) {
          controller.selectMyProduct(value);
        },
        controller: ScrollController(),
    );
  }

  Widget _title() =>
      Container(
        child: controller.selectProductModel == null ? Text('등록된 제품을 선택해주세요.',
            style: regular14TextStyle.copyWith(color: gray_999Color)) :
        _titleItem(),
        // child: Text('123'),
      );

  Widget _child() =>
      Container(
        constraints: BoxConstraints(
          maxHeight: 72 * 4 + 25,
        ),
        child: ListView.builder(
          itemCount: controller.myProductData.length,
          itemBuilder: (context, idx) =>
              Padding(
                padding: EdgeInsets.only(bottom: 8.0, top: idx == 0 ? 18 : 0),
                child: _item(controller.myProductData[idx]),
              ), shrinkWrap: true,),
      );

  Widget _item(ProductModel data) =>
      GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          controller.selectMyProduct(data);
        },
        child: Container(
          padding: const EdgeInsets.only(left: 24, right: 48),
          height: 72,
          child: Row(
            children: [
              if(data != null &&
                  data.thumbnail != null)
                ExtendedImage.network(GlobalApiService.getImage(
                    data.thumbnail!),
                  width: 72,
                  height: 72,
                  cache: true,
                )
              else
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
                ),
              const SizedBox(
                width: 32,
              ),
              Flexible(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          '${data.brand} | ${data.category}',
                          style: regular12TextStyle.copyWith(
                              color: gray_333Color),
                        ),
                        const Spacer(),
                        GenuineBoxWidget(
                            isGenuine: data.genuine != 'UNCERTIFIED'),
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Text(
                      '${data.title}',
                      style: medium14TextStyle,
                      overflow: TextOverflow.ellipsis,
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      );

  Widget _titleItem() =>
      GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: () {
          Get.toNamed('/main/my/change_product/history/product/info',
              arguments: {'id': controller.selectProductModel!.id});
        },
        child: Container(
          padding: const EdgeInsets.only(left: 24 - 16, right: 48 - 16),
          height: 72,
          child: Row(
            children: [
              if(controller.selectProductModel != null &&
                  controller.selectProductModel!.thumbnail != null)
                ExtendedImage.network(GlobalApiService.getImage(
                    controller.selectProductModel!.thumbnail!),
                  width: 72,
                  height: 72,
                  cache: true,
                )
              else
                Image.asset(
                  'assets/icons/sample_product.png',
                  width: 72,
                  height: 72,
                ),
              const SizedBox(
                width: 16,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '${controller.selectProductModel!.brand} | ${controller
                            .selectProductModel!.category}',
                        style: regular12TextStyle.copyWith(
                            color: gray_333Color),
                      ),
                      // const Spacer(),
                      const SizedBox(width: 19),
                      GenuineBoxWidget(
                          isGenuine: controller.selectProductModel!.genuine !=
                              'UNCERTIFIED'),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    '${controller.selectProductModel!.title}',
                    style: medium14TextStyle,
                    overflow: TextOverflow.ellipsis,
                  )
                ],
              )
            ],
          ),
        ),
      );
}
