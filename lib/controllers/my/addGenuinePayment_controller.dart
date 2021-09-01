import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/addGenuineEtc_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/addGenuine_controller.dart';
import 'package:brandcare_mobile_flutter_v2/providers/care_provider.dart';
import 'package:brandcare_mobile_flutter_v2/providers/my_provider.dart';
import 'package:brandcare_mobile_flutter_v2/providers/product_provider.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/product/addGenuineStatus_page.dart';
import 'package:brandcare_mobile_flutter_v2/utils/shared_token_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:get/get.dart';

class AddGenuinePaymentController extends BaseController {

  RxInt couponDiscount = 0.obs;
  RxInt pointDiscount = 0.obs;
  RxBool fill = false.obs;
  RxBool chkUserInfo = false.obs;
  String testAddress = "서울 구로구 디지털로 33길 28(구로동 170-5)우림 이비지센터 1차 1211호 (주)리드고";

  final addGenuineCtrl = Get.find<AddGenuineController>();
  final addGenuineEtcCtrl = Get.find<AddGenuineEtcController>();

  int allPrice() {
   int price = addGenuineEtcCtrl.addPrices() + 3000 - couponDiscount.value - pointDiscount.value;
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
          title: '정품인증 신청 주의 사항',
          content: '요청사항과 신청 항목의 금액으로 주문이 접수 되오니 정확하게 신청해 주시기 바랍니다.\n만약, 첨부사진과 신청항목이 다를 경우 주문이 취소되오니 이점 참고하여 주시기 바랍니다.',
          onClick: () async{
            await uploadAdd();
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

  Future<void> uploadAdd() async{
    Map<String, String> addressBody = {
      "city" : addGenuineCtrl.senderAddress.text,
      "street" : addGenuineCtrl.senderAddressDetail.value,
      "zipCode" : addGenuineCtrl.senderPostCode.text,
    };
    Map<String, String> returnAddress = {
      "receiveCity" : addGenuineCtrl.receiverAddress.text,
      "receiveStreet" : addGenuineCtrl.receiverAddressDetail.value,
      "receiveZipCode" : addGenuineCtrl.receiverPostCode.text,
    };
    final res = await ProductProvider().addGenuine(
      address: addressBody,
      list: addGenuineEtcCtrl.priceList,
      paymentAmount: addGenuineEtcCtrl.addPrices(),
      phone: addGenuineCtrl.senderPhNum.text,
      receiverPhone: addGenuineCtrl.receiverPhNum.text,
      receiverName: addGenuineCtrl.receiverName.text,
      request_term: addGenuineEtcCtrl.des.text,
      returnAddress: returnAddress,
      senderName: addGenuineCtrl.senderName.text,
      usePointAmount: pointDiscount.value,
      couponId: null,
      returnType: addGenuineCtrl.returnReceiver.value ? "RECEIVER" : "SENDER",
      price: allPrice(),
      productId: addGenuineCtrl.productIdx,
    );
    await saveReceiverAddress();
    await saveSenderAddress();
    if(res == null){
      Get.dialog(
          CustomDialogWidget(content: '서버와 접속이 원할 하지 않습니다.', onClick: (){
            Get.back();
            update();
          }),
      );
    }else{
      print(res['data']);
      if(res['data'] != ""){
        careSuccess(int.parse(res['data']));
      }
    }
  }

  void careSuccess(int idx){
    Get.dialog(
      CustomDialogWidget(
        content: '신청이 완료되었습니다.',
        onClick: (){
          Get.to(() => AddGenuineStatusPage(), arguments: {
            "idx" : idx,
            "back" : false,
          });
        },
        isSingleButton: true,
        okTxt: "확인",
      ),
    );
  }

  Future<void> saveReceiverAddress() async{
    //받는 사람의 주소를 자동 저장
    if(addGenuineCtrl.receiverPostSet.value){
      final String? token = await SharedTokenUtil.getToken('userLogin_token');
      final res = await MyProvider().changeAddress(
        token!,
        addGenuineCtrl.receiverAddress.text,
        addGenuineCtrl.receiverAddressDetail.value,
        addGenuineCtrl.receiverPostCode.text,
      );
      if(!res){
        Get.dialog(
          CustomDialogWidget(content: '서버와 접속이 원할 하지 않습니다.', onClick: (){
            Get.back();
            update();
          }),
        );
      }
    }
  }

  Future<void> saveSenderAddress() async {
    //보내는 사람의 주소를 자동저장
    if(addGenuineCtrl.senderPostSet.value){
      final String? token = await SharedTokenUtil.getToken('userLogin_token');
      final res = await MyProvider().changeAddress(
        token!,
        addGenuineCtrl.senderAddress.text,
        addGenuineCtrl.senderAddressDetail.value,
        addGenuineCtrl.senderPostCode.text,
      );
      if(!res){
        Get.dialog(
          CustomDialogWidget(content: '서버와 접속이 원할 하지 않습니다.', onClick: (){
            Get.back();
            update();
          }),
        );
      }
    }
  }


  @override
  void onInit() {
    super.onInit();
  }
}