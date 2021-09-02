import 'package:brandcare_mobile_flutter_v2/controllers/auth/find_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/notice_controller.dart';
import 'package:brandcare_mobile_flutter_v2/controllers/my/question_controller.dart';
import 'package:get/get.dart';

class QuestionBinding implements Bindings {
  @override
  void dependencies() {
    Get.put(QuestionController());
  }

}