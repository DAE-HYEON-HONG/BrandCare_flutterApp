import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/addCareControllers/addCareDetail_controller.dart';
import 'package:brandcare_mobile_flutter_v2/utils/date_format_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AddCareDetailPage extends StatelessWidget {
  final AddCareDetailController controller = Get.put(AddCareDetailController());
  @override
  Widget build(BuildContext context) {
    return DefaultAppBarScaffold(
      title: "제품케어 결과 보기",
      child: _renderBody(),
    );
  }

  _renderBody() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 32),
              _productInfo(
                imgPath: 'imgPath',
                title: "끈길이 조절 외 n건",
                type: "케어/수선 신청",
                clock: DateFormatUtil.convertOnlyTime(date: "2021-06-02T17:11:59.040906"),
                date: DateFormatUtil.convertOnlyDate(date: "2021-06-02T17:11:59.040906"),
              ),
              const SizedBox(height: 24),
              Text('케어/수선 1 - 케어/수선 전'),
              const SizedBox(height: 10),
              _detailImage('assets/icons/sample_product.png'),
            ],
          ),
        )
      ),
    );
  }

  _productInfo({required String imgPath, required String title, required String type, required String clock, required String date}){
    return Container(
      width: double.infinity,
      height: 150,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: whiteColor,
        boxShadow: [
          BoxShadow(
            offset: Offset(0, 2),
            color: Color.fromRGBO(0, 0, 0, 0.08),
            blurRadius: 8.0,
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.asset(
                'assets/icons/sample_product.png',
                height: 72,
              ),
              const SizedBox(width: 32),
              Text(
                '$title',
                style: medium14TextStyle,
              )
            ],
          ),
          const SizedBox(height: 3),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '$type',
                    style: medium14TextStyle.copyWith(
                      color: primaryColor,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Text(
                        clock,
                        style: regular14TextStyle,
                      ),
                      const SizedBox(width: 8),
                      Container(width: 1, height: 12, color: gray_999Color),
                      const SizedBox(width: 8),
                      Text(
                        date,
                        style: regular14TextStyle,
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }

  _detailImage(String imgPath){
    return Container(
      width: double.infinity,
      height: 328,
      child: GestureDetector(
        onTap: () => _dialogImage(imgPath),
        child: Image.asset(imgPath, fit: BoxFit.cover),
      ),
    );
  }

  _dialogImage(String imgPath){
    return Get.dialog(
      Container(
        width: double.infinity,
        height: 360,
        child: Stack(
          children: [
            Image.asset(imgPath, fit: BoxFit.cover),
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              child: Container(
                width: 40,
                height: 18,
                decoration: BoxDecoration(
                  color: Colors.black.withOpacity(0.6),
                  borderRadius: BorderRadius.circular(50),
                ),
                child: Center(
                  child: Text(
                    "0/0",
                    style: regular12TextStyle.copyWith(color: whiteColor),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
