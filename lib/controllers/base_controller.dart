import 'package:brandcare_mobile_flutter_v2/consts/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:get/get.dart';

enum NetworkStateEnum {
  NONE,
  LOADING,
  DONE,
  ERROR,
}

class BaseController extends GetxController {
  Rx<NetworkStateEnum> networkState = NetworkStateEnum.NONE.obs;

  bool isShowLoading = true;

  @override
  void onInit() {
    super.onInit();
    EasyLoading.instance
      ..loadingStyle = EasyLoadingStyle.custom
      ..indicatorType = EasyLoadingIndicatorType.fadingCircle
      ..maskType = EasyLoadingMaskType.black
      ..indicatorColor = primaryColor
      ..backgroundColor = whiteColor
      ..textColor = primaryColor;

    ever(networkState, (_) {
      print('ever');
      switch (networkState.value) {
        case NetworkStateEnum.LOADING:
          if (isShowLoading) {
            EasyLoading.show();
          }
          break;
        case NetworkStateEnum.NONE:
        case NetworkStateEnum.DONE:
        case NetworkStateEnum.ERROR:
          if (!isShowLoading) isShowLoading = true;
          if(EasyLoading.isShow) EasyLoading.dismiss();
      }
    });
  }
}
