import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/shopControllers/shopListController/mainShopListInst_controller.dart';
import 'package:brandcare_mobile_flutter_v2/utils/date_format_util.dart';
import 'package:brandcare_mobile_flutter_v2/utils/number_format_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/shop_list_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainShopListInstPage extends StatelessWidget {
  final MainShopListInstController controller = Get.put(MainShopListInstController());
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Column(
          children: <Widget>[
            ListView.separated(
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              padding: const EdgeInsets.only(left: 16, right: 16),
              separatorBuilder: (context, idx){
                return const Divider(
                  height: 1,
                  color: gray_f5f6f7Color,
                );
              },
              itemCount: 50,
              itemBuilder: (context, idx){
                return ShopListWidget(
                  title: "샤넬백 짝퉁 채널백 60사이즈",
                  imageUrl: "",
                  brandName: "샤넬짝퉁 채널",
                  category: "가방",
                  genuine: false,
                  money: NumberFormatUtil.convertNumberFormat(number: 100000),
                  date: DateFormatUtil.convertDateTimeFormat(date: "2021-06-02T17:11:59.040906"),
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(right: 16, left: 16),
              child: const Divider(
                height: 1,
                color: gray_f5f6f7Color,
              ),
            ),
            const SizedBox(height: 80),
          ],
        ),
      ),
    );
  }
}
