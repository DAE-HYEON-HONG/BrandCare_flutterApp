import 'package:brandcare_mobile_flutter_v2/consts/box_shadow.dart';
import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/global_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/genuine_controller.dart';
import 'package:brandcare_mobile_flutter_v2/utils/date_format_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:get/get.dart';

class GenuineHistoryPage extends GetView<GenuineController> {
  GenuineHistoryPage({Key? key}) : super(key: key);
  final globalCtrl = Get.find<GlobalController>();
  @override
  Widget build(BuildContext context) {
    return DefaultAppBarScaffold(
        title: '정품인증 이력',
        child: Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _renderProfile(),
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 8),
                child: SvgPicture.asset('assets/icons/filter.svg'),
              ),
              const Divider(
                height: 0,
                thickness: 1,
              ),
              Flexible(
                  child: GetBuilder<GenuineController>(builder: (_) => ListView.separated(
                    controller: controller.pagingScroll,
                    itemBuilder: (context, idx) => _item(
                      title: controller.genuineList![idx].title ?? '',
                      status: controller.genuineList![idx].status,
                      time: DateFormatUtil.convertDateFormat(date: controller.genuineList![idx].createdDate),
                      date: DateFormatUtil.convertOnlyTime(date: controller.genuineList![idx].createdDate),
                      brand: controller.genuineList![idx].brand ?? '',
                      category: controller.genuineList![idx].category ?? '',
                    ),
                    separatorBuilder: (context, idx) => const Divider(height: 0, thickness: 1,),
                    itemCount: controller.genuineList!.length,
                  )),
              ),
            ],
          ),
        ));
  }

  Widget _renderProfile() => Container(
        padding: const EdgeInsets.symmetric(vertical: 35, horizontal: 24),
        decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              defaultBoxShadow,
            ]),
        child: Row(
          children: [
            Container(
              width: 59,
              height: 50,
              child: SvgPicture.asset('assets/icons/person_outline.svg'),
            ),
            const SizedBox(
              width: 24,
            ),
            Flexible(
              child: Container(
                height: 50,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      '${globalCtrl.userInfoModel.nickName} 님',
                      style: medium14TextStyle.copyWith(color: primaryColor),
                    ),
                    const Spacer(),
                    Obx(() => Text(
                      '인증 완료 제품 ${controller.completeCount.value}개 | 미인증 제품 ${controller.notCompleteCount.value}개',
                      style: regular12TextStyle.copyWith(color: primaryColor),
                    )),
                  ],
                ),
              ),
            )
          ],
        ),
      );

  Widget _item({
    required String title,
    required String status,
    required String time,
    required String date,
    required String brand,
    required String category}) => Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        child: Column(
          children: [
            Row(
              children: [
                Text(
                  '$brand | $category',
                  style: regular12TextStyle.copyWith(color: gray_333Color),
                ),
                const Spacer(),
                Text(
                  '진행중',
                  style: medium14TextStyle.copyWith(color: gray_333Color),
                )
              ],
            ),
            const SizedBox(
              height: 4,
            ),
            Row(
              children: [
                Text(
                  '$title',
                  style: medium14TextStyle,
                ),
                const Spacer(),
                Text(
                  '$time | $date',
                  style: regular14TextStyle.copyWith(color: gray_333Color),
                )
              ],
            )
          ],
        ),
      );
}
