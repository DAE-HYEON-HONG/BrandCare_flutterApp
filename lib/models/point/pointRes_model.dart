import 'package:brandcare_mobile_flutter_v2/models/point/point_list_info_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pointRes_model.g.dart';

@JsonSerializable()
class PointResModel {
  List<PointListInfoModel> list;
  PointResModel(this.list);

  factory PointResModel.fromJson(Map<String, dynamic> json) => _$PointResModelFromJson(json);
  Map<String, dynamic> toJson() => _$PointResModelToJson(this);
}