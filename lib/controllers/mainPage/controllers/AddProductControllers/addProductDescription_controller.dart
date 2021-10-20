import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/AddProductControllers/addProductImgs_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/AddProductControllers/mainAddProduct_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/product/addProduct_model.dart';
import 'package:brandcare_mobile_flutter_v2/providers/product_provider.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class AddProductDescriptionController extends BaseController{

  final mainAddProductCtrl = Get.find<MainAddProductController>();
  final addProductImgsCtrl = Get.find<AddProductImgsController>();

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

  RxBool fill = false.obs;

  double autoHeight (BuildContext context){
    double height = MediaQuery.of(context).viewInsets.bottom == 0 ? 0 : 200;
    return height;
  }

  void choiceChk(String title){
    if(title == "오염"){
      dirty.value = !dirty.value;
      nothing.value = false;
      update();
      formChk();
    }else if(title == "파손"){
      broken.value = !broken.value;
      nothing.value = false;
      formChk();
    }else if(title == "문제 없음"){
      nothing.value = !nothing.value;
      if(nothing.value){
        dirty.value = false;
        broken.value = false;
        update();
      }
      formChk();
    }else if(title == "더스트백"){
      dustBag.value = !dustBag.value;
      notExist.value = false;
      update();
      formChk();
    }else if(title == "보증서"){
      guarantee.value = !guarantee.value;
      notExist.value = false;
      update();
      formChk();
    }else{
      notExist.value = !notExist.value;
      if(notExist.value){
        dustBag.value = false;
        guarantee.value = false;
        update();
      }
      formChk();
    }
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

  void reallyAdd(){
    if(fill.value){
      Get.dialog(
        CustomDialogWidget(
          title: '알림',
          content: '등록 하시겠습니까?',
          onClick: ()async{
            await uploadAddProduct();
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
  }

  Future<void> uploadAddProduct() async {
    if(fill.value) {
      fill.value = false;
      super.networkState = NetworkStateEnum.LOADING.obs;
      addList();
      AddProductModel model = AddProductModel(
          title: mainAddProductCtrl.titleCtrl.text,
          categoryId: mainAddProductCtrl.categoryIdx ?? 0,
          brandId: mainAddProductCtrl.brandCategoryIdx ?? 0,
          etc: desBody.text,
          price: mainAddProductCtrl.priceCtrl.text != "" ? int.parse(mainAddProductCtrl.priceCtrl.text) : 0,
          serialCode: mainAddProductCtrl.serialCtrl.text,
          buyRoute: mainAddProductCtrl.connectBuyCtrl.text,
          buyDate: mainAddProductCtrl.sinceBuyCtrl.text,
          conditionId: conditionId,
          additionId: additionalId
      );
      final res = await ProductProvider().productApply(
        model,
        addProductImgsCtrl.pickImgList!,
        addProductImgsCtrl.frontImg.value,
        addProductImgsCtrl.backImg.value,
        addProductImgsCtrl.leftImg.value,
        addProductImgsCtrl.rightImg.value,
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
          Get.dialog(
            CustomDialogWidget(content: '제품등록이 완료되었습니다.', onClick: (){
              Get.offAllNamed('/mainPage');
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
    super.onInit();
  }
}