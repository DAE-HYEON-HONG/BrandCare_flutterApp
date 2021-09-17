import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/global_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/my_controller.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/button/custom_button_empty_background_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/button/custom_button_onoff_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/form_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:kpostal/kpostal.dart';

class AddressChangePage extends StatelessWidget {
  AddressChangePage({Key? key}) : super(key: key);

  final myController = Get.find<MyController>();
  final globalCtrl = Get.find<GlobalController>();

  @override
  Widget build(BuildContext context) {
    //myController.initMyController();
    if(globalCtrl.userInfoModel?.address == null){
      return DefaultAppBarScaffold(title: '주소 등록 / 변경', child: _renderRegisterAddress(context));
    }else{
      return DefaultAppBarScaffold(title: '주소 등록 / 변경', child: _renderChangeAddress(context));
    }

  }

  Widget _changeAddress(String title) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Row(
              children: [
                Flexible(
                  flex: 3,
                  child: FormInputWidget(
                    onChange: (value) {
                    },
                    onSubmit: (value) {},
                    controller: myController.postCodeController,
                    isShowTitle: true,
                    title: title,
                    hint: '우편번호',
                    readOnly: true,
                  ),
                ),
                Flexible(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 8.0, left: 8.0),
                    child: Column(
                      children: [
                        Text(
                          '',
                          style: medium14TextStyle,
                        ),
                        CustomButtonEmptyBackgroundWidget(
                          radius: 4,
                            title: '주소검색', onClick: () async {
                            print(123);
                            await Get.to(() => KpostalView(
                              callback: (Kpostal result){
                                print(result.address);
                                myController.addressController.text = result.address;
                                myController.city.value = result.sido;
                                myController.sigungu.value = result.sigungu;
                                myController.street.value = result.roadAddress;
                                myController.address.value = result.address;
                                myController.postCodeController.text = result.postCode;
                                myController.postcode.value = result.postCode;
                              },
                            ));
                        }),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 12,
            ),
            FormInputWidget(
              onChange: (value) {
              },
              onSubmit: (value) {},
              controller: myController.addressController,
              hint: '주소를 검색하세요.',
            ),
            const SizedBox(
              height: 12,
            ),
            FormInputWidget(
              onChange: (value) {
                print('change detai');
                myController.detailAddress.value = value;
              },
              onSubmit: (value) {},
              controller: myController.addressDetailController,
              hint: '나머지 주소를 입력해주세요.',
            ),
          ],
        ),
      );
  
  Widget _renderRegisterAddress(context) => Container(
    child: Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                _changeAddress('등록할 주소'),
              ],
            ),
          ),
        ),
        if(MediaQuery.of(context).viewInsets.bottom == 0)
          Positioned(
                left: 0,
                right: 0,
                bottom: 0,
                child: Obx(() => CustomButtonOnOffWidget(
                      title: '확인',
                      onClick: () async {
                        await myController.changeAddress(context);
                      },
                      isOn: myController.isAddress
                )),
          ),
      ],
    ),
  );

  Widget _renderChangeAddress(context) => Container(
    child: Stack(
      children: [
        Container(
          width: double.infinity,
          height: double.infinity,
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: FormInputWidget(
                    onChange: (value) {},
                    onSubmit: (value) {},
                    controller: TextEditingController(),
                    isShowTitle: true,
                    title: '현재 주소',
                    hint: '${globalCtrl.userInfoModel?.address?.city}',
                    readOnly: true,
                  ),
                ),
                const SizedBox(height: 12,),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: FormInputWidget(
                    onChange: (value) {},
                    onSubmit: (value) {},
                    controller: TextEditingController(),
                    hint: '${globalCtrl.userInfoModel?.address?.street}',
                    readOnly: true,
                  ),
                ),
                const SizedBox(height: 32,),
                _changeAddress('변경할 주소'),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
        if(MediaQuery.of(context).viewInsets.bottom == 0)
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Obx(() =>CustomButtonOnOffWidget(
            title: '확인',
            onClick: () async => await myController.changeAddress(context),
            isOn: myController.isAddress,
          )),
        )
      ],
    ),
  );
}
