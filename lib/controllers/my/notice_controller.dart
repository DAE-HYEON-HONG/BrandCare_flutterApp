import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/mypage/notice/noticeList_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/paging_model.dart';
import 'package:brandcare_mobile_flutter_v2/providers/my_provider.dart';
import 'package:brandcare_mobile_flutter_v2/utils/shared_token_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class NoticeController extends BaseController{

  late Paging noticeListPaging;
  List<NoticeListModel>? noticeList = <NoticeListModel>[];
  ScrollController pagingScroll = ScrollController();
  int currentPage = 1;

  void pagingScrollListener() async {
    if(pagingScroll.position.pixels == pagingScroll.position.maxScrollExtent){
      print("스크롤이 최하단입니다. 다시 로딩합니다.");
      if (noticeListPaging.totalCount != noticeList!.length) {
        this.currentPage++;
        await reqNoticeList();
      }
    }
  }

  Future<void> reqNoticeList() async {
    final String? token = await SharedTokenUtil.getToken("userLogin_token");
    final res =  await MyProvider().noticeList(currentPage);
    if(res == null){
      Get.dialog(
          CustomDialogWidget(content: '서버와 접속이 원할 하지 않습니다.', onClick: (){
            Get.back();
            update();
          })
      );
    }else{
      final list = (res['list'] as List).map((e) => NoticeListModel.fromJson(e)).toList();
      noticeListPaging = Paging.fromJson(res);
      if (currentPage == 1) {
        this.noticeList = list;
      } else {
        for (var e in list) {
          this.noticeList!.add(e);
        }
      }
    }
    update();
  }

  @override
  void onInit() async{
    await reqNoticeList();
    pagingScroll.addListener(pagingScrollListener);
    super.onInit();
  }

  @override
  void dispose() {
    pagingScroll.dispose();
    super.dispose();
  }
}