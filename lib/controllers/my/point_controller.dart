import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:get/get.dart';

class PointSampleModel {
  final String title;
  final int point;
  final String date;

  PointSampleModel(this.title, this.point, this.date);
}
class PointController extends BaseController{
  int myPoint = 10050;
  List<PointSampleModel> pointList = [
    PointSampleModel('케어/수선', 10, '2021.08.02'),
    PointSampleModel('케어/수선', -5000, '2021.08.02'),
    PointSampleModel('포인트 코드 등록', 5000, '2021.08.02'),
    PointSampleModel('친구 초대', 5000, '2021.08.02'),
    PointSampleModel('친구 초대', 5000, '2021.08.02'),
    PointSampleModel('케어/수선', 10, '2021.08.02'),
    PointSampleModel('케어/수선', 10, '2021.08.02'),
    PointSampleModel('케어/수선', 10, '2021.08.02'),
    PointSampleModel('케어/수선', 10, '2021.08.02'),
  ];
  RxString pointCode = RxString('');

  addPoint() {
    pointList.insert(0, PointSampleModel('포인트 코드 등록', 3000, '2021.08.20'));
    myPoint += 3000;
    update();
  }
  bool get isValidPointCode => pointCode.value != '' && pointCode.value.isNotEmpty && pointCode.value.length == 11;

}