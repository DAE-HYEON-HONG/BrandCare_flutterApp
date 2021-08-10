import 'package:get/get.dart';

enum NetworkStateEnum {
  NONE,
  LOADING,
  DONE,
  ERROR,
}

class BaseController extends GetxController {
  Rx<NetworkStateEnum> networkState = NetworkStateEnum.NONE.obs;

}