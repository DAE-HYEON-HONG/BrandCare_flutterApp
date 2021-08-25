import 'package:flutter/material.dart';
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

    ever(networkState, (_){
      switch(networkState.value){
        case NetworkStateEnum.LOADING:
          if(isShowLoading) {
            //TODO: Loading widget
          }
          break;
        case NetworkStateEnum.NONE:
        case NetworkStateEnum.DONE:
        case NetworkStateEnum.ERROR:
          if(!isShowLoading) isShowLoading = true;
      }
    });
  }
}