import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/addCare/careInfo_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/addCare/careResult_model.dart';
import 'package:brandcare_mobile_flutter_v2/providers/care_provider.dart';
import 'package:brandcare_mobile_flutter_v2/utils/shared_token_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:get/get.dart';

class AddCareDetailController extends BaseController {

  CareResultModel? model;
  int productIdx = Get.arguments;
  Rx<int> pageNum = 0.obs;

  void changeBannerImg(int idx) {
    this.pageNum.value = idx;
    update();
  }

  Future<void> reqCareStatus() async {
    try{
      super.networkState.value = NetworkStateEnum.LOADING;
      final String? token = await SharedTokenUtil.getToken("userLogin_token");
      final res =  await CareProvider().careResult(token!, productIdx);
      if(res == null){
        Get.dialog(
            CustomDialogWidget(content: '서버와 접속이 원할 하지 않습니다.', onClick: (){
              Get.back();
              update();
            })
        );
      }else{
        model = CareResultModel.fromJson(res);
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
    await reqCareStatus();
  }
}