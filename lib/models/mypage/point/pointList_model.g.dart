// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pointList_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PointListModel _$PointListModelFromJson(Map<String, dynamic> json) {
  return PointListModel(
    json['title'] as String,
    json['history'] as String,
    json['createdDate'] as String,
    json['usedPoint'] as int,
  );
}

Map<String, dynamic> _$PointListModelToJson(PointListModel instance) =>
    <String, dynamic>{
      'title': instance.title,
      'history': instance.history,
      'createdDate': instance.createdDate,
      'usedPoint': instance.usedPoint,
    };
