import 'package:json_annotation/json_annotation.dart';
part 'careList_model.g.dart';

@JsonSerializable()
class CareListModel {
  final String createdDate;
  final int id;
  final String status;
  final String title;

  CareListModel(this.createdDate, this.id, this.status, this.title);

  factory CareListModel.fromJson(Map<String, dynamic> json) => _$CareListModelFromJson(json);
  Map<String, dynamic> toJson() => _$CareListModelToJson(this);

// CareListModel.fromJson(Map<String, dynamic> json):
  //     createdDate = json['createdDate'],
  //     id = json['id'],
  //     status = json['status'],
  //     title = json['title'];
}