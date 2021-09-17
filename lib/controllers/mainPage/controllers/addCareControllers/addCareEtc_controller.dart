import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/addCare/addCareList_model.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/addCarePages/addCareModified_page.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';

class AddCareEtcController extends BaseController{
  RxBool fill = false.obs;
  TextEditingController etcDescription = TextEditingController();

  List<AddCareListModel>? addCareList = <AddCareListModel>[];

  double autoHeight (BuildContext context){
    double height = MediaQuery.of(context).viewInsets.bottom == 0 ? 0 : 200;
    return height;
  }

  void nextLevel(){
    if(fill.value){
      Get.toNamed('/mainAddCare/add/payment');
    }
  }

  void fillChange(){
    if(etcDescription.text != ""){
      fill.value = true;
      update();
      return;
    }
    fill.value = false;
    update();
  }

  void removeList(AddCareListModel obj){
    if(addCareList!.length == 1){
      Get.dialog(
        CustomDialogWidget(content: '1개 이상 부터 삭제 가능합니다.', onClick: (){
          Get.back();
          update();
        }),
      );
    }else{
      addCareList!.remove(obj);
      update();
    }
  }

  void modifiedProduct(int idx){
    Get.to(AddCareModifiedPage(
      category: addCareList![idx].category,
      secondCategory: addCareList![idx].secondCategory,
      idx: idx,
      img: addCareList![idx].picture,
    ));
    update();
  }

  updateInfo(){
    update();
  }

  @override
  void onInit() {
    super.onInit();
  }
}