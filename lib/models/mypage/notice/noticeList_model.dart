import 'package:json_annotation/json_annotation.dart';
part 'noticeList_model.g.dart';

@JsonSerializable()
class NoticeListModel {
  final String title;
  final String content;
  final String createdDate;
  final int id;

  NoticeListModel(this.title, this.content, this.createdDate, this.id);
  
  factory NoticeListModel.fromJson(Map<String, dynamic> json) => _$NoticeListModelFromJson(json);
  Map<String, dynamic> toJson() => _$NoticeListModelToJson(this);

// NoticeListModel.fromJson(Map<String, dynamic> json):
  //     title = json['title'],
  //     content = json['content'],
  //     createdDate = json['createdDate'],
  //     id = json['id'];
}