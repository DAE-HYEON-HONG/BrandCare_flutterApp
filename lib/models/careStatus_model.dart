class CareStatusModel {
  late String statusType;
  late String date;
  late String time;
  late bool checked;

  //CareStatusModel(this.statusType, this.date, this.time, this.checked);
  CareStatusModel.fromJson(Map<String, dynamic> json)
  : statusType = json['statusType'],
  date = json['date'],
  time = json['time'],
  checked = json['checked'];
}