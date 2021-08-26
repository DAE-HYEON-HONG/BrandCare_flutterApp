import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/global_controller.dart';
import 'package:brandcare_mobile_flutter_v2/routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/all.dart';

void main() {
  KakaoContext.clientId = "24d578e5ec7cbcf97fe904e7b11a0ecd";
  KakaoContext.javascriptClientId = "9d475981d18440ea00a275bc035dcacf";
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 640),
      builder: () => Builder(
        builder: (context) {
          return GestureDetector(
            behavior: HitTestBehavior.translucent,
            onTap: (){
              print('ontab ');
              var currentFocus = FocusScope.of(context);
              if (!currentFocus.hasPrimaryFocus) {
                currentFocus.unfocus();
                FocusScope.of(context).requestFocus(FocusNode());
              }
            },
            child: GetMaterialApp(
              builder: EasyLoading.init(),
              title: 'Brand Care',
              debugShowCheckedModeBanner: false,
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
                  ),
                dividerColor: gray_F1F3F5Color,
              ),
              initialRoute: '/splash',
              getPages: [...routes],
              onInit: (){
                Get.put(GlobalController());
              },
            ),
          );
        },
      ),
    );
  }
}
