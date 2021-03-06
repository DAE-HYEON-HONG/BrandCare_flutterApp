 import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/mainPage_controller.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/mainHome_page.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';

class MainPage extends GetView<MainPageController> {
  DateTime? currentBackPressTime;
  @override
  Widget build(BuildContext context) {
    if(Platform.isIOS) SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    return GetBuilder<MainPageController>(builder: (_) => WillPopScope(
        onWillPop: (){
          print(controller.selectedIdx.value);
          DateTime now = DateTime.now();
          if(controller.selectedIdx.value == 0){
            if (currentBackPressTime == null ||
                now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
              currentBackPressTime = now;
              Get.snackbar(
                '알림', '뒤로가기버튼을 한번 더 누르면 종료됩니다.',
                snackPosition: SnackPosition.BOTTOM,
                duration: const Duration(milliseconds: 900),
              );
              return Future.value(false);
            }else{
              return Future.value(true);
            }
          } else if(controller.selectedIdx.value == 1){
            Get.dialog(CustomDialogWidget(
              isSingleButton: false,
              content: '제품 등록 진행을 취소하시겠습니까?',
              okTxt: '확인',
              cancelTxt: '취소',
              onClick: () {
                print('ok');
                Get.back();
                controller.onItemTaped(0);
                Get.back();
                return Future(() => true);
              },
              onCancelClick: () {
                Get.back();
                return Future(() => false);
              },
            ));

            return Future(() => true);
          } else if(controller.selectedIdx.value == 2){
              Get.dialog(CustomDialogWidget(
                isSingleButton: false,
                content: '케어/수선 등록을 취소하시겠습니까?',
                okTxt: '확인',
                cancelTxt: '취소',
                onClick: () {
                  Get.back();
                  controller.onItemTaped(0);
                  Get.back();
                  return Future(() => true);
                },
                onCancelClick: () {
                  Get.back();
                  return Future(() => false);
                },
              ));
              return Future(() => true);
          }
          else{
            controller.backHome();
            return Future.value(false);
          }
        },
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Obx(()=> Container(
            color: whiteColor,
            width: double.infinity,
            height: double.infinity,
            child: Stack(
              children: <Widget>[
                Positioned(
                  child: Obx(() => Container(
                    child: controller.widgetOptions
                        .elementAt(controller.selectedIdx.value),
                  )),
                  top: 0,
                  left: 0,
                  right: 0,
                  bottom: MediaQuery.of(context).viewInsets.bottom == 0 ? 45 : 0,
                ),
                Positioned(
                  left: 0,
                  right: 0,
                  bottom: 0,
                  child: Container(
                    width: double.infinity,
                    height: 64.h,
                    decoration: BoxDecoration(
                      color: whiteColor,
                      borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(20),
                          topRight: Radius.circular(20)),
                      boxShadow: [
                        BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 4,
                            offset: Offset(0.0, -5.0)),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: <Widget>[
                        //전체를 채울 시 expanded 사용 권장
                        Expanded(
                          child: InkWell(
                            onTap: () => controller.onItemTaped(0),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/home_on.svg',
                                  height: 20.h,
                                  color: controller.selectedIdx.value == 0 ? primaryColor : gray_8E8F95Color,
                                ),
                                Text(
                                  "홈",
                                  style: controller.selectedIdx.value == 0 ?
                                  medium12TextStyle.copyWith(
                                    color: primaryColor,
                                    fontSize: 12.sp,
                                  ) : medium12TextStyle.copyWith(
                                    color: gray_8E8F95Color,
                                    fontSize: 12.sp,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () => controller.onItemTaped(1),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/register_on.svg',
                                  height: 20.h,
                                  color: controller.selectedIdx.value == 1 ? primaryColor : gray_8E8F95Color,
                                ),
                                Text(
                                  "등록하기",
                                  style: controller.selectedIdx.value == 1 ?
                                  medium12TextStyle.copyWith(
                                    color: primaryColor,
                                    fontSize: 12.sp,
                                  ) : medium12TextStyle.copyWith(
                                    color: gray_8E8F95Color,
                                    fontSize: 12.sp,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () => controller.onItemTaped(2),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                const SizedBox(
                                  height: 20,
                                ),
                                Text(
                                  "케어/수선",
                                  style: controller.selectedIdx.value == 2 ?
                                  medium12TextStyle.copyWith(
                                    color: primaryColor,
                                    fontSize: 12.sp,
                                  ) : medium12TextStyle.copyWith(
                                    color: gray_8E8F95Color,
                                    fontSize: 12.sp,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () => controller.onItemTaped(3),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/shop_on.svg',
                                  height: 20.h,
                                  color: controller.selectedIdx.value == 3 ? primaryColor : gray_8E8F95Color,
                                ),
                                Text(
                                  "SHOP",
                                  style: controller.selectedIdx.value == 3 ?
                                  medium12TextStyle.copyWith(
                                    color: primaryColor,
                                    fontSize: 12.sp,
                                  ) : medium12TextStyle.copyWith(
                                    color: gray_8E8F95Color,
                                    fontSize: 12.sp,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                        Expanded(
                          child: InkWell(
                            onTap: () => controller.onItemTaped(4),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                SvgPicture.asset(
                                  'assets/icons/mypage_on.svg',
                                  height: 20.h,
                                  color: controller.selectedIdx.value == 4 ? primaryColor : gray_8E8F95Color,
                                ),
                                Text(
                                  "마이페이지",
                                  style: controller.selectedIdx.value == 4 ?
                                  medium12TextStyle.copyWith(
                                    color: primaryColor,
                                    fontSize: 12.sp,
                                  ) : medium12TextStyle.copyWith(
                                    color: gray_8E8F95Color,
                                    fontSize: 12.sp,
                                  ),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 30.h,
                  left: 0,
                  right: 0,
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () => controller.onItemTaped(2),
                        child: Container(
                          width: 50.w,
                          height: 50.h,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: primaryColor,
                            boxShadow: [
                              BoxShadow(
                                  color: Colors.black.withOpacity(0.3),
                                  blurRadius: 5),
                            ],
                          ),
                          child: Center(
                            child: SvgPicture.asset(
                              'assets/icons/care_on.svg',
                              height: 20.h,
                              color: whiteColor,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          )),
        )
    ));
  }
}
