import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/global_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/addCareControllers/addCareEtc_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/addCare/addCareList_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/care/careCategory_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/care/careSubCategory_model.dart';
import 'package:brandcare_mobile_flutter_v2/providers/care_provider.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

import 'package:permission_handler/permission_handler.dart';

class AddCarePicController extends BaseController {

  RxBool fill = false.obs;
  final ImagePicker imgPicker = ImagePicker();
  Rx<File> careImg = File('').obs;
  GlobalController globalCtrl = Get.find<GlobalController>();

  final addCareEtc = Get.put(AddCareEtcController());

  RxString firstCareCategory = "".obs;
  RxString secondCareCategory = "".obs;
  int firstIdx = 999;
  int secondIdx = 999;
  RxInt price = 0.obs;
  List<CareSubCategoryModel> nothing = [
    CareSubCategoryModel(0, "", null, null),
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
    firstIdx = 999;
    secondIdx = 999;
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

  void firstIdxCategory(int idx){
    firstIdx = idx;
    update();
  }

  void secondCategory(String value){
    secondCareCategory.value = value;
    chkFill();
    update();
  }

  void secondIdxCategory(int idx){
    secondIdx = idx;
    update();
  }

  void choicePrice(int value){
    price.value = value;
    update();
  }

  void nextLevel(){
    if (fill.value){
      addCareEtc.addCareList = <AddCareListModel>[];
      addCareEtc.addCareList!.add(
        AddCareListModel(
          category: firstCareCategory.value,
          secondCategory: secondCareCategory.value,
          price: price.value,
          picture: careImg.value,
          categoryId: firstIdx,
          secondCategoryId: secondIdx,
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
          picture: careImg.value,
          categoryId: firstIdx,
          secondCategoryId: secondIdx,
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

  void cameraPermissionChk()async{
    await Permission.camera.request();
    await Permission.photos.request();
    var _cameraStatus = await Permission.camera.status.isGranted;
    var _galleryStatus = await Permission.photos.isGranted;
    if(_cameraStatus == false || _galleryStatus == false){
      Get.snackbar(
        '권한 알림', '카메라 및 갤러리 권한이 필요합니다.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(milliseconds: 1200),
      );
      Future.delayed(Duration(milliseconds: 1200), () => Get.back());
    }
  }

  @override
  void onInit() async{
    await globalCtrl.reqCareCategory();
    super.onInit();
    cameraPermissionChk();
  }
}