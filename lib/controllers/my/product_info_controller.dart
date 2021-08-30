import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/product/product_change_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/product/product_detail_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/product/product_model.dart';
import 'package:brandcare_mobile_flutter_v2/providers/product_provider.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/changeProduct/change_product_enum.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ProductInfoController extends BaseController{

  ProductDetailModel? productDetailModel;
  final _productProvider = ProductProvider();

  void getDetailProduct(int id) async {
    super.networkState.value = NetworkStateEnum.LOADING;
    var json = await _productProvider.getProductDetail(id);
    super.networkState.value = NetworkStateEnum.DONE;
    print('json = $json');

    if(json != null) {
      productDetailModel = ProductDetailModel.fromJson(json);
      update();
    }

  }


  @override
  void onClose() {
    super.onClose();
  }
}