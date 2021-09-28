// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userInfo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoModel _$UserInfoModelFromJson(Map<String, dynamic> json) {
  return UserInfoModel(
    json['userId'] as int,
    json['email'] as String,
    json['nick_name'] as String,
    json['phone'] as String?,
    json['address'] == null
        ? null
        : AddressModel.fromJson(json['address'] as Map<String, dynamic>),
    (json['alarmIds'] as List<dynamic>).map((e) => e as int).toList(),
  );
}

Map<String, dynamic> _$UserInfoModelToJson(UserInfoModel instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'email': instance.email,
      'nick_name': instance.nickName,
      'phone': instance.phNum,
      'address': instance.address,
      'alarmIds': instance.alarmIds,
    };
