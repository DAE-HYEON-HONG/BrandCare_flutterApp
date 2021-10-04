import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/global_controller.dart';
import 'package:brandcare_mobile_flutter_v2/routes.dart';
import 'package:brandcare_mobile_flutter_v2/utils/FcmPushMgr.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_analytics/observer.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'dart:io';

Future<void> myBackgroundMessageHandler(RemoteMessage message) async {
  await Firebase.initializeApp();
  final dynamic data = message.data;
  var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  String title, body;
  title = message.notification!.title!;
  body = message.notification!.body!;

  var androidNotiDetails = AndroidNotificationDetails(
      'dexterous.com.flutter.local_notifications', title, body,
      importance: Importance.max, priority: Priority.max);
  var details = NotificationDetails(android: androidNotiDetails);
  await flutterLocalNotificationsPlugin.show(0, title, body, details);
}

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  KakaoContext.clientId = "20ebd93e838ea02863b6183bbb8f8b96";
  KakaoContext.javascriptClientId = "9d475981d18440ea00a275bc035dcacf";
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  FirebaseAnalytics analytics = FirebaseAnalytics();
  @override
  Widget build(BuildContext context) {
    // Platform.isIOS ?
    // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]) :
    // SystemChrome.setPreferredOrientations([DeviceOrientation.portraitDown]);
    if(Platform.isIOS) SystemChrome.setEnabledSystemUIOverlays([SystemUiOverlay.top]);
    Platform.isIOS ?
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark):
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.dark);
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
              navigatorObservers: [
                // FirebaseAnalyticsObserver(analytics: analytics),
              ],
              builder: EasyLoading.init(
                builder: (context, widget){
                  return MediaQuery(
                    data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
                    child: widget!,
                  );
                }
              ),
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
