import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/product/productDetail_model.dart';
import 'package:brandcare_mobile_flutter_v2/providers/product_provider.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:get/get.dart';

class ProductInfoController extends BaseController{

  ProductDetailModel? model;

  void getDetailProduct(int id) async {
    print(id);
    super.networkState.value = NetworkStateEnum.LOADING;
    var res = await ProductProvider().productDetail(id);
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



  @override
  void onClose() {
    super.onClose();
  }
}