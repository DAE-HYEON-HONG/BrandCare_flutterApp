import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class DefaultAppBarScaffold extends StatelessWidget {
  const DefaultAppBarScaffold({Key? key, required this.title, required this.child,
  this.isLeadingShow = true
  }) : super(key: key);

  final String title;
  final Widget child;

  final bool isLeadingShow;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: whiteColor,
      appBar: AppBar(
        leading: isLeadingShow ? GestureDetector(
          behavior: HitTestBehavior.translucent,
          onTap: (){
            Get.back();
          },
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: SvgPicture.asset('assets/icons/btn_arrow_left.svg', width: 24, height: 24,),
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
      ),
      body: child,
    );
  }
}
