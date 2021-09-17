import 'package:json_annotation/json_annotation.dart';
part 'careStatus_model.g.dart';

@JsonSerializable()
class CareStatusModel {
  late String statusType;
  late String date;
  late String time;
  late bool checked;

  CareStatusModel(this.statusType, this.date, this.time, this.checked);

  factory CareStatusModel.fromJson(Map<String, dynamic> json) => _$CareStatusModelFromJson(json);
  Map<String, dynamic> toJson() => _$CareStatusModelToJson(this);

//CareStatusModel(this.statusType, this.date, this.time, this.checked);
  // CareStatusModel.fromJson(Map<String, dynamic> json)
  // : statusType = json['statusType'],
  // date = json['date'],
  // time = json['time'],
  // checked = json['checked'];
}