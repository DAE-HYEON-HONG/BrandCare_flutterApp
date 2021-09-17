import 'package:brandcare_mobile_flutter_v2/models/point/point_list_info_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'point_model.g.dart';

@JsonSerializable()

class PointModel {
  final int point;

  PointModel(this.point);

  factory PointModel.fromJson(Map<String, dynamic> json) => _$PointModelFromJson(json);
  Map<String, dynamic> toJson() => _$PointModelToJson(this);

}