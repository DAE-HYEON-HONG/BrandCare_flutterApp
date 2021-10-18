
import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/mainNotice/main_notice_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/paging_model.dart';
import 'package:brandcare_mobile_flutter_v2/providers/my_provider.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/genuine/addGenuineStatus_page.dart';
import 'package:brandcare_mobile_flutter_v2/utils/shared_token_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class MainNoticeController extends BaseController with SingleGetTickerProviderMixin {

  int currentPageIdx = 0;
  late TabController tabCtrl = TabController(length: 4, vsync: this);
  int pageIdx = 1;
  late Paging noticeListPaging;
  List<MainNoticeModel>? progressNoticeList = <MainNoticeModel>[];
  List<MainNoticeModel>? productNoticeList = <MainNoticeModel>[];
  List<MainNoticeModel>? shopNoticeList = <MainNoticeModel>[];
  List<MainNoticeModel>? inquiryNoticeList = <MainNoticeModel>[];
  ScrollController pagingScroll = ScrollController();

  String changeTyper(String type){
    if(type == "CARE"){
      return "케어/수선 신청 현황";
    }else if(type == "ACTIVATION"){
      return "정품인증 신청 현황";
    }else if(type == "CHANGE"){
      return "제품 사용자 변경";
    }else if(type == "SHOP"){
      return "SHOP";
    }else{
      return "1:1 문의사항";
    }
  }

  void pagingScrollListener() async {
    if(pagingScroll.position.pixels == pagingScroll.position.maxScrollExtent){
      print("스크롤이 최하단입니다. 다시 로딩합니다.");
      if(tabType == "HISTORY"){
        if (noticeListPaging.totalCount != progressNoticeList!.length) {
          this.pageIdx++;
          await reqAlarmList();
        }
      }else if(tabType == "CHANGE"){
        if (noticeListPaging.totalCount != productNoticeList!.length) {
          this.pageIdx++;
          await reqAlarmList();
        }
      }else if(tabType == "INQUIRY"){
        if (noticeListPaging.totalCount != inquiryNoticeList!.length) {
          this.pageIdx++;
          await reqAlarmList();
        }
      }
    }
  }

  Future<void> reqAlarmList() async {
    super.networkState.value = NetworkStateEnum.LOADING;
    final String? token = await SharedTokenUtil.getToken("userLogin_token");
    final res =  await MyProvider().alarmList(token!, tabType, pageIdx);
    super.networkState.value = NetworkStateEnum.DONE;
    if(res == null){
      Get.dialog(
          CustomDialogWidget(content: '서버와 접속이 원할 하지 않습니다.', onClick: (){
            Get.back();
            update();
          })
      );
    }else{
      final list = (res['list'] as List).map((e) => MainNoticeModel.fromJson(e)).toList();
      if(tabType == "HISTORY"){
        if (pageIdx == 1) {
          this.progressNoticeList = list;
        } else {
          for (var e in list) {
            this.progressNoticeList!.add(e);
          }
        }
      }else if(tabType == "CHANGE"){
        if (pageIdx == 1) {
          this.productNoticeList = list;
        } else {
          for (var e in list) {
            this.productNoticeList!.add(e);
          }
        }
      }else if(tabType == "INQUIRY"){
        if (pageIdx == 1) {
          this.inquiryNoticeList = list;
        } else {
          for (var e in list) {
            this.inquiryNoticeList!.add(e);
          }
        }
      }
      noticeListPaging = Paging.fromJson(res);
    }
    update();
  }

  String type = "not";
  String tabType = "HISTORY";

  void tabBarListener(int idx) async {
    print("현재 선택된 탭바 idx: $idx");
    currentPageIdx = idx;
    // shopNoticeList = <MainNoticeModel>[];
    if(!tabCtrl.indexIsChanging){
      if(idx == 0){
        progressNoticeList = <MainNoticeModel>[];
        pageIdx = 1;
        tabType = "HISTORY";
        update();
        await reqAlarmList();
      }else if(idx == 1){
        productNoticeList = <MainNoticeModel>[];
        pageIdx = 1;
        tabType = "CHANGE";
        update();
        await reqAlarmList();
      }else if(idx == 3){
        inquiryNoticeList = <MainNoticeModel>[];
        pageIdx = 1;
        tabType = "INQUIRY";
        update();
        await reqAlarmList();
      }
    }
    update();
  }

  void removeAllAlarms() async{
    final String? token = await SharedTokenUtil.getToken("userLogin_token");
    final res =  await MyProvider().removeAllAlarm(token!);
    if(res == null){
      Get.dialog(
          CustomDialogWidget(content: '서버와 접속이 원할 하지 않습니다.', onClick: (){
            Get.back();
            update();
          })
      );
      return;
    }
    await reqAlarmList();
  }

  void removeSelectAlarms(String type, int id) async{
    final String? token = await SharedTokenUtil.getToken("userLogin_token");
    final res =  await MyProvider().removeSelectAlarm(token!, type, id);
    if(res == null){
      Get.dialog(
          CustomDialogWidget(content: '서버와 접속이 원할 하지 않습니다.', onClick: (){
            Get.back();
            update();
          })
      );
      return;
    }
    await reqAlarmList();
  }



  void navigator(String type, int id) async{
    if(type == "CARE"){
      Get.toNamed("/mainAddCare/add/status", arguments: {
        "idx" : id,
        "back" : true,
      });
      await reqAlarmList();
    }else if(type == "ACTIVATION"){
      Get.to(() => AddGenuineStatusPage(), arguments: {
        'back' : true,
        'idx' : id,
      });
      await reqAlarmList();
    }else if(type == "CHANGE"){
      Get.toNamed("/main/my/change_product/history");
      removeSelectAlarms(type, id);
      await reqAlarmList();
    }else if(type == "INQUIRY"){
      Get.toNamed("/main/my/inquiry", arguments: 1);
      removeSelectAlarms(type, id);
      await reqAlarmList();
    }
  }

  @override
  void onInit() async{
    super.onInit();
    await reqAlarmList();
    pagingScroll.addListener(pagingScrollListener);
    tabCtrl.addListener(() => tabBarListener(tabCtrl.index));
  }

}