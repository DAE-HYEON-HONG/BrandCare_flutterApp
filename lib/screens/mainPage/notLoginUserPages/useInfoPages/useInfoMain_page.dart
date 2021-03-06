import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/global_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/notLoginPagesControllers/useInfoControllers/useInfoMain_controller.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/notLoginUserPages/useInfoPages/useInfoDelivery_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/notLoginUserPages/useInfoPages/useInfoDescription_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/notLoginUserPages/useInfoPages/useInfoPrice_page.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/default_appbar_scaffold.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class UseInfoMainPage extends GetView<UseInfoMainController> {

  GlobalController _globalController = Get.find<GlobalController>();
  @override
  Widget build(BuildContext context) {
    controller.currentPageIdx.value = Get.arguments['index'] ?? 0;
    return Obx(() =>DefaultAppBarScaffold(
      title: controller.currentAppBarTitle.value,
      child: _body(),
    ));
  }
  //바디 부분
  _body() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: const EdgeInsets.only(left: 16, right: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              const SizedBox(height: 32),
              Container(
                width: double.infinity,
                height: 99,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(12),
                  color: whiteColor,
                  boxShadow: [
                    BoxShadow(
                      offset: Offset(0, 2),
                      color: Color.fromRGBO(0, 0, 0, 0.08),
                      blurRadius: 8.0,
                    ),
                  ],
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    _useInfomation(0, "price_list_on.svg", "가격표"),
                    _useInfomation(1, "howtouse_on.svg", "이용방법"),
                    _useInfomation(2, "delivery_on.svg", "택배 유의사항"),
                    _useInfomation(3, "event_on.svg", "이벤트"),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              Divider(height: 1, color: gray_f5f6f7Color),
              const SizedBox(height: 8),
              Container(
                child: controller.widgetOptions.elementAt(controller.currentPageIdx.value),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _useInfomation(int idx, String imgAdds, String title) {
    return Expanded(
      child: GestureDetector(
        onTap: () {
          if(!_globalController.isLogin.value && idx == 0){
            Get.toNamed('/notLoginPage');
          } else controller.changeWidget(idx, title);
        },
        child: Column(
          mainAxisSize: MainAxisSize.max,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              'assets/icons/$imgAdds',
              height: 40.h,
              color: controller.currentPageIdx.value == idx ? primaryColor : gray_8E8F95Color,
            ),
            // Image.asset(
            //   'assets/icons/$imgAdds',
            //   height: 40.h,
            // ),
            Text(
              title,
              style: regular12TextStyle.copyWith(
                color: controller.currentPageIdx.value == idx ? primaryColor : gray_8E8F95Color,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
