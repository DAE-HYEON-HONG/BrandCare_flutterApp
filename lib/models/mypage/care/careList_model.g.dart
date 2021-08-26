// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'careList_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CareListModel _$CareListModelFromJson(Map<String, dynamic> json) {
  return CareListModel(
    json['createdDate'] as String,
    json['id'] as int,
    json['status'] as String,
    json['title'] as String,
  );
}

Map<String, dynamic> _$CareListModelToJson(CareListModel instance) =>
    <String, dynamic>{
      'createdDate': instance.createdDate,
      'id': instance.id,
      'status': instance.status,
      'title': instance.title,
    };
