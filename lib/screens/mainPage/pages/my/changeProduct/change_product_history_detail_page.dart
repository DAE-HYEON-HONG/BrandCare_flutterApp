import 'package:brandcare_mobile_flutter_v2/apis/global_api_service.dart';
import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/change_product_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/product/product_change_model.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/changeProduct/change_product_enum.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/button/custom_button_empty_background_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/form_input_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/genuine_box_widget.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class ChangeProductHistoryDetailPage extends StatelessWidget {
  ChangeProductHistoryDetailPage({Key? key}) : super(key: key);

  late ChangeProductEnum type;
  late int id;
  late String status;
  final controller = Get.find<ChangeProductController>();

  @override
  Widget build(BuildContext context) {
    type = Get.arguments['type'];
    id = Get.arguments['id'];
    status = Get.arguments['status'];
    controller.getChangeProductOnce(id, status);

    return DefaultAppBarScaffold(title: '제품 사용자 변경', child: GetBuilder<ChangeProductController>(builder: (_) =>Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left:16, top:32, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(type == ChangeProductEnum.REQUEST ? '나의 제품' : '제품', style: medium14TextStyle,),
              const SizedBox(height: 10,),
              _item(),
              const SizedBox(height: 16,),
              FormInputWidget(onChange: (value){}, onSubmit: (value){}, controller: TextEditingController(),
                readOnly: true,
                hint: '${controller.historyOnceProductData?.currentEmail ?? ''}',
                title: type == ChangeProductEnum.COMPLETE ? '이전 사용자 아이디(이메일)' :'현재 사용자 아이디(이메일)',
                isShowTitle: true,
              ),
              const SizedBox(height: 16,),
              FormInputWidget(onChange: (value){}, onSubmit: (value){}, controller: TextEditingController(
                text: '${controller.historyOnceProductData?.beforeEmail ?? ''}'
              ),
                readOnly: true,
                title: type == ChangeProductEnum.COMPLETE ? '변경 완료된 사용자 아이디(이메일)' :'변경할 사용자 아이디(이메일)',
                isShowTitle: true,
              ),
            ],
          ),
        ),
        const Spacer(),
        Text(controller.getTypeComment(type),
          textAlign: TextAlign.center,
          style: regular14TextStyle.copyWith(color: gray_999Color),
        ),
        const SizedBox(height: 32,),
        _btnItem(),
      ],
    )),);
  }
  Widget _item() => GestureDetector(
    onTap: (){
      Get.toNamed('/main/my/change_product/history/product/info', arguments: {'id': controller.historyOnceProductData!.productId});
    },
    child: Container(
      height: 120,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: gray_D5D7DBColor)
      ),
      child: Row(
        children: [
          if(controller.historyOnceProductData != null &&
              controller.historyOnceProductData!.image != "사진없음")
            ExtendedImage.network(GlobalApiService.getImage(
                controller.historyOnceProductData!.image!),
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
          const SizedBox(width: 16,),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${controller.historyOnceProductData?.brand} | ${controller.historyOnceProductData?.category}', style: regular12TextStyle.copyWith(color: gray_333Color),),
                  const SizedBox(width: 19,),
                  GenuineBoxWidget(isGenuine: controller.historyOnceProductData?.genuine != 'UNCERTIFIED'),
                ],
              ),
              const SizedBox(height: 5,),
              Text('${controller.historyOnceProductData?.title}', style: medium14TextStyle,overflow: TextOverflow.ellipsis,),
            ],
          )
        ],
      ),
    ),
  );

  Widget _btnItem() {
    if(type == ChangeProductEnum.REQUEST){
      return CustomButtonEmptyBackgroundWidget(title: '확인 중', onClick: () async {
        if(await controller.cancel(controller.historyOnceProductData!.id)){
        Get.back();
        Get.snackbar('알림', '변경 요청이 취소되었습니다.', snackPosition: SnackPosition.BOTTOM);
        }
      });
    }else if(type == ChangeProductEnum.RECEIVED) {
      return Row(
        children: [
          Flexible(child: CustomButtonEmptyBackgroundWidget(title: '확인', onClick: () async {
            if(await controller.accept(controller.historyOnceProductData!.id)){
              Get.back();
              Get.snackbar('알림', '변경 요청이 완료되었습니다.', snackPosition: SnackPosition.BOTTOM);
            }
          })),
          Flexible(child: CustomButtonEmptyBackgroundWidget(title: '취소', onClick: () async {
            if(await controller.cancel(controller.historyOnceProductData!.id)){
            Get.back();
            Get.snackbar('알림', '변경 요청이 취소되었습니다.', snackPosition: SnackPosition.BOTTOM);
            }
          }))
        ],
      );
    }
    return SizedBox();
  }
}
