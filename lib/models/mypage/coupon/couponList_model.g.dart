// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'couponList_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CouponListModel _$CouponListModelFromJson(Map<String, dynamic> json) {
  return CouponListModel(
    json['code'] as String,
    json['discount'] as int,
    json['id'] as int,
    json['path'] as String,
    json['title'] as String,
  );
}

Map<String, dynamic> _$CouponListModelToJson(CouponListModel instance) =>
    <String, dynamic>{
      'code': instance.code,
      'discount': instance.discount,
      'id': instance.id,
      'path': instance.path,
      'title': instance.title,
    };
