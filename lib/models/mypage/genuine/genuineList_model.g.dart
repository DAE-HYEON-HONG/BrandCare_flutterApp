// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'genuineList_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GenuineListModel _$GenuineListModelFromJson(Map<String, dynamic> json) {
  return GenuineListModel(
    json['createdDate'] as String,
    json['id'] as int,
    json['status'] as String,
    json['title'] as String?,
    json['brand'] as String?,
    json['category'] as String?,
    json['thumbnail'] as String?,
    json['type'] as String?,
  );
}

Map<String, dynamic> _$GenuineListModelToJson(GenuineListModel instance) =>
    <String, dynamic>{
      'createdDate': instance.createdDate,
      'id': instance.id,
      'status': instance.status,
      'title': instance.title,
      'brand': instance.brand,
      'category': instance.category,
      'thumbnail': instance.thumbnail,
      'type': instance.type,
    };
