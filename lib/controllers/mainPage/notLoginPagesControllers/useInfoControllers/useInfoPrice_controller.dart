import 'package:brandcare_mobile_flutter_v2/controllers/base_controller.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';

class UseInfoPriceController extends BaseController{
  Rx<int> currentIdx = 0.obs;

  List<Map<String, int>> bagPrice = [
    {
      "끈길이 줄임" : 25000,
      "isOdd": 0,
    },
    {
      "지퍼헤드교체" : 15000,
      "isOdd": 0,
    },
    {
      "지퍼교체" : 30000,
      "isOdd": 0,
    },
    {
      "안감교체" : 150000,
      "isOdd": 0,
    },
    {
      "장식교체" : 30000,
      "isOdd": 1,
    },
    {
      "장식도금" : 30000,
      "isOdd": 1,
    },
    {
      "전체염색" : 80000,
      "isOdd": 0,
    },
    {
      "가죽복원/크리닝 포함(가능한소재에 한함)" : 100000,
      "isOdd": 0,
    },
    {
      "크리닝" : 60000,
      "isOdd": 0,
    },
    {
      "스웨이드 크리닝" : 70000,
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

  List<Map<String, String>> shoesPrice = [
    {
      "밑창보강" : "20000",
      "isOdd": "국산창",
    },
    {
      "" : "50000",
      "isOdd": "수입창",
    },
    {
      "가죽복원/크리닝포함(가능한 소재에 한함)" : "100000",
      "isOdd": "2켤레",
    },
    {
      "염색" : "80000",
      "isOdd": "2켤레",
    },
    {
      "부츠 크리닝" : "60000",
      "isOdd": "2켤레",
    },
    {
      "구두, 로퍼 크리닝" : "20000",
      "isOdd": "2켤레",
    },
    {
      "스웨이드 크리닝" : "50000",
      "isOdd": "2켤레",
    },
    {
      "운동화 크리닝" : "15000",
      "isOdd": "2켤레",
    },
    {
      "어그부츠 크리닝" : "30000",
      "isOdd": "2켤레",
    },
    {
      "재박음질" : "5000",
      "isOdd": "2켤레",
    },
  ].obs;

  void changeCurrentIdx(int idx){
    this.currentIdx.value = idx;
    print("현재 선택된 구역 ${this.currentIdx.value}");
    update();
  }

  @override
  void onInit() {
    super.onInit();
  }
}