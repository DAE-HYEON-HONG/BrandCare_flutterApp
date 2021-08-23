import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddCarePicController extends BaseController {

  RxBool fill = false.obs;
  final ImagePicker imgPicker = ImagePicker();
  Rx<File> careImg = File('').obs;

  RxString firstCareCategory = "".obs;
  RxString secondCareCategory = "".obs;

  List<String> careList = [
    '가방', '지갑', '신발'
  ];



  Future<void> loadAssets(ImageSource source)async{
    try{
      final pickedFile = await imgPicker.pickImage(
        source: source,
        maxWidth: 500,
        maxHeight: 500,
        imageQuality: 10,
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

  void nextLevel(){
    if (fill.value){
      //Get.toNamed("/mainAddCare/add/etc");
    }
    Get.toNamed("/mainAddCare/add/etc");
  }

  @override
  void onInit() {
    super.onInit();
  }
}