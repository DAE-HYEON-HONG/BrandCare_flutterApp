import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/addCareControllers/mainAddCare_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/mainPage_controller.dart';
import 'package:brandcare_mobile_flutter_v2/utils/date_format_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/button/custom_button_empty_background_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/button/custom_button_onoff_widget.dart';
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
        body: _renderBody(context),
      ),
    );
  }

  //앱바 부분
  _appBar() {
    final mainPageCtrl = Get.find<MainPageController>();
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
      actions: [
        GestureDetector(
          onTap: (){
            mainPageCtrl.onItemTaped(5);
          },
          child: SvgPicture.asset('assets/icons/mainNotice.svg', height: 19,),
        ),
        const SizedBox(width: 16),
      ],
    );
  }

  _renderBody(BuildContext context){
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
                    onChange: (value) {
                      controller.chkFill();
                    },
                    onSubmit: (value) {},
                    controller: controller.senderName,
                    isShowTitle: true,
                    title: "보내는 분",
                    hint: "이름을 입력해주세요.",
                  ),
                  const SizedBox(height: 16),
                  _itemPhoneInput(),
                  const SizedBox(height: 16),
                  Obx(() => _itemAuthNumber(context)),
                  const SizedBox(height: 24),
                   if(controller.globalCtrl.userInfoModel != null && controller.globalCtrl.userInfoModel!.address != null)
                     Obx(() =>CustomChkAddress(
                       onTap: () => controller.senderNormalAddressSet(),
                       title: '기본주소로 입력 하시겠습니까?',
                       postCode: controller.globalCtrl.userInfoModel!.address!.zipCode,
                       address: controller.globalCtrl.userInfoModel!.address!
                           .city,
                       detail: controller.globalCtrl.userInfoModel!.address!
                           .street,
                       isChecked: controller.senderNormalAddress.value,
                     )),
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
                  Obx(() => FormInputWidget(
                    readOnly: controller.senderNormalAddress.value,
                    onChange: (value) {
                      controller.senderAddressDetail.value = controller.senderAddressDetailCtrl.text;
                    },
                    onSubmit: (value) => controller.senderPostSaveChk(),
                    controller: controller.senderAddressDetailCtrl,
                    hint: "나머지 주소를 입력해주세요.",
                  )),
                  const SizedBox(height: 8),
                  Obx(() => Container(
                    child: controller.saveSenderPostChk.value ?
                    CustomChkAddress(
                      onTap: () => controller.senderPostSave(),
                      title: '위 주소를 마이페이지에 등록하시겠습니까?',
                      postCode: controller.senderPostCode.text,
                      address: controller.senderAddress.text,
                      detail: controller.senderAddressDetail.value,
                      isChecked: controller.senderPostSet.value,
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
                    onChange: (value) {controller.chkFill();},
                    onSubmit: (value) {},
                    controller: controller.receiverName,
                    isShowTitle: true,
                    title: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("받는 분", style: medium14TextStyle),
                        Obx(() => GestureDetector(
                          onTap: () => controller.receiverSamePost(),
                          child: Row(
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
                        )),
                      ],
                    ),
                    hint: "이름을 입력해주세요.",
                  ),
                  const SizedBox(height: 16),
                  FormInputWidget(
                    onChange: (value) {controller.chkFill();},
                    onSubmit: (value) {},
                    controller: controller.receiverPhNum,
                    isShowTitle: true,
                    title: "전화번호",
                    hint: "전화번호를 입력하세요.",
                    textInputType: TextInputType.number,
                  ),
                  const SizedBox(height: 24),
                  Obx(() => Column(
                    children: [
                      controller.samePost.value ? Container():
                      Column(
                        children: [
                          if(controller.globalCtrl.userInfoModel != null && controller.globalCtrl.userInfoModel!.address != null)
                            Obx(() =>CustomChkAddress(
                              onTap: () => controller.receiverNormalAddressSet(),
                              title: '기본주소로 입력 하시겠습니까?',
                              postCode: controller.globalCtrl.userInfoModel!.address!.zipCode,
                              address: controller.globalCtrl.userInfoModel!.address!
                                  .city,
                              detail: controller.globalCtrl.userInfoModel!.address!
                                  .street,
                              isChecked: controller.receiverNormalAddress.value,
                            )),
                        ],
                      ),
                    ],
                  )),
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
                  Obx(() => FormInputWidget(
                    readOnly: controller.receiverNormalAddress.value,
                    onChange: (value) {
                      controller.receiverAddressDetail.value = controller.receiverAddressDetailCtrl.text;
                      controller.chkFill();
                    },
                    onSubmit: (value) => controller.receiverPostSaveChk(),
                    controller: controller.receiverAddressDetailCtrl,
                    hint: "나머지 주소를 입력해주세요.",
                  )),
                  const SizedBox(height: 8),
                  Obx(() => Container(
                    child: controller.saveReceiverPostChk.value ?
                    CustomChkAddress(
                      onTap: () => controller.receiverPostSave(),
                      title: '위 주소를 마이페이지에 등록하시겠습니까?',
                      postCode: controller.receiverPostCode.text,
                      address: controller.receiverAddress.text,
                      detail: controller.receiverAddressDetail.value,
                      isChecked: controller.receiverPostSet.value,
                    ):
                    Container(),
                  )),
                ],
              ),
              const SizedBox(height: 16),
              Text("택배 반송 주소", style: regular14TextStyle),
              const SizedBox(height: 9),
              Obx(() => Row(
                children: [
                  GestureDetector(
                    onTap: () => controller.changeReturnPost("sender"),
                    child: _postSendChoiceBtn(
                      fill: controller.returnSender.value,
                      title: "보내는 분",
                    ),
                  ),
                  const SizedBox(width: 47),
                  GestureDetector(
                    onTap: () => controller.changeReturnPost("receiver"),
                    child: _postSendChoiceBtn(
                      fill: controller.returnReceiver.value,
                      title: "받는 분",
                    ),
                  ),
                ],
              )),
              const SizedBox(height: 25),
              Obx(() => CustomFormSubmit(
                title: "다음",
                onTab: () => controller.nextLevel(),
                fill: controller.nextFill.value,
              )),
              const SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }

  _postSendChoiceBtn({required bool fill, required String title}){
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
        if(!controller.senderNormalAddress.value || controller.samePost.value || !controller.receiverNormalAddress.value){
          if(search){
            Get.to(KpostalView(
              callback: (Kpostal result){
                if (type == "sender"){
                  controller.changeSenderPost(result.postCode, result.address);
                  controller.chkFill();
                }else{
                  controller.changeReceiverPost(result.postCode, result.address);
                  controller.chkFill();
                }
                onTap();
              },
            ));
          }
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

  Widget _itemPhoneInput() => Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
            margin: const EdgeInsets.only(bottom: 8),
            child: Text(
              '전화번호',
              style: medium14TextStyle,
            )),
        Row(

          children: [
            Flexible(
              flex: 3,
              child: TextFormField(
                readOnly: controller.phoneChecked.value ? true : false,
                controller: controller.senderPhNum,
                style: regular12TextStyle,
                keyboardType: TextInputType.phone,
                onChanged: (value) {
                  controller.senderPhTxt.value = controller.senderPhNum.text;
                  controller.chkFill();
                },
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.all(15),
                  hintText: '전화번호를 입력하세요.',
                  hintStyle:
                  regular12TextStyle.copyWith(color: gray_999Color),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(color: Color(0xffD5D7DB)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(color: primaryColor),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Obx(() => AnimatedContainer(
              duration: Duration(milliseconds: 500),
              // width: ((!controller.authCode.value ? 2 : 0 ) * (Get.width - 32)) / ((!controller.authCode.value ? 2:0) + 3),
              width: (2 * (Get.width - 32)) / (2 + 3),
              child: CustomButtonOnOffWidget(
                title: controller.phAuth != "" ? '재발송' : '인증번호 받기',
                onClick: () => controller.smsAuth(),
                isOn: controller.senderPhNumFill.value,
              ),
            )),
          ],
        ),
      ],
    ),
  );

  Widget _itemAuthNumber(BuildContext context) => Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Row(
          children: [
            Container(
                margin: const EdgeInsets.only(right: 16),
                child: Text(
                  '인증번호',
                  style: medium14TextStyle,
                )),
            if(!controller.phoneChecked.value)
              Obx(() => Text(
                '${DateFormatUtil.convertTimer(timer: controller.smsTime.value)}',
                style: medium14TextStyle.copyWith(color: redColor),
              ))
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        Row(
          children: [
            Flexible(
              flex: 2,
              child: TextFormField(
                controller: controller.authNum,
                style: regular12TextStyle,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  controller.authNumTxt.value = value;
                },
                decoration: InputDecoration(
                  isDense: true,
                  contentPadding: const EdgeInsets.all(15),
                  hintText: '인증번호를 입력하세요',
                  hintStyle: regular12TextStyle.copyWith(
                      color: gray_999Color),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(color: Color(0xffD5D7DB)),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(4),
                    borderSide: BorderSide(color: primaryColor),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 8,
            ),
            Flexible(
                flex: 1,
                child: Obx(() => CustomButtonOnOffWidget(
                    title: '인증확인',
                    onClick: () {
                      controller.smsAuthChk();
                    },
                    isOn: controller.authNumFill.value)))
          ],
        ),
        if(controller.phoneChecked.value)
          Text(
            '인증되었습니다.',
            style: medium14TextStyle.copyWith(color: Color(0xff169F00)),
            textAlign: TextAlign.start,
          ),
      ],
    ),
  );
}
