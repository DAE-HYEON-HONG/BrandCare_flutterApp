import 'package:brandcare_mobile_flutter_v2/bindings/mainShop_binding.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/shopControllers/shopListController/mainShopListAll_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/shopControllers/shopListController/mainShopListInst_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/shopControllers/shopListController/mainShopListMine_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/mypage/product/myProduct_model.dart';
import 'package:brandcare_mobile_flutter_v2/providers/my_provider.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/shopPages/shopAddProductPages/shopAddProuct_page.dart';
import 'package:brandcare_mobile_flutter_v2/utils/shared_token_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainShopController extends BaseController with SingleGetTickerProviderMixin {

  int currentPageIdx = 0;

  RxBool isfillText = false.obs;

  final shopListAllCtrl = Get.put(MainShopListAllController());
  final shopListMineCtrl = Get.put(MainShopListMineController());
  final shopListInstCtrl = Get.put(MainShopListInstController());
  TextEditingController? searchWord;
  late TabController tabCtrl = TabController(length: 3, vsync: this);
  late ScrollController scrollViewCtrl = ScrollController();
  final focusNode = FocusScopeNode();

  void clearSearchText(){
    searchWord!.clear();
  }

  void tabBarListener(int idx) async {
    print("현재 선택된 탭바 idx : $idx");
    currentPageIdx = idx;
    update();
    if(idx == 0){
      await shopListAllCtrl.reqShopList();
    }else if(idx == 1){
      await shopListMineCtrl.reqShopList();
    }else{
      await shopListInstCtrl.reqShopList();
    }
  }

  void reqSearchWord()async{
    if(currentPageIdx == 0){
      shopListAllCtrl.searchWordCtrl = searchWord!;
      shopListAllCtrl.update();
      await shopListAllCtrl.reqShopList();
    }else if(currentPageIdx == 1){
      shopListMineCtrl.searchWordCtrl = searchWord!;
      shopListMineCtrl.update();
      await shopListMineCtrl.reqShopList();
    }else{
      shopListInstCtrl.searchWordCtrl = searchWord!;
      shopListInstCtrl.update();
      await shopListInstCtrl.reqShopList();
    }
  }

  void chkMyProduct()async{
    final int chkProductLength = await reqProductList();
    if(chkProductLength != 0){
     // Get.to(() => ShopAddProductPage("글쓰기"), binding: MainShopAddProductBinding());
      Get.toNamed("/mainShop/addProduct");
    }else{
      Get.dialog(
          CustomDialogWidget(content: '등록된 제품이 없습니다. \n제품을 등록 후 글쓰기를 해주세요.', onClick: (){
            Get.back();
            update();
          })
      );
    }
  }

  Future<int> reqProductList() async {
    final String? token = await SharedTokenUtil.getToken("userLogin_token");
    final res =  await MyProvider().productList(token!, 1, "LATEST");
    print(res.toString());
    if(res == null){
      Get.dialog(
          CustomDialogWidget(content: '서버와 접속이 원할 하지 않습니다.', onClick: (){
            Get.back();
            update();
          })
      );
      return 0;
    }
    final list = (res['list'] as List).map((e) =>  MyProduct.fromJson(e)).toList();
    return list.length;
  }

  @override
  void onInit() {
    searchWord = TextEditingController();
    tabCtrl.addListener(() => tabBarListener(tabCtrl.index));
    super.onInit();
  }

  @override
  void dispose() {
    super.dispose();
  }
}