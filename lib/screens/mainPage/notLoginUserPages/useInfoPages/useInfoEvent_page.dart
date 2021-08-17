import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/notLoginPagesControllers/useInfoControllers/useInfoEvent_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class UseInfoEventPage extends StatelessWidget {
  final UseInfoEventController controller = Get.put(UseInfoEventController());
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
                "- 내용 필요",
                style: regular10TextStyle,
              ),
              SizedBox(height: 4),
              Text(
                "- 내용 필요(리스트 뷰 사용해야 할듯.)",
                style: regular10TextStyle,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
