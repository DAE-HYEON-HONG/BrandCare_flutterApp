import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/changeProduct/change_product_enum.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChangeProductController extends BaseController with SingleGetTickerProviderMixin{

  late TabController tabController;

  String _requestString = '변경할 사용자의 확인을 기다리는 중입니다.\n"확인 중" 버튼을 누를 시 변경 요청이 취소 됩니다.';
  String _receivedString = '상대방이 확인을 기다리는 중입니다.\n"확인"을 누를 시 제품 사용자 변경이 완료 됩니다.';

  RxInt selectIdx = RxInt(-1);
  Rx<String> userEmail = ''.obs;
  Rx<bool> isChange = false.obs;

  String getTypeComment(ChangeProductEnum type) {
    String typeComment = "";
    switch(type) {
      case ChangeProductEnum.REQUEST:
        typeComment = _requestString;
        break;
      case ChangeProductEnum.REQUEST:
        typeComment = _receivedString;
    }
    return typeComment;
  }

  bool get isOn => selectIdx > -1 && userEmail.value.isNotEmpty && GetUtils.isEmail(userEmail.value);

  void updateSelectIdx(int idx) {
    selectIdx.value = idx;
    update();
  }

  void changeProductOwner() {
    Get.dialog(
        CustomDialogWidget(content: '변경할 사용자에게 모든 제품 정보가\n이동되며 복구할 수 없습니다.\n제품 사용자 변경을 진행 하시겠습니까?',
          onClick: (){
            Get.back();
            Get.toNamed('/main/my/change_product/apply/change');
          },
          isSingleButton: false,
          title: '제품 사용자 변경',
        )
    );
  }





  @override
  void onInit() {
    super.onInit();
    tabController = TabController(length: 4, vsync: this);
  }
}