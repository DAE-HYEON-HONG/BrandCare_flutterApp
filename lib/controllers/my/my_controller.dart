import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:flutter/material.dart';

class MyController extends BaseController {
  List<Map<String, int>> myData = [
    {'등록제품보기': 13},
    {'케어/수선이력': 10},
    {'정품인증이력': 10}
  ];

  Map<String, String> linkData = {
    '친구 초대 하기': '',
    '제품 사용자 변경': '',
    '공지사항': '',
    '자주 묻는 질문': '',
    '1:1 문의': '',
    '설정': '',
  };
}
