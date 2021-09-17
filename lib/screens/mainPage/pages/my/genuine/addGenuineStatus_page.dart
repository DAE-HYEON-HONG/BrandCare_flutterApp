import 'package:brandcare_mobile_flutter_v2/apis/base_api_service.dart';
import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/addGenuineStatus_controller.dart';
import 'package:brandcare_mobile_flutter_v2/utils/date_format_util.dart';
import 'package:brandcare_mobile_flutter_v2/utils/status_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/button/custom_button_empty_background_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/button/custom_button_onoff_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

class AddGenuineStatusPage extends StatelessWidget {
  AddGenuineStatusController controller = Get.put(AddGenuineStatusController());
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      child: DefaultAppBarScaffold(
        title: "정품인증 신청현황",
        child: _renderBody(),
        isLeadingShow: false,
      ),
      //onWillPop: () => Future(() => false),
      onWillPop: () => Future(() => controller.back),
    );
  }

  _renderBody(){
    return GetBuilder<AddGenuineStatusController>(builder: (_) => Container(
      width: double.infinity,
      height: double.infinity,
      child: Stack(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Padding(
              padding: const EdgeInsets.only(left: 16, right: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32),
                  _productInfo(
                    imgPath: "${controller.genuineStatus?.product_image ?? ""}",
                    title: "${controller.genuineStatus?.title ?? "로딩중"}",
                    type: StatusUtil.statusChk(status: "${controller.genuineStatus?.status}"),
                    clock: DateFormatUtil.convertOnlyTime(date: "${controller.genuineStatus?.createdDate ?? "2021-08-31T00:39:24.562773"}"),
                    date: DateFormatUtil.convertOnlyDate(date: "${controller.genuineStatus?.createdDate ?? "2021-08-31T00:39:24.562773"}"),
                  ),
                  const SizedBox(height: 24),
                  ListView.builder(
                    itemCount: controller.genuineStatusJson.length,
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, idx){
                      return _status(
                        title: controller.genuineStatusJson[idx]['statusType'],
                        date: DateFormatUtil.convertOnlyDate(date: "${_.genuineStatus?.createdDate ?? "2021-08-31T00:39:24.562773"}"),
                        time: DateFormatUtil.convertOnlyTime(date: "${_.genuineStatus?.createdDate ?? "2021-08-31T00:39:24.562773"}"),
                        isNext: idx == controller.genuineStatusJson.length - 1 ? false : true,
                        checked: controller.genuineStatusJson[idx]['checked'],
                      );
                    },
                  ),
                  const SizedBox(height: 24),
                  CustomButtonOnOffWidget(
                    title: '정품인증 결과보기',
                    onClick: () {
                      if(controller.dateStatus?.be_releasedDate != null){
                        controller.detail();
                      }
                    },
                    isOn: controller.dateStatus?.be_releasedDate == null ? false : true,
                    radius: 30,
                  ),
                  const SizedBox(height: 24),
                  Text('제품명', style: medium14TextStyle),
                  const SizedBox(height: 10),
                  _inputField('${controller.genuineStatus?.title}'),
                  const SizedBox(height: 24),
                  Text('택배 반송 주소', style: medium14TextStyle),
                  const SizedBox(height: 10),
                  Row(
                    children: [
                      _backPost(true, "보내는 분"),
                      const SizedBox(width: 47),
                      _backPost(false, "받는 분"),
                    ],
                  ),
                  const SizedBox(height: 24),
                  Text('이름', style: medium14TextStyle),
                  const SizedBox(height: 10),
                  _inputField(controller.genuineStatus?.returnType == "SENDER" ? "${controller.genuineStatus?.sender.name}" : "${controller.genuineStatus?.receiver.name}"),
                  const SizedBox(height: 24),
                  Text('전화번호', style: medium14TextStyle),
                  const SizedBox(height: 10),
                  _inputField(controller.genuineStatus?.returnType == "SENDER" ? "${controller.genuineStatus?.sender.phone}" : "${controller.genuineStatus?.receiver.phone}"),
                  const SizedBox(height: 24),
                  Text('주소', style: medium14TextStyle),
                  const SizedBox(height: 10),
                  _inputField(controller.genuineStatus?.returnType == "SENDER" ?
                  "${controller.genuineStatus?.sender.address.city}":
                  "${controller.genuineStatus?.receiver.address.city}"),
                  const SizedBox(height: 10),
                  _inputField(controller.genuineStatus?.returnType == "SENDER" ?
                  "${controller.genuineStatus?.sender.address.street}":
                  "${controller.genuineStatus?.receiver.address.street}"),
                  const SizedBox(height: 24),
                  Text('요청사항', style: medium14TextStyle),
                  const SizedBox(height: 10),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Color(0xffD5D7DB),
                        width: 1.0,
                      ),
                      borderRadius: BorderRadius.circular(5),
                    ),
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: 290,
                        maxHeight: 700,
                      ),
                      child: TextFormField(
                        readOnly: true,
                        onChanged: (value) {},
                        maxLines: null,
                        controller: TextEditingController(text: controller.genuineStatus?.request_term),
                        style: regular14TextStyle.copyWith(color: gray_999Color),
                        decoration: InputDecoration(
                          border: InputBorder.none,
                          focusedBorder: InputBorder.none,
                          disabledBorder: InputBorder.none,
                          enabledBorder: InputBorder.none,
                          hintStyle: regular14TextStyle.copyWith(color: gray_999Color),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 120),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: CustomButtonEmptyBackgroundWidget(
              title: "확인",
              onClick: () => controller.nextLevel(),
            ),
          ),
        ],
      ),
    ));
  }

  _backPost(bool isChecked, String title){
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isChecked ? primaryColor : whiteColor,
            border: Border.all(width: 1, color: primaryColor),
          ),
        ),
        const SizedBox(width: 8),
        Text(title, style: regular14TextStyle.copyWith(color: gray_666Color)),
      ],
    );
  }

  _carePictures(String imgPath, String title){
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, top: 8, bottom: 16),
      width: double.infinity,
      height: 354,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: gray_D5D7DBColor, width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("$title", style: regular14TextStyle),
          const SizedBox(height: 10),
          Image.asset(
            '$imgPath',
            height: 296,
            fit: BoxFit.cover,
          )
        ],
      ),
    );
  }

  _inputField(String title){
    return Container(
      width: double.infinity,
      height: 48,
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(color: gray_D5D7DBColor, width: 1),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Text(title, style: regular14TextStyle),
        ],
      ),
    );
  }

  _productInfo({required String imgPath, required String title, required String type, required String clock, required String date}){
    return Container(
      width: double.infinity,
      height: 160,
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
              imgPath == "" ?
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  border: Border.all(color: gray_999Color),
                ),
                child: Center(
                  child: SvgPicture.asset(
                    "assets/icons/header_title_logo.svg",
                    height: 10,
                  ),
                ),
              ):
              Container(
                width: 72,
                height: 72,
                child: ExtendedImage.network(
                  BaseApiService.imageApi+imgPath,
                  fit: BoxFit.cover,
                  width: double.infinity,
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

  _status({required String title, required String date, required String time, required bool isNext, required bool checked}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  width: 24,
                  height: 24,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: checked ? whitePrimaryColor : gray_F2F5F6Color,
                  ),
                  child: Center(
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: checked ? primaryColor : Colors.transparent,
                      ),
                    ),
                  ),
                ),
                isNext ?
                Container(
                  width: 1,
                  height: 24,
                  color: gray_F2F5F6Color,
                ): Container(),
              ],
            ),
            const SizedBox(width: 17),
            Text(title, style: medium14TextStyle),
          ],
        ),
        checked ? Row(
          children: [
            Text(
              date,
              style: regular14TextStyle,
            ),
            const SizedBox(width: 8),
            Container(width: 1, height: 12, color: gray_999Color),
            const SizedBox(width: 8),
            Text(
              time,
              style: regular14TextStyle,
            ),
          ],
        ) : Container(),
      ],
    );
  }
}
