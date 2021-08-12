import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDialogWidget extends StatelessWidget {
  final String? title;
  final String content;
  final bool isSingleButton;
  final Function() onClick;

  const CustomDialogWidget({Key? key, this.title, required this.content, this.isSingleButton=true, required this.onClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          if(title != null)
            Padding(
              child: Text(
                title!,
                style: medium14TextStyle,
              ),
              padding: const EdgeInsets.only(top: 40),
            ),

          Padding(
            padding: EdgeInsets.only(top: (title == null) ? 32.0 : 12.0),
            child: Text(content, style: regular14TextStyle, textAlign: TextAlign.center,),
          ),
          const SizedBox(height: 23,),
          const Divider(color: primaryColor, height: 0, thickness: 1,),
          if(isSingleButton)
            InkWell(
              onTap: onClick,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 10),
                width: double.infinity,
                child: Center(
                  child: Text('확인', style: medium14TextStyle.copyWith(color: primaryColor),),
                ),
              ),
            )
          else
            Row(
               children: [
                Flexible(
                  fit: FlexFit.tight,
                  child: InkWell(
                    onTap: onClick,
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      width: double.infinity,
                      child: Center(
                        child: Text('예', style: medium14TextStyle.copyWith(color: primaryColor),),
                      ),
                    ),
                  )
                ),
                 Flexible(
                     fit: FlexFit.tight,
                     child: InkWell(
                       onTap: (){Get.back();},
                       child: Container(
                         color: gray_EAColor,
                         padding: const EdgeInsets.symmetric(vertical: 10),
                         width: double.infinity,
                         child: Center(
                           child: Text('아니오', style: medium14TextStyle.copyWith(color: primaryColor),),
                         ),
                       ),
                     )
                 ),
               ],
              ),
        ],
      ),
    );
  }
}
