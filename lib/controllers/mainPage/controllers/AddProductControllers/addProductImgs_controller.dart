import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';
import 'dart:io';

class AddProductImgsController extends BaseController {

  final ImagePicker imgPicker = ImagePicker();
  dynamic imgPickerErr;
  RxBool fill = true.obs;
  List<XFile>? pickImgList = <XFile>[];

  Rx<File> frontImg = File('').obs;
  Rx<File> backImg = File('').obs;
  Rx<File> leftImg = File('').obs;
  Rx<File> rightImg = File('').obs;


  Future<void> loadAssets(String chkImg, ImageSource source) async {
    try{
      final pickedFile = await imgPicker.pickImage(
        source: source,
        maxWidth: 500,
        maxHeight: 500,
        imageQuality: 10,
        preferredCameraDevice: CameraDevice.rear,
      );
      if(chkImg == "front"){
        frontImg.value = File(pickedFile!.path);
        update();
        Get.back();
      }else if (chkImg == "back"){
        backImg.value = File(pickedFile!.path);
        update();
        Get.back();
      }else if (chkImg == "left"){
        leftImg.value = File(pickedFile!.path);
        update();
        Get.back();
      }else {
        rightImg.value = File(pickedFile!.path);
        update();
        Get.back();
      }
    }catch(e){
      imgPickerErr = e;
      update();
    }
  }

  void removeImg(String chkImg){
    if(chkImg == "front"){
      frontImg.value = File('');
      update();
    }else if (chkImg == "back"){
      backImg.value = File('');
      update();
    }else if (chkImg == "left"){
      leftImg.value = File('');
      update();
    }else {
      rightImg.value = File('');
      update();
    }
  }

  Future<void> loadMoreAssets(ImageSource source) async {
    try{
      final pickedFile = await imgPicker.pickImage(
        source: source,
        maxWidth: 500,
        maxHeight: 500,
        imageQuality: 10,
        preferredCameraDevice: CameraDevice.rear,
      );
      pickImgList!.add(pickedFile!);
      update();
      Get.back();
    }catch(e){
      print(e.toString());
    }
  }

  void removeListAssets(dynamic obj){
    pickImgList!.remove(obj);
    update();
  }

  Future<void>_cameraPermission() async {
    if(await Permission.photos.request().isDenied){
      print("카메라 권한 거부");
      Get.back();
    }else{
      print("카메라 및 갤러리 권한 허용됨");
    }
  }

  void nextLevel() {
    Get.toNamed('/mainAddProduct/addDescription');
  }

  @override
  void onInit() {
    _cameraPermission();
    super.onInit();
  }
}