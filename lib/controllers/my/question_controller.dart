import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/mypage/question/qeustionList_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/paging_model.dart';
import 'package:brandcare_mobile_flutter_v2/providers/my_provider.dart';
import 'package:brandcare_mobile_flutter_v2/utils/shared_token_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class QuestionController extends BaseController{

  Paging? qListPaging;
  List<QuestionListModel>? qnaList = <QuestionListModel>[];
  ScrollController pagingScroll = ScrollController();
  int currentPage = 1;


  void pagingScrollListener() async {
    if(pagingScroll.position.pixels == pagingScroll.position.maxScrollExtent){
      print("스크롤이 최하단입니다. 다시 로딩합니다.");
      if (qListPaging?.totalCount != qnaList!.length) {
        this.currentPage++;
        await reqQnAList();
      }
    }
  }

  Future<void> reqQnAList() async {
    final res =  await MyProvider().getQna(currentPage);
    if(res == null){
      Get.dialog(
          CustomDialogWidget(content: '서버와 접속이 원할 하지 않습니다.', onClick: (){
            Get.back();
            update();
          })
      );
    }else{
      final list = (res['list'] as List).map((e) => QuestionListModel.fromJson(e)).toList();
      if (currentPage == 1) {
        this.qnaList = list;
      } else {
        for (var e in list) {
          this.qnaList!.add(e);
        }
      }
      qListPaging = Paging.fromJson(res);
      update();
    }
    update();
  }


  @override
  void onInit() async{
    await reqQnAList();
    pagingScroll.addListener(pagingScrollListener);
    super.onInit();
  }

  @override
  void dispose() {
    pagingScroll.dispose();
    super.dispose();
  }
}