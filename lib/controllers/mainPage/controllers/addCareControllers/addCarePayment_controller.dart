import 'dart:convert';

import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/couponPoint/coupon_list_model.dart';
import 'package:brandcare_mobile_flutter_v2/providers/care_provider.dart';
import 'package:brandcare_mobile_flutter_v2/providers/my_provider.dart';
import 'package:brandcare_mobile_flutter_v2/utils/shared_token_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:dart_json_mapper/dart_json_mapper.dart';
import 'package:get/get.dart';
import 'addCareEtc_controller.dart';
import 'mainAddCare_controller.dart';
import 'package:iamport_flutter/model/payment_data.dart';

class AddCarePaymentController extends BaseController {

  RxInt countCoupon = 0.obs;
  RxInt myPoint = 0.obs;
  RxInt couponDiscount = 0.obs;
  int? couponIdx;
  RxInt pointDiscount = 0.obs;
  RxBool fill = false.obs;
  RxBool chkUserInfo = false.obs;
  String testAddress = "서울 구로구 디지털로 33길 28(구로동 170-5)우림 이비지센터 1차 1211호 (주)리드고";

  final addCareEtcCtrl = Get.find<AddCareEtcController>();
  final addCareMainCtrl = Get.find<MainAddCareController>();

  get currentPage => null;

  void resetCoupon() {
    couponIdx = null;
    couponDiscount.value = 0;
    update();
  }

  int allMountPrice() {
   int price = addPrices() - couponDiscount.value - pointDiscount.value;
   if(price < 0){
     return 0;
   }
   return price;
  }
  void changeUserInfo(){
    chkUserInfo.value = !chkUserInfo.value;
    if(chkUserInfo.value){
      fill.value = true;
      update();
      return;
    }
    fill.value = false;
    update();
  }

  void nextLevel(){
    if(chkUserInfo.value){
      Get.dialog(
        CustomDialogWidget(
          title: '케어/수선 신청 주의 사항',
          content: '요청사항과 신청 항목의\n금액으로 주문이 접수 되오니\n정확하게 신청해 주시기 바랍니다.',
          onClick: ()async{
            if(allMountPrice() != 0){
              payBrandCare();
              return;
            }
            await uploadAddCare();
            return;
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
    if(fill.value){
      fill.value = false;
      super.networkState = NetworkStateEnum.LOADING.obs;
      Map<String, String> addressBody = {
        "city" : addCareMainCtrl.senderAddress.text,
        "street" : addCareMainCtrl.senderAddressDetail.value,
        "zipCode" : addCareMainCtrl.senderPostCode.text,
      };
      Map<String, String> returnAddress = {
        "receiveCity" : addCareMainCtrl.receiverAddress.text,
        "receiveStreet" : addCareMainCtrl.receiverAddressDetail.value,
        "receiveZipCode" : addCareMainCtrl.receiverPostCode.text,
      };
      final res = await CareProvider().addCare(
        address: addressBody,
        list: addCareEtcCtrl.addCareList!,
        paymentAmount: allMountPrice(),
        phone: addCareMainCtrl.senderPhNum.text,
        receiverPhone: addCareMainCtrl.receiverPhNum.text,
        receiverName: addCareMainCtrl.receiverName.text,
        request_term: addCareEtcCtrl.etcDescription.text,
        returnAddress: returnAddress,
        senderName: addCareMainCtrl.senderName.text,
        usePointAmount: pointDiscount.value,
        couponId: couponIdx,
        returnType: addCareMainCtrl.returnReceiver.value ? "RECEIVER" : "SENDER",
        price: allMountPrice(),
      );
      await saveReceiverAddress();
      await saveSenderAddress();
      super.networkState = NetworkStateEnum.DONE.obs;
      fill.value = true;
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
  }

  void payBrandCare(){
    final paymentInfo = PaymentData(
      pg: "danal_tpay",
      payMethod: "card",
      name: "BrandCare 케어신청",
      buyerName: addCareMainCtrl.senderName.text,
      merchantUid: 'mid_${DateTime.now().millisecondsSinceEpoch}',
      // amount: allMountPrice(),
      amount: 1000,
      buyerTel: "02-111-1111",
      appScheme: "brandcare",
    );
    Get.back();
    Get.toNamed("/IamPayment", arguments: {"paymentInfo" : paymentInfo, "type" : "care"});
  }

  void careSuccess(int idx){
    Get.dialog(
      CustomDialogWidget(
        content: '신청이 완료되었습니다.',
        onClick: (){
          Get.toNamed('/mainAddCare/add/status', arguments: {
            "idx" : idx,
            "back" : false,
          });
        },
        isSingleButton: true,
        okTxt: "확인",
      ),
      barrierDismissible: false,
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

  Future<void> saveReceiverAddress() async{
    //받는 사람의 주소를 자동 저장
    if(addCareMainCtrl.receiverPostSet.value){
      final String? token = await SharedTokenUtil.getToken('userLogin_token');
      final res = await MyProvider().changeAddress(
          token!,
          addCareMainCtrl.receiverAddress.text,
          addCareMainCtrl.receiverAddressDetail.value,
          addCareMainCtrl.receiverPostCode.text,
      );
      print("받는 사람 주소 저장");
      print(res.toString());
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
    if(addCareMainCtrl.senderPostSet.value){
      final String? token = await SharedTokenUtil.getToken('userLogin_token');
      final res = await MyProvider().changeAddress(
        token!,
        addCareMainCtrl.senderAddress.text,
        addCareMainCtrl.senderAddressDetail.value,
        addCareMainCtrl.senderPostCode.text,
      );
      print("보내는 사람 주소 저장");
      print(res.toString());
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

  Future<void> reqCouponList() async {
    final String? token = await SharedTokenUtil.getToken("userLogin_token");
    final res =  await MyProvider().couponHistory(token!, 1);
    print(res);
    if(res == null){
      Get.dialog(
          CustomDialogWidget(content: '서버와 접속이 원할 하지 않습니다.', onClick: (){
            Get.back();
            update();
          })
      );
    }else{
      print(res.toString());
      countCoupon.value = (res['model']['countCoupon']);
      myPoint.value = (res['model']['point']);
    }
    update();
  }


  @override
  void onInit() async{
    super.onInit();
    await reqCouponList();
  }
}