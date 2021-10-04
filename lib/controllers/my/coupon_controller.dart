import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/addCareControllers/addCarePayment_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/addGenuinePayment_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/mypage/coupon/couponList_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/paging_model.dart';
import 'package:brandcare_mobile_flutter_v2/providers/my_provider.dart';
import 'package:brandcare_mobile_flutter_v2/utils/shared_token_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CouponController extends BaseController{

  late Paging couponListPaging;
  List<CouponListModel>? couponList = <CouponListModel>[];
  ScrollController pagingScroll = ScrollController();
  int currentPage = 1;
  RxString couponCode = RxString('');
  RxInt myPoint = 0.obs;
  RxInt countCoupon = 0.obs;

  // 추가부분
  RxInt couponId = 0.obs;
  RxInt couponDiscount = 0.obs;
  RxInt couponIdGive = 0.obs;

  void pagingScrollListener() async {
    if(pagingScroll.position.pixels == pagingScroll.position.maxScrollExtent){
      print("스크롤이 최하단입니다. 다시 로딩합니다.");
      if (couponListPaging.totalCount != couponList!.length) {
        this.currentPage++;
        await reqCouponList();
      }
    }
  }

  void couponUse(int idx) {
    if(couponDiscount.value == 0 && couponDiscount.value == 0){
      couponId.value = couponList![idx].id;
      couponDiscount.value = couponList![idx].discount;
    }else {
      couponId.value = 0;
      couponDiscount.value = 0;
    }
  }

  Future<void> reqCouponList() async {
    final String? token = await SharedTokenUtil.getToken("userLogin_token");
    final res =  await MyProvider().couponHistory(token!, currentPage);
    if(res == null){
      Get.dialog(
          CustomDialogWidget(content: '서버와 접속이 원할 하지 않습니다.', onClick: (){
            Get.back();
            update();
          })
      );
    }else{
      final list = (res['response']['list'] as List).map((e) => CouponListModel.fromJson(e)).toList();
      couponListPaging = Paging.fromJson(res['response']);
      if (currentPage == 1) {
        this.couponList = list;
      } else {
        for (var e in list) {
          this.couponList!.add(e);
        }
      }
      countCoupon.value = (res['model']['countCoupon']);
      myPoint.value = (res['model']['point']);
    }
    update();
  }

  void couponAddWhere(){
    if(couponId.value != 0 && couponDiscount.value != 0){
      if(Get.arguments['type'] == "care"){
        final AddCarePaymentController addCarePayCtrl = Get.find<AddCarePaymentController>();
        addCarePayCtrl.couponDiscount.value = couponDiscount.value;
        addCarePayCtrl.couponIdx = couponId.value;
        addCarePayCtrl.update();
        Get.back();
      }else{
        final AddGenuinePaymentController addGenuinePayCtrl = Get.find<AddGenuinePaymentController>();
        addGenuinePayCtrl.couponDiscount.value = couponDiscount.value;
        addGenuinePayCtrl.couponIdx = couponId.value;
        addGenuinePayCtrl.update();
        Get.back();
      }
    }
  }

  addCoupon() {
    //couponList.add('');
    update();
  }

  Future<void> couponAdd(String code)async{
    final String? token = await SharedTokenUtil.getToken("userLogin_token");
    final res =  await MyProvider().couponAdd(token!, code);
    print(res.toString());
    if(res == null){
      Get.dialog(
          CustomDialogWidget(content: '서버와 접속이 원할 하지 않습니다.', onClick: (){
            Get.back();
            update();
          })
      );
    }else if (res == "notCoupon"){
      Get.dialog(
          CustomDialogWidget(content: '쿠폰 번호가 아닙니다.', onClick: (){
            Get.back();
            update();
          })
      );
    }else if(res == "already"){
      Get.dialog(
          CustomDialogWidget(content: '이미 등록하신 쿠폰입니다.', onClick: (){
            Get.back();
            update();
          })
      );
    }else{
      Get.dialog(
        CustomDialogWidget(content: '쿠폰이 등록되었습니다.', onClick: ()async{
          await reqCouponList();
          Get.back();
          Get.back();
          update();
        }),
        barrierDismissible: false,
      );
    }
  }

  Future<void> couponAddPayment(String code)async{
    final String? token = await SharedTokenUtil.getToken("userLogin_token");
    final res =  await MyProvider().couponAdd(token!, code);
    if(res == "notCoupon"){
      Get.dialog(
          CustomDialogWidget(content: '쿠폰 형식이 올바르지 않습니다.', onClick: (){
            Get.back();
            update();
          })
      );
    }else if (res == null){
      Get.dialog(
          CustomDialogWidget(content: '서버와 접속이 원할 하지 않습니다.', onClick: (){
            Get.back();
            update();
          })
      );
    }else{
      Get.dialog(
        CustomDialogWidget(content: '쿠폰이 등록되었습니다.', onClick: ()async{
          await reqCouponList();
          Get.back();
          update();
        }),
        barrierDismissible: false,
      );
    }
  }

  void giveCouponIdx(){
    if(Get.arguments['couponId'] != null){
      couponId.value = Get.arguments['couponId'];
    }
  }

  bool get isValidCouponCode =>
      couponCode.value != '' && couponCode.value.isNotEmpty && couponCode.value.length == 10;

  @override
  void onInit() async{
    await reqCouponList();
    giveCouponIdx();
    pagingScroll.addListener(pagingScrollListener);
    super.onInit();
  }

  @override
  void dispose() {
    pagingScroll.dispose();
    super.dispose();
  }
}