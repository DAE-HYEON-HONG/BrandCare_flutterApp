import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/global_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/mainPage_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/notLoginPagesControllers/useInfoControllers/useInfoDescription_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';
import 'package:get/get.dart';

class UseInfoDescriptionPage extends StatelessWidget {
  final UseInfoDescriptionController controller = Get.put(UseInfoDescriptionController());
  final globalCtrl = Get.find<GlobalController>();
  final mainPageCtrl = Get.find<MainPageController>();
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text("이용방법", style: regular14TextStyle),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: gray_f5f6f7Color,
              ),
            ),
          ),
        ),
        const SizedBox(height: 9),
        // 1. 문장
        _description(
          "1. 내가 가진 제품 등록하기",
          "",
          "제품 등록 바로가기",
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "- 홈화면 하단의 등록하기에서 나의 소중한 제품들을 등록해주세요.",
                style: regular10TextStyle,
              ),
              const SizedBox(height: 4),
              // Text(
              //   "추가설명----",
              //   style: regular10TextStyle.copyWith(color: gray_8E8F95Color),
              // ),
            ],
          ), (){
          mainPageCtrl.selectedIdx.value = 1;
          mainPageCtrl.update();
          mainPageCtrl.onItemTaped(1);
          Get.back();
        },
        ),
        const SizedBox(height: 8),
        // 2. 문장
        Container(
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "2. 케어 수선 받기",
                style: medium16TextStyle.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 4),
              Obx(() => Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "- 나의 제품들을 관리하고 수선해보세요!",
                      style: regular10TextStyle,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      "- 케어/수선 신청하는 방법",
                      style: regular10TextStyle,
                    ),
                    controller.isOpened.value ?
                    Image.asset(
                      "assets/icons/notLoginGuide.png",
                      fit: BoxFit.fitWidth,
                    ) :
                    Container(),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        if(globalCtrl.isLogin.value)
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          child: Text(
                            "케어/수선 신청 바로가기",
                            style: medium10TextStyle.copyWith(
                              color: primaryColor,
                              fontWeight: FontWeight.w700,
                              decoration: TextDecoration.underline,
                              fontSize: 14,
                            ),
                          ),
                          onTap: () {
                            mainPageCtrl.selectedIdx.value = 2;
                            mainPageCtrl.update();
                            mainPageCtrl.onItemTaped(2);
                            Get.back();
                          },
                        ),
                        // GestureDetector(
                        //   behavior: HitTestBehavior.translucent,
                        //   onTap: () => controller.openExpansion(),
                        //   child: controller.isOpened.value ?
                        //   SvgPicture.asset(
                        //     "assets/icons/btn_up.svg",
                        //     height: 24,
                        //   ) : Text(
                        //     "자세히 보기",
                        //     style: regular10TextStyle.copyWith(
                        //       fontSize: 12,
                        //       color: gray_8E8F95Color,
                        //       decoration: TextDecoration.underline,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ],
                ),
              )),
              const SizedBox(height: 8),
              Divider(height: 1, color: gray_f5f6f7Color),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // 3. 문장
        _description(
          "3. 정품 인증 받기",
          "(유료서비스)",
          "",
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "- 정품인지 아닌지 아리송한 제품들 전부 구분해드립니다!",
                style: regular10TextStyle,
              ),
              const SizedBox(height: 4),
              Text(
                "- 인증서를 발급해드립니다.",
                style: regular10TextStyle,
              ),
              const SizedBox(height: 14),
              // Text(
              //   "추가설명----",
              //   style: regular10TextStyle.copyWith(color: gray_8E8F95Color),
              // ),
            ],
          ), (){},
        ),
        const SizedBox(height: 8),
        // 4. 문장
        if(globalCtrl.isLogin.value)
        _description(
          "4. shop에 내 제품을 올리고 둘러보기",
          "",
          "shop 바로가기",
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "- shop에서 내가 찾던 물건도 찾고 안쓰는 명품도 팔아보자!",
                style: regular10TextStyle,
              ),
              const SizedBox(height: 4),
              // Text(
              //   "추가설명----",
              //   style: regular10TextStyle.copyWith(color: gray_8E8F95Color),
              // ),
            ],
          ),(){
          mainPageCtrl.selectedIdx.value = 3;
          mainPageCtrl.update();
          Get.back();
        },
        ),
        const SizedBox(height: 50),
      ],
    );
  }

  _description(String title, String smallTitle, String enter, Widget description, Function() onTap) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              "$title",
              style: medium16TextStyle.copyWith(fontWeight: FontWeight.w700),
            ),
            Text(
              "$smallTitle",
              style: regular10TextStyle.copyWith(fontWeight: FontWeight.w700, fontSize: 8),
            ),
          ],
        ),
        const SizedBox(height: 4),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              description,
              const SizedBox(height: 16),
              if(globalCtrl.isLogin.value)
              GestureDetector(
                behavior: HitTestBehavior.translucent,
                onTap: () {
                  onTap();
                },
                child: Text(
                  "$enter",
                  style: medium10TextStyle.copyWith(
                    color: primaryColor,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.underline,
                    fontSize: 14,
                  ),
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        Divider(height: 1, color: gray_f5f6f7Color),
      ],
    );
  }
}
