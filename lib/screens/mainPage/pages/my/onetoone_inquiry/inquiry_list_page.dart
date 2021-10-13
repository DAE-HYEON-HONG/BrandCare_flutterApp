import 'package:brandcare_mobile_flutter_v2/consts/box_shadow.dart';
import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/inquiry_controller.dart';
import 'package:brandcare_mobile_flutter_v2/utils/date_format_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_expansion_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class InquiryListPage extends StatelessWidget {
  InquiryController controller = Get.find<InquiryController>();
  @override
  Widget build(BuildContext context) {
    return Container(
      color: gray_F1F3F5Color,
      child: ListView.builder(
        itemBuilder: (context, idx) {
          return Padding(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 24, top: idx == 0 ? 24 : 0),
            child: _item(
              controller.inquiryList![idx].createdDate,
              controller.inquiryList![idx].title,
              controller.inquiryList![idx].content,
              controller.inquiryList?[idx].answer ?? "",
            ),
          );
        },
        itemCount: controller.inquiryList!.length,
        shrinkWrap: true,
      ),
    );
  }
  Widget _item(String time, String title, String contents, String answer){
    return Container(
      decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          defaultBoxShadow
        ]
      ),
      padding: const EdgeInsets.only(left: 6, right: 8, top: 2, bottom: 2),
      child: CustomExpantionTile2(
        isShowShadow: false,
        title: Container(
          height: 72,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                DateFormatUtil.convertDateFormat(date: time, format: "MM.dd hh:mm a"),
                style: regular12TextStyle.copyWith(color: gray_999Color),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                title,
                style: medium14TextStyle,
              )
            ],
          ),
        ),
        child: Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, right: 16, bottom: 16),
                child: Text(contents,
                    style: regular14TextStyle.copyWith(color: gray_666Color),),
              ),
              Divider(
                height: 0,
                thickness: 1,
                color: gray_F5F6F7Color,
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset('assets/icons/reply.svg'),
                    const SizedBox(width: 12,),
                    Flexible(
                      child: Text(
                        answer == "" ? "답변을 기다리는 중이에요." : answer,
                        style: regular14TextStyle.copyWith(color: gray_666Color),),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
        
      ),
    );
  }
}
