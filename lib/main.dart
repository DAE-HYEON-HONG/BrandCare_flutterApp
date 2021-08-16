import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/global_controller.dart';
import 'package:brandcare_mobile_flutter_v2/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 640),
      builder: () => GetMaterialApp(
        title: 'Brand Care',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          tabBarTheme: TabBarTheme(
            indicator: UnderlineTabIndicator(
              borderSide: BorderSide(
                color: primaryColor,
                width: 4.0
              )
            ),
            labelColor: primaryColor,
            unselectedLabelColor: gray_999Color,
            labelStyle: medium14TextStyle,
            unselectedLabelStyle: medium14TextStyle,
          )
        ),
        initialRoute: '/splash',
        getPages: [...routes],
        onInit: (){
          Get.put(GlobalController());
        },
      ),
    );
  }
}
