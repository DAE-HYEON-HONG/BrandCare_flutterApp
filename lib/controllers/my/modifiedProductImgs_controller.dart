import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/productInfo_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/idPathFileImages_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/idPathImages_model.dart';
import 'package:brandcare_mobile_flutter_v2/screens/mainPage/pages/my/product/modifiedProductDes_page.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:get/get.dart';
import 'dart:io';

class ModifiedProductImgsController extends BaseController {

  final productInfoDetailCtrl = Get.find<ProductInfoDetailController>();
  final ImagePicker imgPicker = ImagePicker();
  dynamic imgPickerErr;
  RxBool fill = true.obs;
  List<IdPathFileImagesModel>? imgList = <IdPathFileImagesModel>[];
  List<int>? removeImgIdx = [];
  List<String>? removeMainImg = [];
  Rx<File> frontImg = File('').obs;
  Rx<File> backImg = File('').obs;
  Rx<File> leftImg = File('').obs;
  Rx<File> rightImg = File('').obs;

  String frontImgPath = "";
  String backImgPath = "";
  String leftImgPath = "";
  String rightImgPath = "";

  void initImages(){
    //이미지들 초기화
    if(productInfoDetailCtrl.model!.image != null){
      for(var file in productInfoDetailCtrl.model!.image!){
        imgList!.add(
            IdPathFileImagesModel(file.id, file.path, File(''))
        );
      }
    }
    print(imgList!.length);
    frontImgPath = productInfoDetailCtrl.model!.frontImage ?? "";
    backImgPath = productInfoDetailCtrl.model!.backImage ?? "";
    leftImgPath = productInfoDetailCtrl.model!.leftImage ?? "";
    rightImgPath = productInfoDetailCtrl.model!.rightImage ?? "";
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

  void removeUploadedImg(String chkImg){
    if(chkImg == "front"){
      frontImgPath = "";
      removeMainImg!.add("f");
      update();
    }else if (chkImg == "back"){
      backImgPath = "";
      removeMainImg!.add("b");
      update();
    }else if (chkImg == "left"){
      leftImgPath = "";
      removeMainImg!.add("l");
      update();
    }else {
      rightImgPath = "";
      removeMainImg!.add("r");
      update();
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
      imgList!.add(IdPathFileImagesModel(null, "", File(pickedFile!.path)));
      update();
      Get.back();
    }catch(e){
      print(e.toString());
    }
  }

  void removeListAssets(IdPathFileImagesModel obj){
    imgList!.remove(obj);
    if(obj.id != null){
      removeImgIdx!.add(obj.id!);
    }
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
    print(removeMainImg.toString());
    if(fill.value){
      Get.to(() => ModifiedProductDesPage());
    }
  }

  @override
  void onInit() {
    initImages();
    _cameraPermission();
    super.onInit();
  }
}