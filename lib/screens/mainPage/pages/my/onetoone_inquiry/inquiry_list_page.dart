import 'package:brandcare_mobile_flutter_v2/consts/box_shadow.dart';
import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_expansion_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class InquiryListPage extends StatelessWidget {
  const InquiryListPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: gray_F1F3F5Color,
      child: ListView.builder(
        itemBuilder: (context, idx) {
          return Padding(
            padding: EdgeInsets.only(left: 16, right: 16, bottom: 24, top: idx == 0 ? 24 : 0),
            child: _item(),
          );
        },
        itemCount: 10,
        shrinkWrap: true,
      ),
    );
  }
  Widget _item(){
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
                '01.28 3:00a.m.',
                style: regular12TextStyle.copyWith(color: gray_999Color),
              ),
              const SizedBox(
                height: 4,
              ),
              Text(
                '케어 시간 변경 문의',
                style: medium14TextStyle,
              )
            ],
          ),
        ),
        child: Container(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Text('제품의 구매일, 장소, 구매 금액 등이 필요해요.정품 인증을 눌러 명품 인증을 받아보세요.',
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
                      child: Text('제품의 구매일, 장소, 구매 금액 등이 필요해요.정품 인증을 눌러 명품 인증을 받아보세요.',
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
