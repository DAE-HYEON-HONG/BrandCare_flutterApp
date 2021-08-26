// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'careStatus_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CareStatusModel _$CareStatusModelFromJson(Map<String, dynamic> json) {
  return CareStatusModel(
    json['statusType'] as String,
    json['date'] as String,
    json['time'] as String,
    json['checked'] as bool,
  );
}

Map<String, dynamic> _$CareStatusModelToJson(CareStatusModel instance) =>
    <String, dynamic>{
      'statusType': instance.statusType,
      'date': instance.date,
      'time': instance.time,
      'checked': instance.checked,
    };
