import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/category/categoryList_model.dart';
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

  void initInfo(){
    titleCtrl.text = "";
    categoryCtrl.text = "";
    brandCtrl.text = "";
    serialCtrl.text = "";
    sinceBuyCtrl.text = "";
    priceCtrl.text = "";
    connectBuyCtrl.text = "";
    brandCategoryIdx = null;
    categoryIdx = null;
    nextBtn.value = false;
    update();
  }

  void changeBrandCategory(int idx){
    brandCategoryIdx = idx;
    update();
  }

  void changeCategory(int idx){
    print(idx);
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
    print(titleCtrl.text);
    print(categoryIdx);
    print(brandCategoryIdx);
    dateChk();
    if (titleCtrl.text.isNotEmpty && categoryIdx != null && brandCategoryIdx != null){
      nextBtn.value = true;
      update();
      print("찍힘?");
      return;
    }
    print("안찍힘?");
    nextBtn.value = false;
    update();
  }

  void dateChk() {
    if (sinceBuyCtrl.text != "") {
      if (sinceBuyCtrl.text.length == 4) {
        String yearDate = sinceBuyCtrl.text.substring(2, 4);
        if (int.parse(yearDate) == 00 || int.parse(yearDate) > 12) {
          Get.dialog(CustomDialogWidget(
              content: '날짜를 제대로 입력해주세요.',
              onClick: () {
                Get.back();
                sinceBuyCtrl.text = "";
              }
              ),
          );
          return;
        }
      }
    }
  }


  void nextBtnFunc(BuildContext context) {
    FocusScope.of(context).unfocus();
    if(nextBtn.value){
      if(sinceBuyCtrl.text != ""){
        if(sinceBuyCtrl.text.length != 4){
          Get.dialog(CustomDialogWidget(
              content: '날짜를 제대로 입력해주세요.',
              onClick: () {
                Get.back();
              }
          ),
          );
          return;
        }
      }
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