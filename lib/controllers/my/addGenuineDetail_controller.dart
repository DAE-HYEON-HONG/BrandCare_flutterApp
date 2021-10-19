import 'dart:io';
import 'dart:typed_data';
import 'package:brandcare_mobile_flutter_v2/apis/global_api_service.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/genuine/genuineDetail_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/idPathImages_model.dart';
import 'package:brandcare_mobile_flutter_v2/providers/my_provider.dart';
import 'package:brandcare_mobile_flutter_v2/providers/product_provider.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:image_gallery_saver/image_gallery_saver.dart';
import 'package:get/get.dart';
import 'package:path_provider/path_provider.dart';
import 'package:http/http.dart' as http;
import 'package:permission_handler/permission_handler.dart';
import 'package:url_launcher/url_launcher.dart';
import 'addGenuineStatus_controller.dart';

class AddGenuineDetailController extends BaseController {

  AddGenuineStatusController genuineStatusCtrl = Get.find<AddGenuineStatusController>();
  GenuineDetailModel? model;
  List<IdPathImagesModel> certificateList = <IdPathImagesModel>[];
  int productIdx = Get.arguments['idx'];
  List<IdPathImagesModel> mainImgModel = <IdPathImagesModel>[];
  Rx<int> pageNum = 0.obs;


  void launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void sendFile(String email)async{
    try{
      super.networkState.value = NetworkStateEnum.LOADING;
      final res =  await MyProvider().sendFileEmail(email: email);
      super.networkState.value = NetworkStateEnum.DONE;
      if(res == null){
        Get.dialog(
            CustomDialogWidget(content: '서버와 접속이 원할 하지 않습니다.', onClick: (){
              Get.back();
              update();
            })
        );
      }
    }catch(e){
      print(e.toString());
    }
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