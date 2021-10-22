import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/global_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/shopControllers/shopListController/mainShopListInst_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/shopControllers/shopListController/mainShopListMine_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/idPathImages_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/shop/shopDetail_model.dart';
import 'package:brandcare_mobile_flutter_v2/providers/shop_provider.dart';
import 'package:brandcare_mobile_flutter_v2/utils/shared_token_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:carousel_slider/carousel_controller.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class ShopDetailController extends BaseController with SingleGetTickerProviderMixin{

  CarouselController slideCtrlBtn = CarouselController();
  final GlobalController globalController = Get.find<GlobalController>();
  Rx<int> pageNum = 0.obs;
  bool isLiked = false;
  int idx = Get.arguments;
  ShopDetailModel? model, modModel;
  MainShopListInstController mainShopListInstCtrl = Get.find<MainShopListInstController>();

  RxBool isMyShop = false.obs;


  List<IdPathImagesModel> testBanner = [
    IdPathImagesModel(0, ""),
  ];

  void checkMyShop(String shopEmail){
    if(shopEmail == globalController.userInfoModel!.email){
      isMyShop.value = true;
    }
    else {
      isMyShop.value = false;
    }
  }


  void pageChanged(int idx){
    pageNum.value = idx;
    update();
  }

  Future<void> changeIsLiked() async{
    final String? token = await SharedTokenUtil.getToken('userLogin_token');
    var res = await ShopProvider().isLiked(token!, idx);
    print(res.toString());
    await reqShopDetail();
    if(res == null){
      Get.dialog(
          CustomDialogWidget(content: '서버와 접속이 원할 하지 않습니다.', onClick: (){
            Get.back();
            update();
          })
      );
    }else if(res['data'] == "취소"){
      print('실행됨.');
      mainShopListInstCtrl.shopList!.removeWhere((item) => item.shopId == model!.shopId);
      mainShopListInstCtrl.update();
    }
    update();
  }

  Future<bool> delShopDetail() async {
    final String? token = await SharedTokenUtil.getToken("userLogin_token");
    var res = await ShopProvider().delShopProduct(token!, idx);
    print(res.toString());
    if(res == null){
      return false;
    }else {
      return true;
    }
  }

  Future<void> reqShopDetail() async {
    final String? token = await SharedTokenUtil.getToken("userLogin_token");
    var res = await ShopProvider().shopDetail(token!, idx);
    print(res.toString());
    if(res == null){
      Get.dialog(
          CustomDialogWidget(content: '서버와 접속이 원할 하지 않습니다.', onClick: (){
            Get.back();
            update();
          })
      );
    }else{
      model = res;
      modModel = res;
      if(model!.frontImage != null){
        model!.images.add(IdPathImagesModel(0, model!.frontImage));
      }
      if(model!.backImage != null){
        model!.images.add(IdPathImagesModel(0, model!.backImage));
      }
      if(model!.leftImage != null){
        model!.images.add(IdPathImagesModel(0, model!.leftImage));
      }
      if(model!.rightImage != null){
        model!.images.add(IdPathImagesModel(0, model!.rightImage));
      }
      if(model!.productImages != null){
        for(var img in model!.productImages!){
          model!.images.add(img);
        }
      }
      mainShopListInstCtrl.reqShopList();
      mainShopListInstCtrl.update();
      update();
    }
  }
  @override
  void onInit() async{
    await reqShopDetail();
    checkMyShop(model!.email);
    super.onInit();
  }
}