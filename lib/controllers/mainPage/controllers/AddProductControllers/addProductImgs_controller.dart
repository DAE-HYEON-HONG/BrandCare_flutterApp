import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';
import 'dart:io';

class AddProductImgsController extends BaseController {

  final ImagePicker imgPicker = ImagePicker();
  dynamic imgPickerErr;
  RxBool fill = false.obs;
  List<File>? pickImgList = <File>[];

  Rx<File> frontImg = File('').obs;
  Rx<File> backImg = File('').obs;
  Rx<File> leftImg = File('').obs;
  Rx<File> rightImg = File('').obs;

  void pictureChk(){
    if(frontImg.value.path.isEmpty ||
        backImg.value.path.isEmpty ||
        leftImg.value.path.isEmpty ||
        rightImg.value.path.isEmpty){
      fill.value = false;
      update();
    }else{
      fill.value = true;
      update();
    }
  }

  Future<void> loadAssets(String chkImg, ImageSource source) async {
    try{
      final pickedFile = await imgPicker.pickImage(
        source: source,
        maxWidth: 500,
        maxHeight: 500,
        imageQuality: 100,
        preferredCameraDevice: CameraDevice.rear,
      );
      if(chkImg == "front"){
        frontImg.value = File(pickedFile!.path);
        update();
        pictureChk();
        Get.back();
      }else if (chkImg == "back"){
        backImg.value = File(pickedFile!.path);
        update();
        pictureChk();
        Get.back();
      }else if (chkImg == "left"){
        leftImg.value = File(pickedFile!.path);
        update();
        pictureChk();
        Get.back();
      }else {
        rightImg.value = File(pickedFile!.path);
        update();
        pictureChk();
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
      pictureChk();
    }else if (chkImg == "back"){
      backImg.value = File('');
      update();
      pictureChk();
    }else if (chkImg == "left"){
      leftImg.value = File('');
      update();
      pictureChk();
    }else {
      rightImg.value = File('');
      update();
      pictureChk();
    }
  }

  Future<void> loadMoreAssets(ImageSource source) async {
    try{
      final pickedFile = await imgPicker.pickImage(
        source: source,
        maxWidth: 500,
        maxHeight: 500,
        imageQuality: 100,
        preferredCameraDevice: CameraDevice.rear,
      );
      pickImgList!.add(File(pickedFile!.path));
      update();
      pictureChk();
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
    if(fill.value){
      Get.toNamed('/mainAddProduct/addDescription');
    }
  }

  @override
  void onInit() {
    _cameraPermission();
    super.onInit();
  }
}