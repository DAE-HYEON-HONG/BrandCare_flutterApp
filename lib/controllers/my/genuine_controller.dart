import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/mypage/genuine/genuineList_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/paging_model.dart';
import 'package:brandcare_mobile_flutter_v2/providers/my_provider.dart';
import 'package:brandcare_mobile_flutter_v2/utils/shared_token_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:get/get.dart';

class GenuineController extends BaseController{
  late Paging genuineListPaging;
  List<GenuineListModel>? genuineList = <GenuineListModel>[];
  ScrollController pagingScroll = ScrollController();
  int currentPage = 1;
  RxInt completeCount = 0.obs;
  RxInt notCompleteCount = 0.obs;
  RxString sort = "LATEST".obs;

  void pagingScrollListener() async {
    if(pagingScroll.position.pixels == pagingScroll.position.maxScrollExtent){
      print("스크롤이 최하단입니다. 다시 로딩합니다.");
      if (genuineListPaging.totalCount != genuineList!.length) {
        this.currentPage++;
        await reqGenuineList();
      }
    }
  }

  Future<void> reqGenuineList() async {
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
      genuineList = (res['response']['list'] as List).map((e) => GenuineListModel.fromJson(e)).toList();
      genuineListPaging = Paging.fromJson(res['response']);
      completeCount.value = (res['model']['completeCount']) ?? 0;
      notCompleteCount.value = (res['model']['notCompleteCount']) ?? 0;
    }
    update();
  }

  @override
  void onInit() async{
    await reqGenuineList();
    pagingScroll.addListener(pagingScrollListener);
    super.onInit();
  }
}