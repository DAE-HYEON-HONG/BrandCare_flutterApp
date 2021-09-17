import 'package:brandcare_mobile_flutter_v2/controllers/global_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/my_controller.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/button/custom_button_onoff_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/form_input_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class NameChangePage extends StatelessWidget {
  const NameChangePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final myController = Get.find<MyController>();
    final globalCtrl = Get.find<GlobalController>();
    return DefaultAppBarScaffold(
        title: '이름(닉네임) 변경',
        child: SafeArea(
          child: Column(
            children: [
              const SizedBox(height: 32,),
              GetBuilder<MyController>(builder: (_) => Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: FormInputWidget(
                  onChange: (value) {},
                  onSubmit: (value) {},
                  controller: TextEditingController(),
                  isShowTitle: true,
                  hint: myController.myProfileInfoModel?.nickName,
                  title: '현재 이름(닉네임)',
                  readOnly: true,
                ),
              )),
              const SizedBox(height: 24,),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: FormInputWidget(
                  onChange: (value) {
                    myController.name.value = value;
                  },
                  onSubmit: (value) {},
                  controller: myController.nickNameController,
                  isShowTitle: true,
                  title: '변경할 이름(닉네임)',
                ),
              ),
              const Spacer(),
              if(MediaQuery.of(context).viewInsets.bottom == 0)
              GetBuilder<MyController>(builder: (_) =>CustomButtonOnOffWidget(
                  title: '확인',
                  onClick: () async => await myController.changeNickName(myController.nickNameController.text),
                  isOn: myController.changeColor(),
              )),
            ],
          ),
        ));
  }
}
