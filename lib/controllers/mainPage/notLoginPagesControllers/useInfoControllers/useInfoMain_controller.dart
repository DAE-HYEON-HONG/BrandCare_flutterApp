import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class UseInfoMainController extends BaseController{

  Rx<String> currentAppBarTitle = "가격표".obs;

  @override
  void onInit() {
    super.onInit();
  }
}