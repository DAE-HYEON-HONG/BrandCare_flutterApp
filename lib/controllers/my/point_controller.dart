import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/addCareControllers/addCarePayment_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/addGenuinePayment_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/paging_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/point/point_list_info_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/point/point_list_model.dart';
import 'package:brandcare_mobile_flutter_v2/providers/my_provider.dart';
import 'package:brandcare_mobile_flutter_v2/utils/shared_token_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PointController extends BaseController{
  RxInt myPoint = 0.obs;
  Paging? pointListPaging;
  PointListModel? model;
  List<PointListInfoModel>? list;
  TextEditingController usePointCtrl = TextEditingController();
  ScrollController pagingScroll = ScrollController();
  RxString pointCode = RxString('');
  int page = 1;
  String? type;

  //추가 부분
  RxInt usePoint = 0.obs;

  int canUsePoint(){
    if(usePoint.value > myPoint.value){
      return 0;
    }
    return myPoint.value - usePoint.value;
  }

  void chkPoint(){
    if(myPoint.value < usePoint.value){
      Get.dialog(
          CustomDialogWidget(content: '사용가능 포인트 보다 많습니다.', onClick: (){
            usePoint.value = myPoint.value;
            usePointCtrl.text = myPoint.value.toString();
            Get.back();
            update();
          }),
        barrierDismissible: true,
      );
      return;
    }
  }

  void allUsePoint(){
    usePoint.value = myPoint.value;
    usePointCtrl.text = usePoint.value.toString();
    update();
  }

  void addUsePoint(){
    if(type == "care"){
      final addCarePaymentCtrl = Get.find<AddCarePaymentController>();
      addCarePaymentCtrl.myPoint.value = canUsePoint();
      addCarePaymentCtrl.pointDiscount.value = usePoint.value;
      if(addCarePaymentCtrl.allMountPrice() <  usePoint.value){
        addCarePaymentCtrl.pointDiscount.value = addCarePaymentCtrl.addPrices();
        addCarePaymentCtrl.myPoint.value = myPoint.value - addCarePaymentCtrl.addPrices();
      }
      addCarePaymentCtrl.update();
      Get.back();
    }else{
      final addGenuinePaymentCtrl = Get.find<AddGenuinePaymentController>();
      addGenuinePaymentCtrl.myPoint.value = canUsePoint();
      addGenuinePaymentCtrl.pointDiscount.value = usePoint.value;
      if(addGenuinePaymentCtrl.allPrice() <  usePoint.value){
        addGenuinePaymentCtrl.pointDiscount.value = addGenuinePaymentCtrl.allPrice();
        addGenuinePaymentCtrl.myPoint.value = myPoint.value - addGenuinePaymentCtrl.allPrice();
      }
      addGenuinePaymentCtrl.update();
      Get.back();
    }
  }

  void pagingScrollListener() async {
    if(pagingScroll.position.pixels == pagingScroll.position.maxScrollExtent){
      print('스크롤이 최하단입니다. 다시 로딩합니다.');
      if(pointListPaging!.totalCount != model!.response.list.length){
        this.page++;
        await reqPointHistory();
      }
    }
  }

  bool get isValidPointCode => pointCode.value != '' && pointCode.value.isNotEmpty && pointCode.value.length == 11;

  Future<void> reqPointHistory() async {
    final String? token = await SharedTokenUtil.getToken('userLogin_token');
    final res = await MyProvider().reqPoint(token!, page);
    if(res == null){
      Get.dialog(
          CustomDialogWidget(content: '서버와 접속이 원할 하지 않습니다.', onClick: (){
            Get.back();
            update();
          })
      );
    }else{
      final models = PointListModel.fromJson(res);
      myPoint.value = res['model']['point'];
      pointListPaging = Paging.fromJson(res['response']);
      if (page == 1) {
        this.list = models.response.list;
      } else {
        for (var e in models.response.list) {
          print(e);
          this.list!.add(e);
        }
      }
      update();
    }
  }

  addPoint() {
    //pointList.insert(0, PointSampleModel('포인트 코드 등록', 3000, '2021.08.20'));
   // myPoint += 3000;
    update();
  }

  @override
  void onInit() async{
    type = Get.arguments;
    update();
    await reqPointHistory();
    pagingScroll.addListener(pagingScrollListener);
    super.onInit();
  }

  @override
  void dispose() {
    pagingScroll.dispose();
    super.dispose();
  }
}