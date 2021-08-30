import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/shop/shopDetail_model.dart';
import 'package:brandcare_mobile_flutter_v2/providers/shop_provider.dart';
import 'package:brandcare_mobile_flutter_v2/utils/shared_token_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class ShopDetailController extends BaseController with SingleGetTickerProviderMixin{

  CarouselController slideCtrlBtn = CarouselController();
  Rx<int> pageNum = 0.obs;
  Rx<bool> isLiked = false.obs;
  int idx = Get.arguments;
  late ShopDetailModel model;

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

  Future<void> changeIsLiked() async{
    model.hasLike = !model.hasLike;
    final String? token = await SharedTokenUtil.getToken('userLogin_token');
    var res = await ShopProvider().isLiked(token!, idx);
    if(res == null){
      Get.dialog(
          CustomDialogWidget(content: '서버와 접속이 원할 하지 않습니다.', onClick: (){
            Get.back();
            update();
          })
      );
    }
    update();
  }

  Future<void> reqShopDetail() async {
    final String? token = await SharedTokenUtil.getToken("userLogin_token");
    var res = await ShopProvider().shopDetail(token!, idx);
    if(res == null){
      Get.dialog(
          CustomDialogWidget(content: '서버와 접속이 원할 하지 않습니다.', onClick: (){
            Get.back();
            update();
          })
      );
    }else{
      model = res;
      update();
    }
  }
  @override
  void onInit() async{
    await reqShopDetail();
    super.onInit();
  }
}