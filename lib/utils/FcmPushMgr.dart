import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/global_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/notice/main_notice_controller.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/notice/main_notice_page.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:app_settings/app_settings.dart';
import 'package:flutter/material.dart';
import 'dart:io';

import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';

class FcmPushMgr {
  static final FcmPushMgr _mgr = new FcmPushMgr._internal();
  final _firebaseMsg = FirebaseMessaging.instance;
  final GlobalController globalCtrl = Get.find<GlobalController>();

  factory FcmPushMgr() {
    return _mgr;
  }

  FcmPushMgr._internal() {
    //return
  }

  Future<void> reqPermission() async{
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

    Future<String> regToken() async{
    // await _reqPermission();
    String fcmToken = "";
    await _firebaseMsg.getToken().then((token) => {
      print("FCM토큰 : $token"),
      fcmToken = token!
    });
    _localNotiSetting();
    return fcmToken;
  }

  void listenFCM() {
    FirebaseMessaging.onMessage.listen((RemoteMessage message) { 
      print("실행 상태에서 문자 받음");
      print("data : ${message.data.toString()}");
      print(message.notification!.title);
      print(message.notification!.body);
      showNotification(message);
    });
  }

  Future<void> listenBackgroundMessage(RemoteMessage msg) async{
    print("백그라운드 상태에서 문자 받음");
    print("data : ${msg.data}");
    print(msg.messageId);
    print(msg.notification!.title);
  }

  Future<void> showNotification(RemoteMessage message) async {
    String title, body;
    if(Platform.isAndroid){
      title = message.notification!.title!;
      body = message.notification!.body!;
    }else {
      title = message.notification!.title!;
      body = message.notification!.body!;
    }
    if(Platform.isIOS){
      Get.snackbar(
        title, body,
        snackPosition: SnackPosition.TOP,
        duration: const Duration(milliseconds: 3000),
        backgroundColor: whiteColor.withOpacity(0.9),
        colorText: Colors.black,
        onTap: (snack) {
          if(globalCtrl.isLogin.value){
            MainNoticeController notiCtrl = Get.find<MainNoticeController>();
            notiCtrl.type = "fcm";
            notiCtrl.update();
            Get.to(() => MainNoticePage());
          }
        }
      );
    }else{
      var androidNotiDetails = AndroidNotificationDetails(
          'dexterous.com.flutter.local_notifications',
          title, body, importance: Importance.max, priority: Priority.high,
      );
      var details = NotificationDetails(android: androidNotiDetails);
      await FlutterLocalNotificationsPlugin().show(0, title, body, details);
    }
  }

  Future<dynamic> onSeletcNotification(payload) async {
    if(globalCtrl.isLogin.value){
      MainNoticeController notiCtrl = Get.find<MainNoticeController>();
      notiCtrl.type = "fcm";
      notiCtrl.update();
      Get.to(() => MainNoticePage());
    }
  }

  void _localNotiSetting() async {
    var androidInitializationSettings =AndroidInitializationSettings('@mipmap/ic_launcher');

    var iOSInitializationSettings = IOSInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true);

    var initsetting = InitializationSettings(
        android: androidInitializationSettings, iOS: iOSInitializationSettings);

    await FlutterLocalNotificationsPlugin().initialize(initsetting, onSelectNotification: onSeletcNotification);
  }
}