import 'package:brandcare_mobile_flutter_v2/apis/base_api_service.dart';
import 'package:brandcare_mobile_flutter_v2/apis/global_api_service.dart';
import 'package:brandcare_mobile_flutter_v2/consts/box_shadow.dart';
import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/global_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/change_product_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/productInfo_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/product/product_model.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/button/custom_button_onoff_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_expansion_tile_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/form_input_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/genuine_box_widget.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ChangeProductInProductInfo extends StatelessWidget {
  ChangeProductInProductInfo({Key? key}) : super(key: key);

  final controller = Get.put(ChangeProductController());
  final globalController = Get.find<GlobalController>();
  final productInfoCtrl = Get.find<ProductInfoDetailController>();
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
                    _item("${productInfoCtrl.model?.thumbnail ?? ""}"),
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
                      controller: controller.emailTextCtrl,
                      title: '변경할 사용자 아이디(이메일)',
                      isShowTitle: true,
                      hint: '변경할 사용자 아이디(이메일)를 입력해주세요.',
                      textInputType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 60,),
                    // GetBuilder<ChangeProductController>(
                    //     builder: (_) => SizedBox(height: controller.autoHeight(context))),
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
                        controller.changeProductOwnerInfoPage(Get.arguments);
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

  Widget _item(String imgPath) => GetBuilder<ProductInfoDetailController>(
        builder: (_) => Container(
          height: 104,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
              color: whiteColor,
              borderRadius: BorderRadius.circular(12),
              boxShadow: [
                defaultBoxShadow,
              ]),
          child: Row(
            children: [
              imgPath == ""
                  ? Container(
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
                    )
                  : Container(
                      width: 72,
                      height: 72,
                      child: ExtendedImage.network(
                        BaseApiService.imageApi + imgPath,
                        fit: BoxFit.cover,
                        cache: true,
                      ),
                    ),
              const SizedBox(
                width: 16,
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '${productInfoCtrl.model?.brand ?? ""} | ${productInfoCtrl.model?.category ?? ""}',
                        style:
                            regular12TextStyle.copyWith(color: gray_333Color),
                      ),
                      const SizedBox(
                        width: 19,
                      ),
                      if (productInfoCtrl.model?.genuine != "REFUSAL")
                        GenuineBoxWidget(
                            isGenuine:
                                productInfoCtrl.model?.genuine == "GENUINE"
                                    ? true
                                    : false),
                    ],
                  ),
                  const SizedBox(
                    height: 5,
                  ),
                  Text(
                    "${productInfoCtrl.model?.title ?? "로딩중"}",
                    style: medium14TextStyle,
                  ),
                ],
              )
            ],
          ),
        ),
      );
}
