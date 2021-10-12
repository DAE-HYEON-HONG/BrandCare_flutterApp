import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class UseInfoDescriptionController extends BaseController{

  Rx<bool> isOpened = true.obs;

  void openExpansion() {
    isOpened.value = !isOpened.value;
    update();
  }

  @override
  void onInit() {
    super.onInit();
  }
}