import 'package:json_annotation/json_annotation.dart';

part 'point_list_info_model.g.dart';

@JsonSerializable()

class PointListInfoModel {
  final String content;
  final String history;
  final String createdDate;
  final int usePoint;

  PointListInfoModel(
      this.content, this.history, this.createdDate, this.usePoint);

  factory PointListInfoModel.fromJson(Map<String, dynamic> json) => _$PointListInfoModelFromJson(json);
  Map<String, dynamic> toJson() => _$PointListInfoModelToJson(this);
}