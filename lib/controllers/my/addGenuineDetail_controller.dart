import 'dart:io';
import 'dart:typed_data';
import 'package:brandcare_mobile_flutter_v2/apis/global_api_service.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/genuine/genuineDetail_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/idPathImages_model.dart';
import 'package:brandcare_mobile_flutter_v2/providers/product_provider.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'addGenuineStatus_controller.dart';

class AddGenuineDetailController extends BaseController {

  AddGenuineStatusController genuineStatusCtrl = Get.find<AddGenuineStatusController>();
  GenuineDetailModel? model;
  List<IdPathImagesModel> certificateList = <IdPathImagesModel>[];
  int productIdx = Get.arguments['idx'];
  List<IdPathImagesModel> mainImgModel = <IdPathImagesModel>[];
  Rx<int> pageNum = 0.obs;

  // void changeBannerImg(int idx) {
  //   this.pageNum.value = idx;
  //   update();
  // }

  Future<String> getFileName() async {
    Directory appDocumentDirectory = await getApplicationSupportDirectory();
    String appDocumentsPath = appDocumentDirectory.path;
    String filePath = '$appDocumentsPath';
    return filePath;
  }

  void saveFile() async {
    int i = 0;
    for(var file in certificateList){
      i += 1;
      var url = Uri.parse(GlobalApiService.getImage(file.path!));
      var res = await http.get(url);
      String directoryName = await getFileName();
      String imgName = "${model!.product.createdDate}$i";
      final localPath = path.join(directoryName, imgName);
      final result = await ImageGallerySaver.saveImage(
        Uint8List.fromList(res.bodyBytes),
        quality: 100,
        name: imgName,
      );
      print("${result.toString()} 이미지 다운로드");
      Get.back();
      Get.snackbar(
        '저장', '인증서가 다운로드 되었습니다.',
        snackPosition: SnackPosition.BOTTOM,
        duration: const Duration(milliseconds: 1200),
      );
    }
  }

  void cameraPermissionChk()async{
    if(await Permission.storage.request().isGranted){
      saveFile();
      return;
    }
    Get.snackbar(
      '권한 알림', '갤러리 저장 권한이 필요합니다.',
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(milliseconds: 1200),
    );
    Future.delayed(Duration(milliseconds: 1200), () => Get.back());
    return;
  }

  Future<void> reqGenuineDetailStatus() async {
    try{
      super.networkState.value = NetworkStateEnum.LOADING;
      final res =  await ProductProvider().genuineDetail(productIdx);
      if(res == null){
        Get.dialog(
            CustomDialogWidget(content: '서버와 접속이 원할 하지 않습니다.', onClick: (){
              Get.back();
              update();
            })
        );
      }else{
        model = GenuineDetailModel.fromJson(res);
        mainImgModel.add(IdPathImagesModel(1, model!.product.frontImage));
        mainImgModel.add(IdPathImagesModel(2, model!.product.backImage));
        mainImgModel.add(IdPathImagesModel(3, model!.product.leftImage));
        mainImgModel.add(IdPathImagesModel(4, model!.product.rightImage));
        if(model!.certificateImages != null){
          certificateList.add(model!.certificateImages!);
        }
        update();
        super.networkState.value = NetworkStateEnum.DONE;
      }
    }catch(e){
      print(e);
      super.networkState.value = NetworkStateEnum.ERROR;
    }
  }
  @override
  void onInit() async{
    super.onInit();
    await reqGenuineDetailStatus();
  }
}