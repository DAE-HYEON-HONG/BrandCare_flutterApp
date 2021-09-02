import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/global_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/addCareControllers/addCareEtc_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/addCare/addCareList_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/care/careSubCategory_model.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddCarePicController extends BaseController {

  RxBool fill = false.obs;
  final ImagePicker imgPicker = ImagePicker();
  Rx<File> careImg = File('').obs;
  GlobalController globalCtrl = Get.find<GlobalController>();

  final addCareEtc = Get.put(AddCareEtcController());

  RxString firstCareCategory = "".obs;
  RxString secondCareCategory = "".obs;
  RxInt price = 0.obs;
  List<CareSubCategoryModel> nothing = [
    CareSubCategoryModel(0, "", 0, null),
  ].obs;

  List<CareSubCategoryModel> checkType(String type){
    if(type == "가방"){
      return globalCtrl.careCategory![0].subCategory;
    }
    else if (type == "지갑") {
      return globalCtrl.careCategory![1].subCategory;
    } else if (type == "신발") {
      return globalCtrl.careCategory![2].subCategory;
    } else {
      return nothing;
    }
  }

  void initInfo(){
    fill.value = false;
    careImg.value = File('');
    firstCareCategory.value = "";
    secondCareCategory.value = "";
    price.value = 0;
  }

  Future<void> loadAssets(ImageSource source)async{
    try{
      final pickedFile = await imgPicker.pickImage(
        source: source,
        maxWidth: 500,
        maxHeight: 500,
        imageQuality: 100,
        preferredCameraDevice: CameraDevice.rear,
      );
      careImg.value = File(pickedFile!.path);
      chkFill();
      update();
      Get.back();
    }catch(e){
      print(e.toString());
    }
  }

  void removeImg(){
    careImg.value = File('');
    chkFill();
    update();
  }

  void chkFill() {
    if(careImg.value.path != "" && firstCareCategory.value != "" && secondCareCategory.value != ""){
      fill.value = true;
    }else{
      fill.value = false;
    }
    update();
  }

  void firstCategory(String value){
    firstCareCategory.value = value;
    chkFill();
    update();
  }

  void secondCategory(String value){
    secondCareCategory.value = value;
    chkFill();
    update();
  }

  void choicePrice(int value){
    price.value = value;
    update();
  }

  void nextLevel(){
    if (fill.value){
      addCareEtc.addCareList!.add(
        AddCareListModel(
            category: firstCareCategory.value,
            secondCategory: secondCareCategory.value,
            price: price.value,
            picture: careImg.value
        ),
      );
      Get.toNamed("/mainAddCare/add/etc");
    }
  }

  void addList(){
    if (fill.value){
      addCareEtc.addCareList!.add(
        AddCareListModel(
            category: firstCareCategory.value,
            secondCategory: secondCareCategory.value,
            price: price.value,
            picture: careImg.value
        ),
      );
      addCareEtc.updateInfo();
      Get.back();
    }
  }

  void modifiedList(int idx){
    addCareEtc.addCareList![idx].category = firstCareCategory.value;
    addCareEtc.addCareList![idx].secondCategory = secondCareCategory.value;
    addCareEtc.addCareList![idx].price = price.value;
    addCareEtc.addCareList![idx].picture = careImg.value;
    addCareEtc.updateInfo();
    Get.back();
  }

  void modifiedInit(File img, String category, String secondCategory){
    firstCareCategory.value = category;
    secondCareCategory.value = secondCategory;
    careImg.value = img;
    update();
  }

  @override
  void onInit() {
    super.onInit();
  }
}