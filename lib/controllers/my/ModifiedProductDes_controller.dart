import 'dart:io';

import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/AddProductControllers/addProductImgs_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/AddProductControllers/mainAddProduct_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/modifiedProductImgs_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/modified_product_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/productInfo_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/category/categoryList_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/product/addProduct_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/product/updateProduct_model.dart';
import 'package:brandcare_mobile_flutter_v2/providers/product_provider.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ModifiedProductDesController extends BaseController{

  final productInfoDetailCtrl = Get.find<ProductInfoDetailController>();
  final updateDetailCtrl = Get.find<ModifiedProductController>();
  final updateImgCtrl = Get.find<ModifiedProductImgsController>();

  TextEditingController desBody = TextEditingController();

  RxBool dirty = false.obs;
  RxBool broken = false.obs;
  RxBool nothing = false.obs;
  RxBool dustBag = false.obs;
  RxBool guarantee = false.obs;
  RxBool notExist = false.obs;

  List<int> conditionId = [];
  List<int> additionalId = [];

  bool isCondition = false;
  bool products = false;
  bool description = false;

  RxBool fill = true.obs;

  void infoInit(){
    infoAutoChk(productInfoDetailCtrl.model!.additionList);
    infoAutoChk(productInfoDetailCtrl.model!.conditionList);
    desBody.text = productInfoDetailCtrl.model!.etc;
  }

  double autoHeight (BuildContext context){
    double height = MediaQuery.of(context).viewInsets.bottom == 0 ? 0 : 200;
    return height;
  }

  void infoAutoChk(List<CategoryListModel> list){
    for(var addValue in list){
      if(addValue.title == "오염"){
        dirty.value = true;
        nothing.value = false;
      }else if(addValue.title == "파손"){
        broken.value = true;
        nothing.value = false;
      }else if(addValue.title == "문제없음"){
        nothing.value = true;
      }else if(addValue.title == "더스트백"){
        dustBag.value = true;
        notExist.value = false;
      }else if(addValue.title == "보증서"){
        guarantee.value = true;
        notExist.value = false;
      }else{
        notExist.value = true;
        dustBag.value = false;
        guarantee.value = false;
      }
    }
  }

  void choiceChk(String title){
    if(title == "오염"){
      dirty.value = !dirty.value;
      nothing.value = false;
    }else if(title == "파손"){
      broken.value = !broken.value;
      nothing.value = false;
    }else if(title == "문제 없음"){
      nothing.value = !nothing.value;
      if(nothing.value){
        dirty.value = false;
        broken.value = false;
      }
    }else if(title == "더스트백"){
      dustBag.value = !dustBag.value;
      notExist.value = false;
    }else if(title == "보증서"){
      guarantee.value = !guarantee.value;
      notExist.value = false;
    }else{
      notExist.value = !notExist.value;
      if(notExist.value){
        dustBag.value = false;
        guarantee.value = false;
      }
    }
    formChk();
    update();
  }

  void formChk(){
    if(dirty.value || broken.value || nothing.value){
      this.isCondition = true;
    }else {
      this.isCondition = false;
    }

    if(dustBag.value || guarantee.value || notExist.value){
      this.products = true;
    }else {
      this.products = false;
    }

    if(desBody.text != ""){
      this.description = true;
    }else {
      this.description = false;
    }

    print(this.isCondition);
    print(this.products);
    print(this.description);

    if(this.isCondition && this.products && this.description){
      fill.value = true;
    }else {
      fill.value = false;
    }
    update();
    return;
  }

  void addList(){
    if(dirty.value){
      conditionId.add(1);
    }
    if(broken.value){
      conditionId.add(2);
    }
    if(nothing.value){
      conditionId.add(3);
    }
    if(dustBag.value){
      additionalId.add(1);
    }
    if(guarantee.value) {
      additionalId.add(2);
    }
    if(notExist.value) {
      additionalId.add(3);
    }
  }

  void reallyAdd({required Function okTap}){
    Get.dialog(
      CustomDialogWidget(
        title: '알림',
        content: '수정 하시겠습니까?',
        onClick: ()async{
          Get.back();
          await okTap();
        },
        onCancelClick: () {
          Get.back();
        },
        isSingleButton: false,
        okTxt: "확인",
        cancelTxt: "취소",
      ),
    );
  }

  Future<void> uploadAddProduct() async {
    if(fill.value){
      fill.value = false;
      addList();
      super.networkState = NetworkStateEnum.LOADING.obs;
      UpdateProductModel model = UpdateProductModel(
        title: updateDetailCtrl.titleCtrl.text,
        categoryId: updateDetailCtrl.categoryIdx,
        brandId: updateDetailCtrl.brandCategoryIdx,
        etc: desBody.text,
        price: updateDetailCtrl.buyPriceCtrl.text != "" ? int.parse(updateDetailCtrl.buyPriceCtrl.text) : 0,
        serialCode: updateDetailCtrl.serialCtrl.text,
        buyRoute: updateDetailCtrl.buyRouteCtrl.text,
        buyDate: updateDetailCtrl.buyDateCtrl.text,
        conditionId: conditionId,
        additionId: additionalId,
        id: productInfoDetailCtrl.model!.id,
        deleteImageId: updateImgCtrl.removeImgIdx!,
        deleteStr: updateImgCtrl.removeMainImg!,
      );
      print(model.toString());
      List<File> images = <File>[];
      for(var file in updateImgCtrl.imgList!){
        images.add(file.file!);
      }
      final res = await ProductProvider().productUpdate(
        model,
        images,
        updateImgCtrl.frontImg.value,
        updateImgCtrl.backImg.value,
        updateImgCtrl.leftImg.value,
        updateImgCtrl.rightImg.value,
      );
      super.networkState = NetworkStateEnum.DONE.obs;
      fill.value = true;
      if(res == null){
        Get.dialog(
          CustomDialogWidget(content: '네트워크 에러입니다.', onClick: (){
            Get.back();
            update();
          }),
        );
      }else{
        if(res['data'] == "Y"){
          ProductInfoDetailController productInfoDetailCtrl = Get.find<ProductInfoDetailController>();
          Get.dialog(
            CustomDialogWidget(content: '제품수정이 완료되었습니다.', onClick: ()async{
              await productInfoDetailCtrl.reqProductInfo();
              Get.back();
              Get.back();
              Get.back();
              Get.back();
              update();
            }),
            barrierDismissible: false,
          );
        }
      }
    }
  }

  @override
  void onInit() {
    infoInit();
    super.onInit();
  }
}