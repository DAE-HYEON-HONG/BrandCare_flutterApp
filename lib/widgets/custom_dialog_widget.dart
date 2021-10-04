import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CustomDialogWidget extends StatelessWidget {
  final String? title;
  final String content;
  final bool isSingleButton;
  final Function() onClick;
  final Function()? onCancelClick;
  final String okTxt;
  final String cancelTxt;

  const CustomDialogWidget({Key? key, this.title, required this.content, this.isSingleButton=true, required this.onClick, this.okTxt='예', this.cancelTxt='아니오', this.onCancelClick}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8.0)
      ),
      child: Container(
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(8.0),
      ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
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
              padding: EdgeInsets.only(top: (title == null) ? 32.0 : 12.0, left: 16, right: 16),
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
                mainAxisSize:MainAxisSize.min,
                 children: [
                  Flexible(
                    fit: FlexFit.tight,
                    child: GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onTap: onClick,
                      child: Container(
                        decoration: BoxDecoration(
                          color: whiteColor, 
                          borderRadius: BorderRadius.only(
                              bottomLeft: Radius.circular(8.0)
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        width: double.infinity,
                        child: Center(
                          child: Text('$okTxt', style: medium14TextStyle.copyWith(color: primaryColor),),
                        ),
                      ),
                    )
                  ),
                   Flexible(
                       fit: FlexFit.tight,
                       child: GestureDetector(
                         behavior: HitTestBehavior.translucent,
                         onTap: (){
                           if(onCancelClick != null) {
                             onCancelClick!();
                           }else {
                             Get.back();
                           }
                           },
                         child: Container(
                           decoration: BoxDecoration(
                             color: gray_EAColor,
                             borderRadius: BorderRadius.only(
                               bottomRight: Radius.circular(8.0)
                             )
                           ),
                           padding: const EdgeInsets.symmetric(vertical: 10),
                           width: double.infinity,
                           child: Center(
                             child: Text('$cancelTxt', style: medium14TextStyle.copyWith(color: primaryColor),),
                           ),
                         ),
                       )
                   ),
                 ],
                ),
          ],
        ),
      ),
    );
  }
}
