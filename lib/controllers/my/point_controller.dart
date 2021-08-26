import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:brandcare_mobile_flutter_v2/models/mypage/point/pointList_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/paging_model.dart';
import 'package:brandcare_mobile_flutter_v2/providers/my_provider.dart';
import 'package:brandcare_mobile_flutter_v2/utils/shared_token_util.dart';
import 'package:brandcare_mobile_flutter_v2/widgets/custom_dialog_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class PointController extends BaseController{
  RxInt myPoint = 0.obs;
  late Paging pointListPaging;
  List<PointListModel>? pointList = <PointListModel>[];
  ScrollController pagingScroll = ScrollController();
  RxString pointCode = RxString('');
  int page = 1;

  void pagingScrollListener() async {
    if(pagingScroll.position.pixels == pagingScroll.position.maxScrollExtent){
      print('스크롤이 최하단입니다. 다시 로딩합니다.');
      if(pointListPaging.totalCount != pointList!.length){
        this.page++;
        await reqPointHistory();
      }
    }
  }

  bool get isValidPointCode => pointCode.value != '' && pointCode.value.isNotEmpty && pointCode.value.length == 11;

  Future<void> reqPointHistory() async {
    final String? token = await SharedTokenUtil.getToken('userLogin_token');
    final res = await MyProvider().pointHistory(token!, page);
    if(res == null){
      Get.dialog(
          CustomDialogWidget(content: '서버와 접속이 원할 하지 않습니다.', onClick: (){
            Get.back();
            update();
          })
      );
    }else{
      final list = (res['response']['list'] as List).map((e) => PointListModel.fromJson(e)).toList();
      pointListPaging = Paging.fromJson(res['response']);
      if (page == 1) {
        this.pointList = list;
      } else {
        for (var e in list) {
          this.pointList!.add(e);
        }
      }
      myPoint.value = (res['model']['point']);
      update();
    }
  }

  addPoint() {
    //pointList.insert(0, PointSampleModel('포인트 코드 등록', 3000, '2021.08.20'));
   // myPoint += 3000;
    update();
  }

  @override
  void onInit() async{
    await reqPointHistory();
    pagingScroll.addListener(pagingScrollListener);
    super.onInit();
  }

  @override
  void dispose() {
    pagingScroll.dispose();
    super.dispose();
  }
}