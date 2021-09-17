import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/mypage/coupon/couponList_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/paging_model.dart';
import 'package:brandcare_mobile_flutter_v2/providers/my_provider.dart';
import 'package:brandcare_mobile_flutter_v2/utils/shared_token_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class CouponController extends BaseController{

  late Paging couponListPaging;
  List<CouponListModel>? couponList = <CouponListModel>[
    CouponListModel("SSIBALNOM2B", 3000, 0, "0", "SINBALSagi 쿠폰!"),
  ];
  ScrollController pagingScroll = ScrollController();
  int currentPage = 1;
  RxString couponCode = RxString('');
  RxInt myPoint = 0.obs;
  RxInt countCoupon = 0.obs;

  // 추가부분
  RxInt couponId = 0.obs;
  RxInt couponDiscount = 0.obs;

  void pagingScrollListener() async {
    if(pagingScroll.position.pixels == pagingScroll.position.maxScrollExtent){
      print("스크롤이 최하단입니다. 다시 로딩합니다.");
      if (couponListPaging.totalCount != couponList!.length) {
        this.currentPage++;
        await reqCouponList();
      }
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
      final list = (res['couponList'] as List).map((e) => CouponListModel.fromJson(e)).toList();
      // couponListPaging = Paging.fromJson(res['response']);
      if (currentPage == 1) {
        //this.couponList = list;
      } else {
        for (var e in list) {
          this.couponList!.add(e);
        }
      }
      countCoupon.value = (res['countCoupon']);
      myPoint.value = (res['point']);
    }
    update();
  }

  addCoupon() {
    //couponList.add('');
    update();
  }

  bool get isValidCouponCode => couponCode.value != '' && couponCode.value.isNotEmpty && couponCode.value.length == 11;

  @override
  void onInit() async{
    await reqCouponList();
    pagingScroll.addListener(pagingScrollListener);
    super.onInit();
  }

  @override
  void dispose() {
    pagingScroll.dispose();
    super.dispose();
  }
}