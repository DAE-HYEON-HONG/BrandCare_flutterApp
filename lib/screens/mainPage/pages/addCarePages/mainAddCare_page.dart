import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/addCareControllers/mainAddCare_controller.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/button/custom_button_empty_background_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_chk_address.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_form_submit.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/form_input_otherTitle_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/form_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:kpostal/kpostal.dart';

class MainAddCarePage extends StatelessWidget {
  final MainAddCareController controller = Get.put(MainAddCareController());

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: _appBar(),
        body: _renderBody(),
      ),
    );
  }

  //앱바 부분
  _appBar() {
    return AppBar(
      leading: GestureDetector(
        behavior: HitTestBehavior.translucent,
        onTap: (){},
        child: Container(),
      ),
      title: Text("케어/수선 신청", style: medium16TextStyle.copyWith(color: primaryColor)),
      titleSpacing: 0,
      centerTitle: true,
      titleTextStyle: medium16TextStyle.copyWith(color: primaryColor),
      backgroundColor: whiteColor,
      elevation: 4,
      shadowColor: blackColor.withOpacity(0.05),
      automaticallyImplyLeading: false,
    );
  }

  _renderBody(){
    return Container(
      width: double.infinity,
      height: double.infinity,
      color: whiteColor,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              //보내는 분
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32),
                  FormInputWidget(
                    onChange: (value) {},
                    onSubmit: (value) {},
                    controller: controller.senderName,
                    isShowTitle: true,
                    title: "보내는 분",
                    hint: "이름을 입력해주세요.",
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: FormInputWidget(
                          onChange: (value) {
                            controller.senderPhTxt.value = controller.senderPhNum.text;
                          },
                          onSubmit: (value) {},
                          controller: controller.senderPhNum,
                          isShowTitle: true,
                          title: "전화번호",
                          hint: "전화번호를 입력하세요.",
                          textInputType: TextInputType.number,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Obx(() => _authBtn(
                        onTap: () async  => await controller.smsAuth(),
                        fill: controller.senderPhNumFill.value,
                        title: '인증번호 받기',
                      )),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: FormInputTitleWidget(
                          onChange: (value) {},
                          onSubmit: (value) {},
                          controller: controller.senderName,
                          isShowTitle: true,
                          title: Row(
                            children: [
                              Text(
                                "인증번호",
                                style: regular14TextStyle,
                              ),
                              const SizedBox(width: 16),
                              Text(
                                "3:00",
                                style: regular14TextStyle.copyWith(color: redColor),
                              ),
                            ],
                          ),
                          hint: "전화번호를 입력하세요.",
                        ),
                      ),
                      const SizedBox(width: 8),
                      Container(
                        width: 120,
                        child: CustomButtonEmptyBackgroundWidget(
                          title: '인증확인',
                          onClick: () => controller.smsAuthChk(),
                          radius: 5,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  CustomChkAddress(
                    onTap: (){},
                    title: '기본주소로 입력 하시겠습니까?',
                    postCode: '10587',
                    address: "경기도 고양시 덕양구 덕수천 1로 삼송마을 18단지",
                    detail: "1807동 1101호",
                    isChecked: false,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: FormInputWidget(
                          readOnly: true,
                          onChange: (value) => controller.senderPostSaveChk(),
                          onSubmit: (value) => controller.senderPostSaveChk(),
                          controller: controller.senderPostCode,
                          hint: "주소를 검색하세요.",
                          isShowTitle: true,
                          title: "주소",
                        ),
                      ),
                      const SizedBox(width: 8),
                      _searchPost(
                        onTap: () => controller.senderPostSaveChk(),
                        search: true,
                        title: '주소검색',
                        type: "sender"
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  FormInputWidget(
                    readOnly: true,
                    onChange: (value) => controller.senderPostSaveChk(),
                    onSubmit: (value) => controller.senderPostSaveChk(),
                    controller: controller.senderAddress,
                    hint: "주소를 입력하세요.",
                  ),
                  const SizedBox(height: 8),
                  FormInputWidget(
                    onChange: (value) => controller.senderPostSaveChk(),
                    onSubmit: (value) => controller.senderPostSaveChk(),
                    controller: controller.senderAddressDetail,
                    hint: "나머지 주소를 입력해주세요.",
                  ),
                  const SizedBox(height: 8),
                  Obx(() => Container(
                    child: controller.saveSenderPost.value ?
                    CustomChkAddress(
                      onTap: (){},
                      title: '위 주소를 마이페이지에 등록하시겠습니까?',
                      postCode: controller.senderPostCode.text,
                      address: controller.senderAddress.text,
                      detail: controller.senderAddressDetail.text,
                      isChecked: false,
                    ):
                    Container(),
                  )),
                ],
              ),
              //받는 분
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 32),
                  FormInputTitleWidget(
                    onChange: (value) {},
                    onSubmit: (value) {},
                    controller: controller.receiverName,
                    isShowTitle: true,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("받는 분", style: medium14TextStyle),
                        Row(
                          children: [
                            SvgPicture.asset(
                              controller.samePost.value ?
                              "assets/icons/check_on.svg" : "assets/icons/check_off.svg",
                              height: 20,
                            ),
                            const SizedBox(width: 2),
                            Text("보내는 분과 동일", style: medium14TextStyle),
                          ],
                        ),
                      ],
                    ),
                    hint: "이름을 입력해주세요.",
                  ),
                  const SizedBox(height: 16),
                  FormInputWidget(
                    onChange: (value) {},
                    onSubmit: (value) {},
                    controller: controller.senderName,
                    isShowTitle: true,
                    title: "전화번호",
                    hint: "전화번호를 입력하세요.",
                    textInputType: TextInputType.number,
                  ),
                  const SizedBox(height: 24),
                  CustomChkAddress(
                    onTap: (){},
                    title: '기본주소로 입력 하시겠습니까?',
                    postCode: '10587',
                    address: "경기도 고양시 덕양구 덕수천 1로 삼송마을 18단지",
                    detail: "1807동 1101호",
                    isChecked: false,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Expanded(
                        child: FormInputWidget(
                          readOnly: true,
                          onChange: (value) => controller.receiverPostSaveChk(),
                          onSubmit: (value) => controller.receiverPostSaveChk(),
                          controller: controller.receiverPostCode,
                          hint: "주소를 검색하세요.",
                          isShowTitle: true,
                          title: "주소",
                        ),
                      ),
                      const SizedBox(width: 8),
                      _searchPost(
                        onTap: () => controller.receiverPostSaveChk(),
                        search: true,
                        title: '주소검색',
                        type: "receiver"
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  FormInputWidget(
                    readOnly: true,
                    onChange: (value) => controller.receiverPostSaveChk(),
                    onSubmit: (value) => controller.receiverPostSaveChk(),
                    controller: controller.receiverAddress,
                    hint: "주소를 입력하세요.",
                  ),
                  const SizedBox(height: 8),
                  FormInputWidget(
                    onChange: (value) => controller.senderPostSaveChk(),
                    onSubmit: (value) => controller.senderPostSaveChk(),
                    controller: controller.receiverAddressDetail,
                    hint: "나머지 주소를 입력해주세요.",
                  ),
                  const SizedBox(height: 8),
                  Obx(() => Container(
                    child: controller.saveReceiverPost.value ?
                    CustomChkAddress(
                      onTap: (){},
                      title: '위 주소를 마이페이지에 등록하시겠습니까?',
                      postCode: controller.receiverPostCode.text,
                      address: controller.receiverAddress.text,
                      detail: controller.receiverAddressDetail.text,
                      isChecked: controller.saveReceiverPostChk.value,
                    ):
                    Container(),
                  )),
                ],
              ),
              const SizedBox(height: 16),
              Text("택배 반송 주소", style: regular14TextStyle),
              const SizedBox(height: 9),
              Row(
                children: [
                  _postSendChoiceBtn(
                    onTap: () {},
                    fill: false,
                    title: "보내는 분",
                  ),
                  const SizedBox(width: 47),
                  _postSendChoiceBtn(
                    onTap: () {},
                    fill: true,
                    title: "받는 분",
                  ),
                ],
              ),
              const SizedBox(height: 25),
              CustomFormSubmit(
                title: "다음",
                onTab: () => controller.nextLevel(),
                fill: false,
              ),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  _postSendChoiceBtn({required Function onTap, required bool fill, required String title}){
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            border: Border.all(width: 1, color: primaryColor),
            color: fill ? primaryColor : whiteColor,
          ),
        ),
        const SizedBox(width: 8),
        Text(title, style: regular14TextStyle.copyWith(color: gray_666Color)),
      ],
    );
  }

  _searchPost({required Function onTap, required bool search, required String title, required String type}){
    return GestureDetector(
      onTap: () {
        if(search){
          print("실행됨");
          Get.to(KpostalView(
            callback: (Kpostal result){
              if (type == "sender"){
                controller.changeSenderPost(result.postCode, result.address);
              }else{
                controller.changeReceiverPost(result.postCode, result.address);
              }
              onTap();
            },
          ));
        }
      },
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 13, bottom: 13),
        decoration: BoxDecoration(
          border: Border.all(color: primaryColor),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          title,
          style: regular14TextStyle.copyWith(
            color: primaryColor,
          ),
        ),
      ),
    );
  }

  _authBtn({required Function onTap, required bool fill, required String title}){
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
        padding: const EdgeInsets.only(left: 20, right: 20, top: 13, bottom: 13),
        decoration: BoxDecoration(
          color: fill ? primaryColor : whiteColor,
          border: Border.all(color: fill ? primaryColor : gray_999Color),
          borderRadius: BorderRadius.circular(4),
        ),
        child: Text(
          title,
          style: regular14TextStyle.copyWith(
            color: fill ? whiteColor : gray_999Color,
          ),
        ),
      ),
    );
  }
}
