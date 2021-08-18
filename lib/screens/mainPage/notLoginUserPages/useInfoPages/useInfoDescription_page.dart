import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/notLoginPagesControllers/useInfoControllers/useInfoDescription_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/instance_manager.dart';

class UseInfoDescriptionPage extends StatelessWidget {
  final UseInfoDescriptionController controller = Get.put(UseInfoDescriptionController());
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
              Text(
                "추가설명----",
                style: regular10TextStyle.copyWith(color: gray_8E8F95Color),
              ),
            ],
          ),
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
                    const SizedBox(height: 16),
                    Text(
                      "추가설명----",
                      style: regular10TextStyle.copyWith(color: gray_8E8F95Color),
                    ),
                    const SizedBox(height: 16),
                    controller.isOpened.value ?
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [Text(
                        "step1. 케어/수선 신청하기",
                        style: regular10TextStyle,
                      ),
                        const SizedBox(height: 4),
                        Text(
                          "- 홈 화면 하단 메뉴에서 [케어/수선]을 눌러주세요.",
                          style: regular10TextStyle,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "step2. 택배 보내기",
                          style: regular10TextStyle,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "- 신청이 완료되면, 아래의 배송주소로 제품을 배송해주세요.",
                          style: regular10TextStyle,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "- 보내시는 택배 비용은 고객님 부담입니다.",
                          style: regular10TextStyle,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "- 수선품을 보내실때 박스에 보내는 분의 연락처와 성명, 주소를 정확하게 기재해주세요.",
                          style: regular10TextStyle,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "> 서울 구로구 디지털로 33길 28(구로동 170-5), 우림 이비지센터 1차 1211호\n(주) 리드고\n우편번호: 08377  연락처: 02-6223-6223",
                          style: regular10TextStyle.copyWith(fontSize: 8),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "step3. 배송",
                          style: regular10TextStyle,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "- 서비스 완료된 제품은 신청시 작성해주신 배송지로 배송해드립니다.",
                          style: regular10TextStyle,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "- 받으실 택배 비용은 저희가 부담합니다.",
                          style: regular10TextStyle,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "- 배송 조회는 [마이페이지]에서 확인 가능합니다.",
                          style: regular10TextStyle,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "step4. 케어/수선 확인하기",
                          style: regular10TextStyle,
                        ),
                        Text(
                          "- [마이페이지]에서 before/ after 사진 확인을 하실 수 있습니다.",
                          style: regular10TextStyle,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "> 케어 수선이 힘든 경우 브랜드케어 측에서 반려, 환불될 수 있습니다.\n> 요청하신 항목과 금액으로 주문이 접수되오니 정확하게 신청해주시기 바랍니다.\n> 요청 사항과 접수 사진이 다를 경우 주문 취소 됩니다. ",
                          style: regular10TextStyle.copyWith(fontSize: 8),
                        ),
                      ],
                    ) :
                    Container(),
                    const SizedBox(height: 20),
                    Row(
                      mainAxisSize: MainAxisSize.max,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "케어/수선 신청 바로가기",
                          style: medium10TextStyle.copyWith(
                            color: primaryColor,
                            fontWeight: FontWeight.w700,
                            decoration: TextDecoration.underline,
                          ),
                        ),
                        GestureDetector(
                          onTap: () => controller.openExpansion(),
                          child: controller.isOpened.value ?
                          SvgPicture.asset(
                            "assets/icons/btn_up.svg",
                            height: 24,
                          ) : Text(
                            "자세히 보기",
                            style: regular10TextStyle.copyWith(
                              fontSize: 8,
                              color: gray_8E8F95Color,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
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
                "- 인증서도 발급해드려요.",
                style: regular10TextStyle,
              ),
              const SizedBox(height: 14),
              Text(
                "추가설명----",
                style: regular10TextStyle.copyWith(color: gray_8E8F95Color),
              ),
            ],
          ),
        ),
        const SizedBox(height: 8),
        // 4. 문장
        _description(
          "4. shop에 내 제품을 올리고 둘러보기",
          "",
          "shop 바로가기",
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "- 손이 잘 안가는 내 제품들 올리고, 내가 찾던 제품들이 여기에!",
                style: regular10TextStyle,
              ),
              const SizedBox(height: 4),
              Text(
                "추가설명----",
                style: regular10TextStyle.copyWith(color: gray_8E8F95Color),
              ),
            ],
          ),
        ),
        const SizedBox(height: 50),
      ],
    );
  }

  _description(String title, String smallTitle, String enter, Widget description,) {
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
              Text(
                "$enter",
                style: medium10TextStyle.copyWith(
                  color: primaryColor,
                  fontWeight: FontWeight.w700,
                  decoration: TextDecoration.underline,
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
