import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/product/productDetail_model.dart';
import 'package:brandcare_mobile_flutter_v2/providers/product_provider.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:get/get.dart';

class ProductInfoDetailController extends BaseController{

  int productIdx = Get.arguments;
  ProductDetailModel? model;

  Future<void> reqProductInfo()async{
    print(productIdx);
    super.networkState.value = NetworkStateEnum.LOADING;
    var res = await ProductProvider().productDetail(productIdx);
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

  Future<void> removeProduct() async {
    super.networkState.value = NetworkStateEnum.LOADING;
    var res = await ProductProvider().productRemove(productIdx);
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
      update();
    }
  }


  @override
  void onInit() async{
    await reqProductInfo();
    super.onInit();
  }
}