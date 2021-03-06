import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/mypage/terms/terms_model.dart';
import 'package:brandcare_mobile_flutter_v2/providers/my_provider.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:get/get.dart';

class TermsController extends BaseController {
  List<TermsModel>? termsList = <TermsModel>[];
  bool isLoaded = false;

  Future<void> termsController() async {

    super.networkState.value = NetworkStateEnum.LOADING;
    final res = await MyProvider().getTerms();
    if(res == null){
      Get.dialog(
          CustomDialogWidget(content: '서버와 접속이 원할 하지 않습니다.', onClick: (){
            Get.back();
            update();
          })
      );
    }else{
      final list = (res['data'] as List).map((e) => TermsModel.fromJson(e)).toList();
      for (var e in list) {
        this.termsList!.add(e);
      }
      isLoaded = true;
      update();
      super.networkState.value = NetworkStateEnum.DONE;
    }
  }

  @override
  void onInit() async{
    super.onInit();
    await termsController();
  }
}