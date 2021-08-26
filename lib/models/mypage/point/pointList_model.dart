import 'package:json_annotation/json_annotation.dart';
part 'pointList_model.g.dart';

@JsonSerializable()
class PointListModel {
  final String title;
  final String history;
  final String createdDate;
  final int usedPoint;

  PointListModel(this.title, this.history, this.createdDate, this.usedPoint);

  factory PointListModel.fromJson(Map<String, dynamic> json) => _$PointListModelFromJson(json);
  Map<String, dynamic> toJson() => _$PointListModelToJson(this);

// PointListModel.fromJson(Map<String, dynamic> json):
  //     title = json['content'],
  //     history = json['history'],
  //     createdDate = json['createdDate'],
  //     usedPoint = json['usePoint'];
}