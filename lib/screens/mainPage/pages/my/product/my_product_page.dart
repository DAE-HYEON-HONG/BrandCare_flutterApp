import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/my_product_controller.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/genuine_box_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

class MyProductPage extends GetView<MyProductController> {
  const MyProductPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultAppBarScaffold(
      title: '나의 제품 전체 보기',
      child: Container(
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 32, right: 16, bottom: 8),
              child: SvgPicture.asset('assets/icons/filter.svg'),
            ),
            const Divider(
              height: 0,
              thickness: 1,
            ),
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                  itemBuilder: (context, idx) => _item(idx),
                  separatorBuilder: (context, idx) => const Divider(height: 0, thickness: 1,),
                  itemCount: 10),
            )
          ],
        ),
      ),
    );
  }

  Widget _item(int idx) => Container(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Image.asset(
              'assets/icons/sample_product.png',
              width: 72,
              height: 72,
            ),
            const SizedBox(
              width: 32,
            ),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        '루이비통 | 가방',
                        style: regular12TextStyle.copyWith(color: gray_333Color),
                      ),
                      const Spacer(),
                      if(idx != 3)
                        GenuineBoxWidget(isGenuine: idx.isEven),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    '나의 에쁜이',
                    style: medium14TextStyle,
                  )
                ],
              ),
            )
          ],
        ),
      );
}
