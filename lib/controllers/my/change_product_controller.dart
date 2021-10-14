import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/productInfo_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/product/product_change_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/product/product_model.dart';
import 'package:brandcare_mobile_flutter_v2/providers/product_provider.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/changeProduct/change_product_enum.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeProductController extends BaseController with SingleGetTickerProviderMixin{

  late TabController tabController;

  String _requestString = '변경할 사용자의 확인을 기다리는 중입니다.\n"확인 중" 버튼을 누를 시 변경 요청이 취소 됩니다.';
  String _receivedString = '상대방이 확인을 기다리는 중입니다.\n"확인"을 누를 시 제품 사용자 변경이 완료 됩니다.';

  TextEditingController emailTextCtrl = TextEditingController();

  RxInt selectIdx = RxInt(-1);
  Rx<String> userEmail = ''.obs;
  Rx<bool> isChange = false.obs;
  Rx<bool> emailCheck = false.obs;
  List<ProductModel> myProductData = <ProductModel>[];
  ProductModel? selectProductModel;
  int? cancelIdx;

  RxList<ProductChangeModel> sendProductChangeList = RxList();
  RxList<ProductChangeModel> receiveProductChangeList = RxList();
  RxList<ProductChangeModel> completeProductChangeList = RxList();
  RxList<ProductChangeModel> cancelProductChangeList = RxList();

  ProductChangeModel? historyOnceProductData;

  final _productProvider = ProductProvider();

  double autoHeight (BuildContext context){
    double height = MediaQuery.of(context).viewInsets.bottom == 0 ? 0 : 300;
    return height;
  }

  void initInfo(){
    emailTextCtrl.text = "";
    selectProductModel = null;
    update();
  }

  String getTypeComment(ChangeProductEnum type) {
    String typeComment = "";
    switch(type) {
      case ChangeProductEnum.REQUEST:
        typeComment = _requestString;
        break;
      case ChangeProductEnum.REQUEST:
        typeComment = _receivedString;
        break;
      case ChangeProductEnum.CANCEL:
        break;
      case ChangeProductEnum.COMPLETE:
        break;
      case ChangeProductEnum.RECEIVED:
        break;
    }
    return typeComment;
  }

  bool get isOn => userEmail.value.isNotEmpty && GetUtils.isEmail(userEmail.value) && selectProductModel != null ;

  // void updateSelectIdx(int idx) {
  //   selectIdx.value = idx;
  //   update();
  // }

  void changeProductOwner() {
    if(selectProductModel == null){
      Get.dialog(
          CustomDialogWidget(content: '제품을 선택해주세요.', onClick: (){
            Get.back();
          })
      );
    }else{
      if(userEmail.value == ""){
        Get.dialog(
            CustomDialogWidget(content: '이메일을 입력해주세요.', onClick: (){
              Get.back();
            })
        );
      }else{
        Get.dialog(
            CustomDialogWidget(content: '변경할 사용자에게 모든 제품 정보가\n이동되며 복구할 수 없습니다.\n제품 사용자 변경을 진행 하시겠습니까?',
              onClick: (){
                Get.back();
                changeProduct();
                // Get.toNamed('/main/my/change_product/apply/change');
              },
              isSingleButton: false,
              title: '제품 사용자 변경',
            )
        );
      }
    }
  }

  void changeProductOwnerInfoPage(int idx) {
    if(userEmail.value == ""){
      Get.dialog(
          CustomDialogWidget(content: '이메일을 입력해주세요.', onClick: (){
            Get.back();
          })
      );
    }else{
      print('dialog');
      Get.dialog(
          CustomDialogWidget(content: '변경할 사용자에게 모든 제품 정보가\n이동되며 복구할 수 없습니다.\n제품 사용자 변경을 진행 하시겠습니까?',
            onClick: (){
              Get.back();
              changeProductInfoPage(idx);
            },
            isSingleButton: false,
            title: '제품 사용자 변경',
          )
      );
    }
  }

  void getMyProduct() async {
    super.networkState.value = NetworkStateEnum.LOADING;
    var json = await _productProvider.getMyProduct();
    super.networkState.value = NetworkStateEnum.DONE;
    print('json = $json');

    if(json != null) {
      final list = (json['list'] as List).map((e) => ProductModel.fromJson(e)).toList();
      myProductData = list;
      selectMyProduct(myProductData[0]);
      update();
    }

  }

  void selectMyProduct(ProductModel productModel) async {
    selectProductModel = productModel;
    update();
  }

  void changeProduct() async {
    super.networkState.value = NetworkStateEnum.LOADING;
    var json = await _productProvider.changeProduct({'email': userEmail.value, 'productId': selectProductModel!.id});
    print(json);
    super.networkState.value = NetworkStateEnum.DONE;
    if(json != null && json['data'] != null) {
      cancelIdx = int.parse(json['data']);
      Get.snackbar('알림', '제품 변경 신청되었습니다.', snackPosition: SnackPosition.BOTTOM);
      getChangeProductList();
      Get.offNamed('/main/my/change_product/apply/complete',);
      return;
    }else if(json != null && json['code'] == "CP001") {
      Get.dialog(
          CustomDialogWidget(content: '해당 상품으로 제품 사용자 변경이 진행 중 입니다.', onClick: (){
            Get.back();
            Get.back();
          })
      );
    }

    else{
      Get.dialog(
          CustomDialogWidget(content: '해당 이메일이 존재하지 않습니다.', onClick: (){
            Get.back();
          })
      );
    }
  }

  void changeProductInfoPage(int idx) async {
    super.networkState.value = NetworkStateEnum.LOADING;
    var json = await _productProvider.changeProduct({'email': userEmail.value, 'productId': idx});
    print(json);
    super.networkState.value = NetworkStateEnum.DONE;
    if(json != null && json['data'] != null) {
      cancelIdx = int.parse(json['data']);
      Get.snackbar('알림', '제품 변경 신청되었습니다.', snackPosition: SnackPosition.BOTTOM);
      getChangeProductList();
      Get.offNamed('/main/my/change_product/apply/complete');
      return;
    } else if(json != null && json['code'] == "CP001") {
      Get.dialog(
          CustomDialogWidget(content: '해당 상품으로 제품 사용자 변경이 진행 중 입니다.', onClick: (){
            Get.back();
            Get.back();
          })
      );
    }

    else{
      Get.dialog(
          CustomDialogWidget(content: '해당 이메일이 존재하지 않습니다.', onClick: (){
            Get.back();
          })
      );
    }
  }

  void getChangeProductList() async {
    List tabString = [
      'SEND',
      'RECEIVE',
      'COMPLETE',
      'CANCEL',
    ];
    super.networkState.value = NetworkStateEnum.LOADING;
    var json = await _productProvider.getChangeProduct(tabString[tabController.index]);
    super.networkState.value = NetworkStateEnum.DONE;
    if(json != null) {
      final list = (json['list'] as List).map((e) => ProductChangeModel.fromJson(e)).toList();
      switch(tabString[tabController.index]) {
        case 'SEND':
          sendProductChangeList.value = list;
          break;
        case 'RECEIVE':
          receiveProductChangeList.value = list;
          break;
        case 'COMPLETE':
          completeProductChangeList.value = list;
          break;
        case 'CANCEL':
          cancelProductChangeList.value = list;
          break;
      }
      update();
    }
  }

    void getChangeProductOnce(int id, String status) async {
    super.networkState.value = NetworkStateEnum.LOADING;
    var json = await _productProvider.getChangeProductOnce(id, status);
    super.networkState.value = NetworkStateEnum.DONE;
    if(json != null) {
      final data = ProductChangeModel.fromJson(json);
      historyOnceProductData = data;
      update();
    }
  }

  Future<bool> cancel(int id) async {
    super.networkState.value = NetworkStateEnum.LOADING;
    var json = await _productProvider.changeProductCancel({'id': id});
    getChangeProductList();
    super.networkState.value = NetworkStateEnum.DONE;
    if(json != null && json['data'] == 'Y') return true;
    return false;
  }

  Future<bool> accept(int id) async {
    super.networkState.value = NetworkStateEnum.LOADING;
    var json = await _productProvider.changeProductAccept({'id': id});
    getChangeProductList();
    super.networkState.value = NetworkStateEnum.DONE;
    if(json != null && json.containsKey('id')) return true;
    return false;
  }

  @override
  void onInit() {
    getMyProduct();
    userEmail.value = '';
    selectIdx.value = -1;
    super.onInit();
    tabController = TabController(length: 4, vsync: this);
    getChangeProductList();
    tabController.addListener(() {
      // print(tabController.indexIsChanging);
      // print(tabController.offset);
      // if(tabController.indexIsChanging) {
      // print(1);
      //  getChangeProductList();
      // }
      if(tabController.index != tabController.previousIndex) {
        getChangeProductList();
      }
    });
  }

  @override
  void onClose() {
    super.onClose();
    tabController.dispose();
  }
}