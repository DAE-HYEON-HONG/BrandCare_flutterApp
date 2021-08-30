import 'package:brandcare_mobile_flutter_v2/consts/box_shadow.dart';
import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/utils/number_format_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/form_input_widget.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/genuine_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class ProductInfoPage extends StatelessWidget {
  const ProductInfoPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultAppBarScaffold(title: '제품 정보', child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 32,),
            _item(),
            const SizedBox(height: 24,),
            FormInputWidget(onChange: (value){}, onSubmit: (value){}, controller: TextEditingController(text: '나의 예쁜이'),
            readOnly: true,
              title: '제품명',
              isShowTitle: true,
            ),
            const SizedBox(height: 24,),
            FormInputWidget(onChange: (value){}, onSubmit: (value){}, controller: TextEditingController(text: 'AAAA12313DVD'),
              readOnly: true,
              title: '일련번호',
              isShowTitle: true,
            ),
            const SizedBox(height: 24,),
            FormInputWidget(onChange: (value){}, onSubmit: (value){}, controller: TextEditingController(text: '21년 5월경'),
              readOnly: true,
              title: '구입시기',
              isShowTitle: true,
            ),
            const SizedBox(height: 24,),
            FormInputWidget(onChange: (value){}, onSubmit: (value){}, controller: TextEditingController(text: '${NumberFormatUtil.convertNumberFormat(number: 1000000000)}원'),
              readOnly: true,
              title: '구입금액',
              isShowTitle: true,
            ),
            const SizedBox(height: 24,),
            FormInputWidget(onChange: (value){}, onSubmit: (value){}, controller: TextEditingController(text: '가로수길'),
              readOnly: true,
              title: '구입경로',
              isShowTitle: true,
            ),
            const SizedBox(height: 24,),
            _gridPicture(),
            const SizedBox(height: 32,),
            Text('추가정보', style: medium14TextStyle,),
            const SizedBox(height: 17,),
            _productAddInfo('제품 컨디션', ['오염', '파손', '문제 없음']),
            const SizedBox(height: 30,),
            _productAddInfo('제품 구성품', ['더스트백', '보증서', '없음']),
            const SizedBox(height: 27,),
            _etc(),
            const SizedBox(height: 32,),
          ],
        ),
      ),
    ));
  }
  Widget _item() => Container(
    height: 104,
    padding: const EdgeInsets.all(16),
    decoration: BoxDecoration(
        color: whiteColor,
        borderRadius: BorderRadius.circular(12),
      boxShadow: [
        defaultBoxShadow,
      ]
    ),
    child: Row(
      children: [
        Image.asset('assets/icons/sample_product.png', width: 72, height: 72,),
        const SizedBox(width: 16,),
        Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('루이비통 | 가방', style: regular12TextStyle.copyWith(color: gray_333Color),),
                const SizedBox(width: 19,),
                GenuineBoxWidget(isGenuine: true),
              ],
            ),
            const SizedBox(height: 5,),
            Text('나의 예쁜이', style: medium14TextStyle,),
          ],
        )
      ],
    ),
  );

  Widget _gridPicture() => Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _pictureItem('정면 사진'),
            _pictureItem('뒷면 사진'),
          ],
        ),
        const SizedBox(height: 24,),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            _pictureItem('좌측면 사진'),
            _pictureItem('우측면 사진'),
          ],
        ),
      ],
    ),
  );

  Widget _pictureItem(String title) => Container(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: medium14TextStyle,),
        const SizedBox(height: 10,),
        Image.asset('assets/icons/sample_product.png', width: 160, height: 160,),
      ],
    ),
  );

  Widget _productAddInfo(String title, List<String> list) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: medium14TextStyle,),
        const SizedBox(height: 17,),
        Row(
          children: [
            ...list.map((e) => Flexible(
              child: Row(
                children: [
                  SvgPicture.asset('assets/icons/check_on.svg'),
                  const SizedBox(width: 8),
                  Text(e, style: medium12TextStyle,),
                ],
              ),
            )),
          ],
        )
      ],
    );
  }

  Widget _etc() => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      Text('기타', style: medium14TextStyle,),
      const SizedBox(height: 17,),
      TextField(
        controller: TextEditingController(text: '상태 좋음'),
        style: regular14TextStyle.copyWith(color: gray_999Color),
        maxLines: 8,
        decoration: InputDecoration(
          isDense: true,
          contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13.42),
          disabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: gray_D5D7DBColor),
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        enabled: false,
      )
    ],
  );
}
