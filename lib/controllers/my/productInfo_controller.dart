import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/my_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/my_product_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/product/productDetail_model.dart';
import 'package:brandcare_mobile_flutter_v2/providers/product_provider.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:get/get.dart';

class ProductInfoDetailController extends BaseController{

  int? productIdx;
  ProductDetailModel? model;
  RxBool downDetail = false.obs;
  MyProductController myProductCtrl = Get.find<MyProductController>();
  MyController myController = Get.find<MyController>();

  Future<void> reqProductInfo()async{
    super.networkState.value = NetworkStateEnum.LOADING;
    var res = await ProductProvider().productDetail(productIdx!);
    print(res.toString());
    if(res == null){
      Get.dialog(
          CustomDialogWidget(content: '서버와 접속이 원할 하지 않습니다.', onClick: (){
            Get.back();
            update();
          })
      );
      super.networkState.value = NetworkStateEnum.ERROR;
    }else{
      model = res;
      super.networkState.value = NetworkStateEnum.DONE;
      update();
    }
  }

  void removeProductAsk(){
    Get.dialog(
        CustomDialogWidget(content: '삭제한 제품은 복구되지 않습니다.\n정말 삭제 하시겠습니까?',
          onClick: () async{
            await removeProduct();
          },
          isSingleButton: false,
          title: '제품삭제',
        ),
        barrierDismissible: false
    );
  }

  Future<void> removeProduct() async {
    Get.dialog(
      CustomDialogWidget(
        title: '삭제 시 주의 사항',
        content: '삭제 시 복구 되지 않습니다.\n정말 삭제 하시겠습니까?',
        onClick: () async{
          super.networkState.value = NetworkStateEnum.LOADING;
          var res = await ProductProvider().productRemove(productIdx!);
          if(res == null){
            Get.dialog(
                CustomDialogWidget(content: '서버와 접속이 원할 하지 않습니다.', onClick: (){
                  Get.back();
                  update();
                })
            );
            super.networkState.value = NetworkStateEnum.ERROR;
          }else{
            super.networkState.value = NetworkStateEnum.DONE;
            myProductCtrl.reqProductList();
            await myController.myInfo();
            myController.myDataInfo();
            myController.update();
            update();
            Get.dialog(
              CustomDialogWidget(content: '삭제되었습니다.', onClick: ()async{
                Get.back();
                Get.back();
                Get.back();
                await myProductCtrl.reqProductList();
                myProductCtrl.update();
                update();
              }),
              barrierDismissible: false,
            );
          }
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

  void onDown(){
    downDetail.value = !downDetail.value;
    update();
  }


  @override
  void onInit() async{
    productIdx = Get.arguments['id'];
    update();
    super.onInit();
    await reqProductInfo();
  }
}