import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class ShopDetailController extends BaseController with SingleGetTickerProviderMixin{

  CarouselController slideCtrlBtn = CarouselController();
  Rx<int> pageNum = 0.obs;
  Rx<bool> isLiked = false.obs;

  List<String> testBanner = [
    "https://www.hdcarwallpapers.com/walls/kia_seltos_x_line_concept_2020_5k-HD.jpg",
    "https://images4.alphacoders.com/110/1104217.jpg",
    "https://www.hdcarwallpapers.com/walls/kia_seltos_x_line_concept_2020_5k-HD.jpg",
    "https://www.hdcarwallpapers.com/walls/kia_seltos_x_line_concept_2020_5k-HD.jpg",
  ];

  void pageChanged(int idx){
    pageNum.value = idx;
    update();
  }

  void changeIsLiked(){
    isLiked.value = !isLiked.value;
    update();
  }
  @override
  void onInit() {
    super.onInit();
  }
}