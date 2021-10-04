import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/mypage/banner/banner_model.dart';
import 'package:brandcare_mobile_flutter_v2/providers/my_provider.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';
import 'package:url_launcher/url_launcher.dart';

class UseInfoEventController extends BaseController{

  List<BannerModel>? bannerList;

  void launchURL(url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  Future<void> reqBannerList() async {
    final res =  await MyProvider().getBanner("EVENT");
    if(res == null){
      Get.dialog(
          CustomDialogWidget(content: '서버와 접속이 원할 하지 않습니다.', onClick: (){
            Get.back();
            update();
          })
      );
    }else{
      print(res.toString());
      bannerList = (res['data'] as List).map((e) => BannerModel.fromJson(e)).toList();
      update();
    }
    update();
  }

  @override
  void onInit() async{
    await reqBannerList();
    super.onInit();
  }
}