import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
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
  Rx<int> pageNum = 0.obs;
  bool isLiked = false;
  int idx = Get.arguments;
  ShopDetailModel? model;
  MainShopListInstController mainShopListInstCtrl = Get.find<MainShopListInstController>();

  List<IdPathImagesModel> testBanner = [
    IdPathImagesModel(0, ""),
  ];

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
    super.onInit();
  }
}