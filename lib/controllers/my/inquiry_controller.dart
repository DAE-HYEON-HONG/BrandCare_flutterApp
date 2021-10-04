import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/paging_model.dart';
import 'package:brandcare_mobile_flutter_v2/providers/my_provider.dart';
import 'package:brandcare_mobile_flutter_v2/utils/shared_token_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:brandcare_mobile_flutter_v2/models/mypage/Inquiry/InquiryList_model.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InquiryController extends BaseController with SingleGetTickerProviderMixin {
  late TabController tabController = TabController(length: 2, vsync: this);

  Rx<String> title = ''.obs;
  Rx<String> content = ''.obs;

  TextEditingController titleCtrl = TextEditingController();
  TextEditingController contentsCtrl = TextEditingController();

  late Paging inquiryListPaging;
  List<InquiryListModel>? inquiryList = <InquiryListModel>[];
  ScrollController pagingScroll = ScrollController();
  int currentPage = 1;

  double autoHeight (BuildContext context){
    double height = MediaQuery.of(context).viewInsets.bottom == 0 ? 0 : 300;
    return height;
  }

  void pagingScrollListener() async {
    if(pagingScroll.position.pixels == pagingScroll.position.maxScrollExtent){
      print("스크롤이 최하단입니다. 다시 로딩합니다.");
      if (inquiryListPaging.totalCount != inquiryList!.length) {
        this.currentPage++;
        await reqQnaList();
      }
    }
  }

  Future<void> reqQnaList() async {
    final String? token = await SharedTokenUtil.getToken("userLogin_token");
    final res =  await MyProvider().getInquiry(token!, currentPage);
    if(res == null){
      Get.dialog(
          CustomDialogWidget(content: '서버와 접속이 원할 하지 않습니다.', onClick: (){
            Get.back();
            update();
          })
      );
    }else{
      final list = (res['list'] as List).map((e) => InquiryListModel.fromJson(e)).toList();
      if (currentPage == 1) {
        this.inquiryList = list;
      } else {
        for (var e in list) {
          this.inquiryList!.add(e);
        }
      }
      inquiryListPaging = Paging.fromJson(res);
      update();
    }
    update();
  }

  Future<void> addInquiry(context) async {
    if(title.value == ""){
      Get.dialog(
          CustomDialogWidget(content: '제목을 입력해주세요.', onClick: (){
            Get.back();
            update();
          })
      );
    }else if(content.value == ""){
      Get.dialog(
          CustomDialogWidget(content: '내용을 입력해주세요.', onClick: (){
            Get.back();
            update();
          })
      );
    }else{
      final String? token = await SharedTokenUtil.getToken("userLogin_token");
      final res =  await MyProvider().addInquiry(token!, title.value, content.value);
      title.value = "";
      content.value = "";
      titleCtrl.text = "";
      contentsCtrl.text = "";
      await reqQnaList();
      update();
      if(res == null){
        Get.dialog(
            CustomDialogWidget(content: '서버와 접속이 원할 하지 않습니다.', onClick: (){
              Get.back();
              update();
            })
        );
      }else{
        FocusScope.of(context).unfocus();
        tabController.index = 1;
      }
    }
  }

  @override
  void onInit() async {
    if(Get.arguments != null){
      if(Get.arguments == 1){
        tabController.index = 1;
        await reqQnaList();
      }
    }
    await reqQnaList();
    pagingScroll.addListener(pagingScrollListener);
    super.onInit();
  }

  @override
  void dispose() {
    pagingScroll.dispose();
    super.dispose();
  }

  bool get isOn => title.value.isNotEmpty && content.value.isNotEmpty;

}