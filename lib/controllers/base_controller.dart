import 'package:get/get.dart';

enum NetworkStateEnum {
  NONE,
  LOADING,
  DONE,
  ERROR,
}

class BaseController extends GetxController {
  Rx<NetworkStateEnum> networkState = NetworkStateEnum.NONE.obs;

  @override
  void onInit() {
    super.onInit();

    ever(networkState, (_){
      //TODO : check networkState and show/close loading popup
    });
  }
}