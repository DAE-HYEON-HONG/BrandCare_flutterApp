import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/global_controller.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get.dart';

class UseInfoPriceController extends BaseController{
  Rx<int> currentIdx = 0.obs;
  GlobalController globalCtrl = Get.find<GlobalController>();

  void changeCurrentIdx(int idx){
    this.currentIdx.value = idx;
    print("현재 선택된 구역 ${this.currentIdx.value}");
    update();
  }

  @override
  void onInit() {
    super.onInit();
  }
}