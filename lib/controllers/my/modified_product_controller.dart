import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/categoryList_model.dart';
import 'package:brandcare_mobile_flutter_v2/providers/product_provider.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/product/modifiedProductImgs_page.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class ModifiedProductController extends BaseController{
  TextEditingController titleCtrl = TextEditingController();
  TextEditingController serialCtrl = TextEditingController();
  TextEditingController buyDateCtrl = TextEditingController();
  TextEditingController buyPriceCtrl = TextEditingController();
  TextEditingController buyRouteCtrl = TextEditingController();

  List<CategoryListModel>? brandList = <CategoryListModel>[];
  List<CategoryListModel>? categoryList = <CategoryListModel>[];

  RxBool nextBtn = false.obs;
  late int brandCategoryIdx = 999;
  late int categoryIdx = 999;

  void changeBrandCategory(int idx){
    brandCategoryIdx = idx;
    update();
  }

  void changeCategory(int idx){
    categoryIdx = idx;
    update();
  }

  Future<void> reqBrandCategory() async{
    final res = await ProductProvider().brandNameList();
    brandList = (res['data'] as List).map((e) => CategoryListModel.fromJson(e)).toList();
    update();
  }

  Future<void> reqCategory() async {
    final res = await ProductProvider().categoryNameList();
    categoryList = (res['data'] as List).map((e) => CategoryListModel.fromJson(e)).toList();
    update();
  }

  void nextBtnFill(){
    if (
    titleCtrl.text == "" ||
        serialCtrl.text == "" ||
        buyDateCtrl.text == "" ||
        buyPriceCtrl.text == "" ||
        buyRouteCtrl.text == "" ||
        categoryIdx == 999 ||
        brandCategoryIdx == 999
    ){
      nextBtn.value = false;
      update();
    }else {
      nextBtn.value = true;
      update();
    }
  }

  void nextLevel(){
    if(nextBtn.value){
      Get.to(() => ModifiedProductImgsPage(), arguments: {
        "imgList" : Get.arguments['imgList']
      });
    }
  }

  @override
  void onInit() async {
    await reqCategory();
    await reqBrandCategory();
    super.onInit();
  }
}