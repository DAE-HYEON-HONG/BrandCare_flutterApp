import 'package:json_annotation/json_annotation.dart';

part 'careInfo_model.g.dart';

@JsonSerializable()
class CareInfoModel {
  CareInfoModel(this.createdDate, this.id, this.status, this.title);
  late String createdDate;
  late int id;
  late String status;
  late String title;

  factory CareInfoModel.fromJson(Map<String, dynamic> json) => _$CareInfoModelFromJson(json);
  Map<String, dynamic> toJson() => _$CareInfoModelToJson(this);
}