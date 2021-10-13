import 'package:brandcare_mobile_flutter_v2/apis/global_api_service.dart';
import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/global_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/change_product_controller.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/button/custom_button_empty_background_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/button/custom_button_onoff_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_expansion_tile_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/form_input_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/genuine_box_widget.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ChangeProductApplyChangePage extends StatelessWidget {
  ChangeProductApplyChangePage({Key? key}) : super(key: key);

  final controller = Get.find<ChangeProductController>();
  final globalController = Get.find<GlobalController>();
  late Widget customExpansionTile;
  late BuildContext context;

  @override
  Widget build(BuildContext context) {
    this.context = context;
    return WillPopScope(
      child: DefaultAppBarScaffold(
        title: '제품 사용자 변경',
        isLeadingShow: false,
        child: Container(
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(left: 16, right: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('나의 제품', style: medium14TextStyle,),
                            const SizedBox(height: 10,),
                            _my_product(),
                            const SizedBox(height: 16,),
                            FormInputWidget(onChange: (value){}, onSubmit: (value){}, controller: TextEditingController(),
                              title: '현재 사용자 아이디(이메일)',
                              isShowTitle: true,
                              hint: '${globalController.userInfoModel!.email}',
                              readOnly: true,
                            ),
                            const SizedBox(height: 16,),
                            FormInputWidget(
                              onChange: (value){},
                              onSubmit: (value){},
                              controller: TextEditingController(
                                  text: controller.userEmail.value
                              ),
                              readOnly: true,
                              title: '변경할 사용자 아이디(이메일)',
                              isShowTitle: true,
                              hint: '변경할 사용자 아이디(이메일)를 입력해주세요.',
                            ),
                            const SizedBox(height: 60,),
                            //autoHeight
                            GestureDetector(
                              behavior: HitTestBehavior.translucent,
                              onTap: (){
                                Get.back();
                                Get.back();
                              },
                              child: Row(
                                children: [
                                  Text('제품 사용자 변경으로 돌아가기', style: medium14TextStyle,),
                                  const Spacer(),
                                  SvgPicture.asset('assets/icons/btn_arrow_right.svg', color: gray_666Color,),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 100),
                      // GetBuilder<ChangeProductController>(
                      //     builder: (_) => SizedBox(height: controller.autoHeight(context))),
                    ],
                  ),
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Column(
                    children: [
                      Center(
                        child: Text('변경할 사용자의 확인을 기다리는 중입니다.\n"확인중" 버튼을 누를 시 변경 요청이 취소 됩니다.',
                          textAlign: TextAlign.center,
                          style: regular14TextStyle.copyWith(color: gray_999Color),
                        ),
                      ),
                      const SizedBox(height: 34,),
                      CustomButtonEmptyBackgroundWidget(
                        title: '확인 중',
                        onClick: ()  {
                          // Get.back();
                          showConfirmDialog();
                        },
                        radius: 0,
                      ),
                    ],
                  ),
                ),
              ],
            )
        ),
      ),
      onWillPop: () async{
        Get.back();
        Get.back();
        return false;
      },
    );
  }

  showConfirmDialog() async {
    Get.dialog(
        CustomDialogWidget(
      content: '변경 요청을 취소하시겠습니까?',
      title: '알림',
      isSingleButton: false,
      okTxt: '확인',
      cancelTxt: '취소',
      onClick: () async {
        if(await controller.cancel(controller.cancelIdx!)){
          Get.back();
          Get.back();
          Get.snackbar('알림', '변경 요청이 취소되었습니다.', snackPosition: SnackPosition.BOTTOM);
        }
      },
      onCancelClick: () {
        Get.back();
      },
    ));
  }

  Widget _my_product() => Container(
    padding: const EdgeInsets.only(top: 14, bottom: 15),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(4),
      border: Border.all(color: gray_D5D7DBColor),
    ),
    child: IgnorePointer(
      ignoring: true,
      child: CustomExpantionTile2(
        isShowShadow: false,
        title: _title(),
        child: _child(),
      ),
    ),
  );

  Widget _title() => Container(
    child:_titleItem(),
    // child: Text('123'),
  );

  Widget _child() => Container(
    constraints: BoxConstraints(
      maxHeight: 72 * 4 + 25,
    ),
    child: ListView.builder(
      itemCount: 5,
      itemBuilder: (context, idx) => Padding(
      padding: EdgeInsets.only(bottom: 8.0, top: idx ==0 ? 18 : 0),
      child: _item(idx),
    ), shrinkWrap: true,),
  );

  Widget _item(int idx) => GestureDetector(
    behavior: HitTestBehavior.translucent,
    onTap: (){
      // controller.updateSelectIdx(idx);
    },
    child: Container(
      padding: const EdgeInsets.only(left: 24, right: 48),
      height: 72,
      child: Row(
        children: [
          Image.asset(
            'assets/icons/sample_product.png',
            width: 72,
            height: 72,
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
                      '루이비통 | 가방',
                      style: regular12TextStyle.copyWith(color: gray_333Color),
                    ),
                    const Spacer(),
                    if(idx != 3)
                      GenuineBoxWidget(isGenuine: idx.isEven),
                  ],
                ),
                const SizedBox(
                  height: 16,
                ),
                Text(
                  '나의 에쁜이$idx',
                  style: medium14TextStyle,
                )
              ],
            ),
          )
        ],
      ),
    ),
  );

  Widget _titleItem() => GestureDetector(
    behavior: HitTestBehavior.translucent,
    onTap: (){
      Get.toNamed('/main/my/change_product/history/product/info', arguments: {'id': controller.selectProductModel!.id});
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
                    '${controller.selectProductModel!.brand} | ${controller.selectProductModel!.category}',
                    style: regular12TextStyle.copyWith(color: gray_333Color),
                  ),
                  // const Spacer(),
                  const SizedBox(width: 19),
                  GenuineBoxWidget(isGenuine: controller.selectProductModel!.genuine != 'UNCERTIFIED'),
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
