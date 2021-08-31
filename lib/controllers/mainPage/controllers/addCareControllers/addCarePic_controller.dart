import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/mainPage/controllers/addCareControllers/addCareEtc_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/addCare/addCareList_model.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';

class AddCarePicController extends BaseController {

  RxBool fill = false.obs;
  final ImagePicker imgPicker = ImagePicker();
  Rx<File> careImg = File('').obs;

  final addCareEtc = Get.put(AddCareEtcController());

  RxString firstCareCategory = "".obs;
  RxString secondCareCategory = "".obs;
  RxInt price = 0.obs;

  List<Map<String, int>>careList = [
    {
      "가방" : 0,
      "isOdd": 0,
    },
    {
      "지갑" : 0,
      "isOdd": 0,
    },
    {
      "신발" : 0,
      "isOdd": 0,
    },
  ];

  List<Map<String, int>> bagPrice = [
    {
      "끈길이 줄임" : 25000,
      "isOdd": 0,
    },
    {
      "지퍼헤드교체" : 25000,
      "isOdd": 0,
    },
    {
      "지퍼교체" : 25000,
      "isOdd": 0,
    },
    {
      "안감교체" : 25000,
      "isOdd": 0,
    },
    {
      "장식교체" : 25000,
      "isOdd": 1,
    },
    {
      "장식도금" : 25000,
      "isOdd": 1,
    },
    {
      "전체염색" : 25000,
      "isOdd": 0,
    },
    {
      "가죽복원/크리닝 포함(가능한소재에 한함)" : 25000,
      "isOdd": 0,
    },
    {
      "크리닝" : 25000,
      "isOdd": 0,
    },
    {
      "스웨이드 크리닝" : 25000,
      "isOdd": 0,
    },
  ].obs;

  List<Map<String, int>> walletPrice = [
    {
      "크리닝" : 40000,
      "isOdd": 0,
    },
    {
      "가죽복원/크리닝 포함(가능한 소재에 한함)" : 60000,
      "isOdd": 0,
    },
    {
      "염색" : 50000,
      "isOdd": 0,
    },
    {
      "지갑박음질" : 5000,
      "isOdd": 1,
    },
    {
      "지퍼교체" : 30000,
      "isOdd": 0,
    },
    {
      "지퍼헤드교체" : 15000,
      "isOdd": 0,
    },
    {
      "장식교체" : 0,
      "isOdd": 0,
    },
    {
      "안감교체" : 100000,
      "isOdd": 0,
    },
  ].obs;

  List<Map<String, dynamic>> shoesPrice = [
    {
      "밑창보강" : 20000,
      "isOdd": "국산창",
    },
    {
      "밑창보강" : 50000,
      "isOdd": "수입창",
    },
    {
      "가죽복원/크리닝포함(가능한 소재에 한함)" : 50000,
      "isOdd": "2켤레",
    },
    {
      "염색" : 80000,
      "isOdd": "2켤레",
    },
    {
      "부츠 크리닝" : 60000,
      "isOdd": "2켤레",
    },
    {
      "구두, 로퍼 크리닝" : 20000,
      "isOdd": "2켤레",
    },
    {
      "스웨이드 크리닝" : 50000,
      "isOdd": "2켤레",
    },
    {
      "운동화 크리닝" : 15000,
      "isOdd": "2켤레",
    },
    {
      "어그부츠 크리닝" : 30000,
      "isOdd": "2켤레",
    },
    {
      "재박음질" : 5000,
      "isOdd": "2켤레",
    },
  ].obs;

  List<Map<String, dynamic>> nothing = [
    {
      "항목없음" : 0,
      "isOdd": 0,
    }
  ].obs;

  List<Map<String, dynamic>> checkType(String type){
    if(type == "가방"){
      return bagPrice;
    }
    else if (type == "지갑") {
      return walletPrice;
    } else if (type == "신발") {
      return shoesPrice;
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