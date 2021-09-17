import 'package:brandcare_mobile_flutter_v2/models/paging_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/point/pointRes_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/point/point_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'point_list_model.g.dart';

@JsonSerializable()
class PointListModel {
  final PointModel model;
  final PointResModel response;

  PointListModel(this.model, this.response);

  factory PointListModel.fromJson(Map<String, dynamic> json) => _$PointListModelFromJson(json);
  Map<String, dynamic> toJson() => _$PointListModelToJson(this);
}