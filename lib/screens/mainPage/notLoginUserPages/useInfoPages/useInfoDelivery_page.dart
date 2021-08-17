import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/notLoginPagesControllers/useInfoControllers/useInfoDelivery_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UseInfoDeliveryPage extends StatelessWidget {
  final UseInfoDeliveryController controller = Get.put(UseInfoDeliveryController());
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          child: Text("택배 유의 사항", style: regular14TextStyle),
          decoration: BoxDecoration(
            border: Border(
              bottom: BorderSide(
                color: gray_f5f6f7Color,
              ),
            ),
          ),
        ),
        SizedBox(height: 9),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                "- 수선하고자 하는 물품을 아래의 주소로 보내주세요.",
                style: regular10TextStyle,
              ),
              SizedBox(height: 4),
              Text(
                "- 보내실 때 택배 비용은 고객님 부담입니다.",
                style: regular10TextStyle,
              ),
              SizedBox(height: 4),
              Text(
                "- 받으실 때 택배 비용은 당사 부담으로 보내드립니다.",
                style: regular10TextStyle,
              ),
              SizedBox(height: 4),
              Text(
                "- 수선품을 보내실 때 박스에 보내는 분의 연락처와 성명, 주소를 정확하게 기재해 주세요.",
                style: regular10TextStyle,
              ),
            ],
          ),
        ),
        SizedBox(height: 8),
        Divider(height: 1, color: gray_f5f6f7Color),
        SizedBox(height: 8),
        Padding(
          padding: const EdgeInsets.only(left: 10, right: 10),
          child: Text(
            "> 서울 구로구 디지털로 33길 28(구로동 170-5), 우림 이비지센터 1차 1211호\n(주) 리드고\n우편번호: 08377  연락처: 02-6223-6223",
            style: regular10TextStyle.copyWith(fontSize: 8),
          ),
        ),
      ],
    );
  }
}
