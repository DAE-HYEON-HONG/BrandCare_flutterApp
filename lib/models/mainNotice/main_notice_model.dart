import 'package:json_annotation/json_annotation.dart';
part 'main_notice_model.g.dart';
@JsonSerializable()
class MainNoticeModel {
  final int id;
  final String createdTime;
  final String type;
  final String content;

  MainNoticeModel(this.id, this.createdTime, this.type, this.content);
  factory MainNoticeModel.fromJson(Map<String, dynamic> json) => _$MainNoticeModelFromJson(json);
  Map<String, dynamic> toJson() => _$MainNoticeModelToJson(this);
}
