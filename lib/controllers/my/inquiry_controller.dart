import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/providers/my_provider.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/onetoone_inquiry/inquiry_list_page.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/onetoone_inquiry/inquiry_page.dart';
import 'package:brandcare_mobile_flutter_v2/utils/shared_token_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InquiryController extends BaseController with SingleGetTickerProviderMixin {
  late TabController tabController;

  Rx<String> title = ''.obs;
  Rx<String> content = ''.obs;

  Future<void> addInquiry() async {
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
      if(res == null){
        Get.dialog(
            CustomDialogWidget(content: '서버와 접속이 원할 하지 않습니다.', onClick: (){
              Get.back();
              update();
            })
        );
      }else{
        tabController.index = 1;
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 2, vsync: this);
  }

  bool get isOn => title.value.isNotEmpty && content.value.isNotEmpty;
}