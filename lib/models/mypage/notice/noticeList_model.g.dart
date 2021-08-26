// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'noticeList_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NoticeListModel _$NoticeListModelFromJson(Map<String, dynamic> json) {
  return NoticeListModel(
    json['title'] as String,
    json['content'] as String,
    json['createdDate'] as String,
    json['id'] as int,
  );
}

Map<String, dynamic> _$NoticeListModelToJson(NoticeListModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'createdDate': instance.createdDate,
      'id': instance.id,
    };
