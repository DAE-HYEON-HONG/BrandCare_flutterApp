import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/point_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/mypage/point/pointList_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/point/point_list_info_model.dart';
import 'package:brandcare_mobile_flutter_v2/utils/date_format_util.dart';
import 'package:brandcare_mobile_flutter_v2/utils/number_format_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/button/custom_button_empty_background_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PointPage extends GetView<PointController> {
  const PointPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultAppBarScaffold(
      title: '포인트',
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: GetBuilder<PointController>(
          builder: (_) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 32),
                child: Row(
                  children: [
                    Text(
                      '보유 포인트',
                      style: medium16TextStyle,
                    ),
                    const Spacer(),
                    Text(
                      '${NumberFormatUtil.convertNumberFormat(number: controller.myPoint.value)}P',
                      style: medium16TextStyle,
                    ),
                  ],
                ),
              ),
              CustomButtonEmptyBackgroundWidget(
                  title: '+ 포인트 등록하기',
                  onClick: () {
                    Get.toNamed('/main/my/point/add');
                  }),
              const SizedBox(
                height: 32,
              ),
              Text(
                '포인트 이용내역',
                style: medium14TextStyle,
              ),
              const SizedBox(height: 16,),
              const Divider(
                height: 0,
                thickness: 1,
                color: gray_F1F3F5Color,
              ),
              Flexible(
                  child: GetBuilder<PointController>(builder: (_) => ListView.separated(
                    controller: controller.pagingScroll,
                    itemBuilder: (context, idx) => _item(
                      controller.list![idx],
                    ),
                    separatorBuilder: (context, idx) => Divider(
                      height: 0,
                      thickness: 1,
                      color: gray_F1F3F5Color,
                    ),
                    itemCount: controller.list?.length ?? 0,
                  )),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _item(PointListInfoModel model) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              Text(
                model.content,
                style: regular14TextStyle,
              ),
              const Spacer(),
              // Text(
              //   '${NumberFormatUtil.convertNegativePositiveNumber(number: model.usedPoint)}',
              //   style: regular14TextStyle.copyWith(
              //       color: model.usedPoint.isNegative ? redColor : purpleColor),
              // )
              Text(
                model.history,
                style: regular14TextStyle,
              ),
            ],
          ),
          const SizedBox(
            height: 8,
          ),
          Text(
            DateFormatUtil.convertDateFormat(date: model.createdDate, format: "yyyy.MM.dd"),
            style: medium10TextStyle.copyWith(color: gray_666Color),
          ),
          const SizedBox(
            height: 16,
          ),
        ],
      ),
    );
  }
}
