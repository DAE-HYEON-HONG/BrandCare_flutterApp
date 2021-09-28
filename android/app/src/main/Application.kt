package com.laonstory.brand_care_app

import io.flutter.app.FlutterApplication
import io.flutter.plugin.common.PluginRegistry
import io.flutter.plugin.common.PluginRegistry.PluginRegistrantCallback
import io.flutter.plugins.firebasemessaging.FlutterFirebaseMessagingService
import io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin
import io.flutter.view.FlutterMain
import com.dexterous.flutterlocalnotifications.FlutterLocalNotificationsPlugin

class Application : FlutterApplication(), PluginRegistrantCallback {

    override fun onCreate() {
        super.onCreate()
        FlutterFirebaseMessagingService.setPluginRegistrant(this);
        FlutterFirebaseMessagingBackgroundService.setPluginRegistrant(this);
        FlutterMain.startInitialization(this)
    }
    override fun registerWith(registry: PluginRegistry?) {
        if (!registry!!.hasPlugin("io.flutter.plugins.firebasemessaging")) {
            FirebaseMessagingPlugin.registerWith(registry!!.registrarFor("io.flutter.plugins.firebasemessaging.FirebaseMessagingPlugin"));
            FlutterLocalNotificationsPlugin.registerWith(registry.registrarFor("com.dexterous.flutterlocalnotifications.FlutterLocalNotificationsPlugin"));
        }
    }
}