import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:get/get.dart';

class AddCarePaymentController extends BaseController {

  RxBool fill = false.obs;
  RxBool chkUserInfo = false.obs;
  String testAddress = "서울 구로구 디지털로 33길 28(구로동 170-5)우림 이비지센터 1차 1211호 (주)리드고";

  void changeUserInfo(){
    chkUserInfo.value = !chkUserInfo.value;
    update();
  }

  void nextLevel(){
    Get.dialog(
      CustomDialogWidget(
        title: '케어/수선 신청 주의 사항',
        content: '요청사항과 신청 암공의 금액으로 주문이 접수 되오니 정확하게 신청해 주시기 바랍니다.\n만약, 첨부사진과 신청항목이 다를 경우 주문이 취소되오니 이점 참고하여 주시기 바랍니다.',
        onClick: (){
          testSuccess();
          update();
        },
        onCancelClick: () {
          Get.back();
        },
        isSingleButton: false,
        okTxt: "예",
        cancelTxt: "아니오",
      ),
    );
  }

  void testSuccess(){
    Get.dialog(
      CustomDialogWidget(
        content: '신청이 완료되었습니다.',
        onClick: (){
          Get.back();
          update();
        },
        isSingleButton: true,
        okTxt: "확인",
      ),
    );
  }

  @override
  void onInit() {
    super.onInit();
  }
}