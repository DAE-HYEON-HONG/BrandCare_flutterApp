class StatusUtil{
  static String statusChk({required String status}){
    if(status == "APPLICATION"){
      return "신청완료";
    }else if(status == "PICKUP"){
      return "수거 진행중";
    } else if(status == "WAREHOUSING"){
      return "입고";
    } else if(status == "CARING"){
      return "진행중";
    } else if(status == "BE_RELEASED"){
      return "출고";
    } else if(status == "DELIVERING"){
      return "배송중";
    } else if(status == "COMPLETION"){
      return "완료";
    }else {
      return "거부";
    }
  }
}