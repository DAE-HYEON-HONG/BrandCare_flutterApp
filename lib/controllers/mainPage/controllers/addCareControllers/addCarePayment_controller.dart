import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/providers/care_provider.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:get/get.dart';
import 'addCareEtc_controller.dart';
import 'mainAddCare_controller.dart';

class AddCarePaymentController extends BaseController {

  RxInt couponDiscount = 0.obs;
  RxInt pointDiscount = 0.obs;
  RxBool fill = false.obs;
  RxBool chkUserInfo = false.obs;
  String testAddress = "서울 구로구 디지털로 33길 28(구로동 170-5)우림 이비지센터 1차 1211호 (주)리드고";

  final addCareEtcCtrl = Get.find<AddCareEtcController>();
  final addCareMainCtrl = Get.find<MainAddCareController>();

  int allPrice() {
   int price = addPrices() + 3000 - couponDiscount.value - pointDiscount.value;
   return price;
  }
  void changeUserInfo(){
    chkUserInfo.value = !chkUserInfo.value;
    if(chkUserInfo.value){
      fill.value = true;
      update();
    }
    update();
  }

  void nextLevel(){
    if(chkUserInfo.value){
      Get.dialog(
        CustomDialogWidget(
          title: '케어/수선 신청 주의 사항',
          content: '요청사항과 신청 항목의 금액으로 주문이 접수 되오니 정확하게 신청해 주시기 바랍니다.\n만약, 첨부사진과 신청항목이 다를 경우 주문이 취소되오니 이점 참고하여 주시기 바랍니다.',
          onClick: () async{
            await uploadAddCare();
            //testSuccess();
            //update();
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
  }

  Future<void> uploadAddCare() async{
    Map<String, String> addressBody = {
      "city" : addCareMainCtrl.senderAddress.text,
      "street" : addCareMainCtrl.senderAddressDetail.value,
      "zipCode" : addCareMainCtrl.senderPostCode.text,
    };
    Map<String, String> returnAddress = {
      "city" : addCareMainCtrl.receiverAddress.text,
      "street" : addCareMainCtrl.receiverAddressDetail.value,
      "zipCode" : addCareMainCtrl.receiverPostCode.text,
    };
    final res = await CareProvider().addCare(
      address: addressBody,
      list: addCareEtcCtrl.addCareList!,
      paymentAmount: allPrice(),
      phone: addCareMainCtrl.senderPhNum.text,
      receiverName: addCareMainCtrl.receiverName.text,
      request_term: addCareEtcCtrl.etcDescription.text,
      returnAddress: returnAddress,
      senderName: addCareMainCtrl.senderName.text,
      usePointAmount: pointDiscount.value,
      couponId: null,
      returnType: addCareMainCtrl.returnReceiver.value ? "receiver" : "sender",
    );
    if(res == null){
      Get.dialog(
          CustomDialogWidget(content: '서버와 접속이 원할 하지 않습니다.', onClick: (){
            Get.back();
            update();
          }),
      );
    }else{
      print(res['data']);
      if(res['data'] == "Y"){
        careSuccess();
      }
    }
  }

  void careSuccess(){
    Get.dialog(
      CustomDialogWidget(
        content: '신청이 완료되었습니다.',
        onClick: (){
          Get.toNamed('/mainAddCare/add/status', arguments: 1070);
        },
        isSingleButton: true,
        okTxt: "확인",
      ),
    );
  }

  int addPrices(){
    int price = 0;
    int length = addCareEtcCtrl.addCareList!.length;
    for(var i = 0; i < length; i++){
      price += addCareEtcCtrl.addCareList![i].price;
    }
    return price;
  }


  @override
  void onInit() {
    super.onInit();
  }
}