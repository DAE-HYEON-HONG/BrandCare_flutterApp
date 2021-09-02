import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/my_product_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/productInfo_controller.dart';
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
  ProductInfoDetailController myProductDetailCtrl = Get.find<ProductInfoDetailController>();
  String category = "";
  String brand = "";
  List<CategoryListModel>? brandList = <CategoryListModel>[];
  List<CategoryListModel>? categoryList = <CategoryListModel>[];

  RxBool nextBtn = true.obs; // 수정은 무조건 true로 해야 합니다.
  int brandCategoryIdx = 0;
  int categoryIdx = 0;

  double autoHeight (BuildContext context){
    double height = MediaQuery.of(context).viewInsets.bottom == 0 ? 0 : 200;
    return height;
  }

  void infoInit(){
    brand = myProductDetailCtrl.model!.brand;
    category = myProductDetailCtrl.model!.category;
    brandCategoryIdx = myProductDetailCtrl.model!.brandId;
    categoryIdx = myProductDetailCtrl.model!.categoryId;
    titleCtrl.text = myProductDetailCtrl.model!.title;
    serialCtrl.text = myProductDetailCtrl.model!.serialCode;
    buyDateCtrl.text = "${myProductDetailCtrl.model!.buyDate.substring(0,2)}${myProductDetailCtrl.model!.buyDate.substring(3,5)}";
    buyPriceCtrl.text = myProductDetailCtrl.model!.price;
    buyRouteCtrl.text = myProductDetailCtrl.model!.buyRoute;
  }

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

  void nextBtnFill(){}

  void hintText(String value, String mode){
    if(mode == "category"){
      category = value;
      update();
    }else{
      brand = value;
      update();
    }
  }

  void nextLevel(){
    if(nextBtn.value){
      Get.to(() => ModifiedProductImgsPage());
    }
  }

  @override
  void onInit() async {
    await reqCategory();
    await reqBrandCategory();
    infoInit();
    super.onInit();
  }
}