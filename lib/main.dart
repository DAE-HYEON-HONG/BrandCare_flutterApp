import 'package:app_settings/app_settings.dart';
import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/consts/text_styles.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/global_controller.dart';
import 'package:brandcare_mobile_flutter_v2/routes.dart';
import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:kakao_flutter_sdk/all.dart';
import 'dart:io';
import 'package:dart_json_mapper/dart_json_mapper.dart' show JsonMapper, jsonSerializable, JsonProperty;
import 'main.mapper.g.dart' show initializeJsonMapper;

// Future<void> myBackgroundMessageHandler(RemoteMessage message) async {
//   await Firebase.initializeApp();
//   final dynamic data = message.data;
//   var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
//   String title, body;
//   title = message.notification!.title!;
//   body = message.notification!.body!;
// }

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Handling a background message");
}
Future<void> setFCMPermission() async {
  final _firebaseMsg = FirebaseMessaging.instance;
  NotificationSettings settings = await _firebaseMsg.requestPermission(
    sound: true,
    badge: true,
    alert: true,
    provisional: false,
  );
  if(settings.authorizationStatus == AuthorizationStatus.denied){
    AppSettings.openNotificationSettings();
  }
}
/*
29 ~ 43 FCM 추가부분
*/
void main() async{
  initializeJsonMapper();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await setFCMPermission();
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
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
