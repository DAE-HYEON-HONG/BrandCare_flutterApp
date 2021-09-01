import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/categoryList_model.dart';
import 'package:brandcare_mobile_flutter_v2/providers/product_provider.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainAddProductController extends BaseController {

  TextEditingController titleCtrl = TextEditingController();
  TextEditingController categoryCtrl = TextEditingController();
  TextEditingController brandCtrl = TextEditingController();
  TextEditingController serialCtrl = TextEditingController();
  TextEditingController sinceBuyCtrl = TextEditingController();
  TextEditingController priceCtrl = TextEditingController();
  TextEditingController connectBuyCtrl = TextEditingController();

  RxBool nextBtn = false.obs;
 int? brandCategoryIdx;
 int? categoryIdx;

  List<CategoryListModel> brandList = <CategoryListModel>[];

  List<CategoryListModel> categoryList = <CategoryListModel>[];

  void changeBrandCategory(int idx){
    brandCategoryIdx = idx;
    update();
  }

  void changeCategory(int idx){
    categoryIdx = idx;
    update();
  }

  void customDialogShow({required String title, required BuildContext context}){
    showDialog(context: context, builder: (_) {
      return CustomDialogWidget(
        content: title,
        onClick: () => Get.back(),
        okTxt: "확인",
        isSingleButton: true,
      );
    });
  }

  void nextBtnFill(){
    if (
        titleCtrl.text == "" ||
        serialCtrl.text == "" ||
        sinceBuyCtrl.text == "" ||
        priceCtrl.text == "" ||
        connectBuyCtrl.text == "" ||
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

  void nextBtnFunc(BuildContext context) {
    FocusScope.of(context).unfocus();
    if(nextBtn.value){
      Get.toNamed("/mainAddProduct/addImg");
    }
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

  @override
  void onInit() async {
    await reqCategory();
    await reqBrandCategory();
    super.onInit();
  }
}