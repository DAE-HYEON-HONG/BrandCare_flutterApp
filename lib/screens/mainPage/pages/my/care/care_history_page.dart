import 'package:brandcare_mobile_flutter_v2/apis/base_api_service.dart';
import 'package:brandcare_mobile_flutter_v2/consts/box_shadow.dart';
import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/global_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/care_history_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/my_controller.dart';
import 'package:brandcare_mobile_flutter_v2/utils/date_format_util.dart';
import 'package:brandcare_mobile_flutter_v2/utils/status_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_bottom_filter.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class CareHistoryPage extends GetView<CareHistoryController> {
  CareHistoryPage({Key? key}) : super(key: key);
  final globalCtrl = Get.find<GlobalController>();
  final myController = Get.find<MyController>();
  @override
  Widget build(BuildContext context) {
    return DefaultAppBarScaffold(
        title: '케어/수선 이력',
        child: Container(
          padding: const EdgeInsets.only(left: 16, right: 16, top: 32),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              _renderProfile(),
              Padding(
                padding: const EdgeInsets.only(top: 24, bottom: 8),
                child: GestureDetector(
                  behavior: HitTestBehavior.translucent,
                  onTap: () {
                    Get.bottomSheet(
                      CustomBottomFilter(
                        sort1: () async {
                          await controller.filter(type: "LATEST");
                        },
                        sort2: () async {
                          await controller.filter(type: "");
                        },
                        mode: "",
                      ),
                    );
                  },
                  child: SvgPicture.asset('assets/icons/filter.svg'),
                ),
              ),
              const Divider(
                height: 0,
                thickness: 1,
              ),
              Flexible(
                  child: GetBuilder<CareHistoryController>(
                    builder: (_) => controller.careList!.length != 0 ?
                    ListView.separated(
                      controller: controller.pagingScroll,
                      itemBuilder: (context, idx) => GestureDetector(
                        behavior: HitTestBehavior.translucent,
                        onTap: () => Get.toNamed("/mainAddCare/add/status", arguments: {
                          "idx" : controller.careList![idx].id,
                          "back" : true,
                        }),
                        child: _item(
                          title: controller.careList![idx].title,
                          status: controller.careList![idx].status,
                          time: DateFormatUtil.convertDateFormat(date: controller.careList![idx].createdDate),
                          date: DateFormatUtil.convertOnlyTime(date: controller.careList![idx].createdDate),
                        ),
                      ),
                      separatorBuilder: (context, idx) => const Divider(height: 0, thickness: 1,),
                      itemCount: controller.careList!.length,
                    ) :
                    Container(
                      width: double.infinity,
                      height: 150,
                      child: Center(
                        child: Text(
                          "케어신청하신 제품이 없어요.",
                          style: regular14TextStyle.copyWith(
                            color: gray_999Color,
                          ),
                        ),
                      ),
                    ),
                  ),
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
        myController.myProfileInfoModel?.profile == null ?
        Container(
          width: 59,
          height: 50,
          child: SvgPicture.asset('assets/icons/person_outline.svg'),
        ):
        Container(
          width: 50,
          height: 50,
          child: ClipOval(
            child: ExtendedImage.network(
              BaseApiService.imageApi+myController.myProfileInfoModel!.profile!,
              fit: BoxFit.cover,
              cache: true,
              // ignore: missing_return
              loadStateChanged: (ExtendedImageState state) {
                switch(state.extendedImageLoadState) {
                  case LoadState.loading :
                    break;
                  case LoadState.completed :
                    break;
                  case LoadState.failed :
                    break;
                }
              },
            ),
          ),
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
                  '${globalCtrl.userInfoModel?.nickName} 님',
                  style: medium14TextStyle.copyWith(color: primaryColor),
                ),
                const Spacer(),
                Obx(() => Text(
                  '케어/수선 완료 ${controller.careCompleteCount}건',
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
  required String date}) => Container(
    padding: const EdgeInsets.symmetric(vertical: 16),
    child: Column(
      children: [
        Row(
          children: [
            Text(
              title,
              style: medium14TextStyle,
            ),
            const Spacer(),
            Text(
              StatusUtil.statusChk(status: status),
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
              '',
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
