import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/mypage/product/myProduct_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/paging_model.dart';
import 'package:brandcare_mobile_flutter_v2/providers/my_provider.dart';
import 'package:brandcare_mobile_flutter_v2/utils/shared_token_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class MyProductController extends BaseController {

  late Paging productListPaging;
  List<MyProduct>? myProductList = <MyProduct>[];
  ScrollController pagingScroll = ScrollController();
  int currentPage = 1;
  RxString sort = "LATEST".obs;

  void pagingScrollListener() async {
    if(pagingScroll.position.pixels == pagingScroll.position.maxScrollExtent){
      print("스크롤이 최하단입니다. 다시 로딩합니다.");
      if (productListPaging.totalCount != myProductList!.length) {
        this.currentPage++;
        await reqProductList();
      }
    }
  }

  Future<void> filter({required String type})async {
    currentPage = 1;
    sort.value = type;
    update();
    await reqProductList();
    Get.back();
  }

  Future<void> reqProductList() async {
    final String? token = await SharedTokenUtil.getToken("userLogin_token");
    final res =  await MyProvider().productList(token!, currentPage, sort.value);
    print(res.toString());
    if(res == null){
      Get.dialog(
          CustomDialogWidget(content: '서버와 접속이 원할 하지 않습니다.', onClick: (){
            Get.back();
            update();
          })
      );
    }else{
      final list = (res['list'] as List).map((e) => MyProduct.fromJson(e)).toList();
      if (currentPage == 1) {
        this.myProductList = list;
      } else {
        for (var e in list) {
          this.myProductList!.add(e);
        }
      }
      productListPaging = Paging.fromJson(res);
    }
    update();
  }

  @override
  void onInit() async{
    await reqProductList();
    pagingScroll.addListener(pagingScrollListener);
    super.onInit();
  }
}