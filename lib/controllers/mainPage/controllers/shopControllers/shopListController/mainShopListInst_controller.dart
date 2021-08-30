import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/paging_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/shop/shopList_model.dart';
import 'package:brandcare_mobile_flutter_v2/providers/shop_provider.dart';
import 'package:brandcare_mobile_flutter_v2/utils/shared_token_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainShopListInstController extends BaseController{

  late Paging shopListPaging;
  ScrollController pagingScroll = ScrollController();
  int currentPage = 1;
  List<ShopListModel>? shopList = <ShopListModel>[];

  TextEditingController searchWordCtrl = TextEditingController();

  void pagingScrollListener() async {
    if(pagingScroll.position.pixels == pagingScroll.position.maxScrollExtent){
      print("스크롤이 최하단입니다. 다시 로딩합니다.");
      if (shopListPaging.totalCount != shopList!.length) {
        this.currentPage++;
        await reqShopList();
      }
    }
  }

  Future<void> reqShopList() async {
    final String? token = await SharedTokenUtil.getToken("userLogin_token");
    final res =  await ShopProvider().shopList(token!, currentPage, searchWordCtrl.text, "LIKE");
    if(res == null){
      Get.dialog(
          CustomDialogWidget(content: '서버와 접속이 원할 하지 않습니다.', onClick: (){
            Get.back();
            update();
          })
      );
    }else{
      final list = (res['list'] as List).map((e) => ShopListModel.fromJson(e)).toList();
      if (currentPage == 1) {
        this.shopList = list;
      } else {
        for (var e in list) {
          this.shopList!.add(e);
        }
      }
      shopListPaging = Paging.fromJson(res);
    }
    update();
  }

  @override
  void onInit() async{
    await reqShopList();
    pagingScroll.addListener(pagingScrollListener);
    super.onInit();
  }

  @override
  void dispose() {
    pagingScroll.dispose();
    super.dispose();
  }
}