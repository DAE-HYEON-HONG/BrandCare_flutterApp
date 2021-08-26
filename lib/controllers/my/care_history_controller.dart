import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/mypage/care/careList_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/paging_model.dart';
import 'package:brandcare_mobile_flutter_v2/providers/my_provider.dart';
import 'package:brandcare_mobile_flutter_v2/utils/shared_token_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class CareHistoryController extends BaseController {

  late Paging careListPaging;
  List<CareListModel>? careList = <CareListModel>[];
  ScrollController pagingScroll = ScrollController();
  int currentPage = 1;
  RxInt careCompleteCount = 0.obs;
  RxString sort = "LATEST".obs;

  void pagingScrollListener() async {
    if(pagingScroll.position.pixels == pagingScroll.position.maxScrollExtent){
      print("스크롤이 최하단입니다. 다시 로딩합니다.");
      if (careListPaging.totalCount != careList!.length) {
        this.currentPage++;
        await reqCareList();
      }
    }
  }

  Future<void> reqCareList() async {
    final String? token = await SharedTokenUtil.getToken("userLogin_token");
    final res =  await MyProvider().caretList(token!, currentPage, sort.value);
    if(res == null){
      Get.dialog(
          CustomDialogWidget(content: '서버와 접속이 원할 하지 않습니다.', onClick: (){
            Get.back();
            update();
          })
      );
    }else{
      careList = (res['response']['list'] as List).map((e) => CareListModel.fromJson(e)).toList();
      careListPaging = Paging.fromJson(res['response']);
      careCompleteCount.value = (res['model']['careCompleteCount']);
    }
    update();
  }

  @override
  void onInit() async{
    await reqCareList();
    pagingScroll.addListener(pagingScrollListener);
    super.onInit();
  }

  @override
  void dispose() {
    pagingScroll.dispose();
    super.dispose();
  }
}