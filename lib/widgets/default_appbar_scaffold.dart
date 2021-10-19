import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import 'custom_dialog_widget.dart';

class DefaultAppBarScaffold extends StatelessWidget {
  DefaultAppBarScaffold({Key? key, required this.title, required this.child,
  this.isLeadingShow = true, this.actions, this.backButtonDialog = false, this.backButtonDialogText = ''
  }) : super(key: key);

  final String title;
  final Widget child;
  final bool? backButtonDialog;
  final String? backButtonDialogText;

  final bool isLeadingShow;
  final List<Widget>? actions;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      //resizeToAvoidBottomInset: false,
      backgroundColor: whiteColor,
      appBar: AppBar(
        leading: isLeadingShow ? GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: (){
            if(backButtonDialog!){
              Get.dialog(CustomDialogWidget(
                isSingleButton: false,
                content: backButtonDialogText!,
                okTxt: '확인',
                cancelTxt: '취소',
                onClick: () {
                  Get.back();
                  Get.back();

                },
                onCancelClick: () {
                  Get.back();
                },
              ));
            }else{
              Get.back();
            }
          },
          child: Padding(
            padding: const EdgeInsets.all(18.0),
            child: SvgPicture.asset('assets/icons/btn_arrow_left.svg', width: 18, height: 18,),
          ),
        ) : null,

        title: Text(title,style: medium16TextStyle.copyWith(color: primaryColor)),
        titleSpacing: 0,
        centerTitle: true,
        titleTextStyle: medium16TextStyle.copyWith(color: primaryColor),
        backgroundColor: whiteColor,
        elevation: 4,
        shadowColor: blackColor.withOpacity(0.05),
        automaticallyImplyLeading: false,
        actions: this.actions,
      ),
      body: child,
    );
  }
}
