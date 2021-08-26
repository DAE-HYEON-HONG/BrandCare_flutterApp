// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'userInfo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserInfoModel _$UserInfoModelFromJson(Map<String, dynamic> json) {
  return UserInfoModel(
    json['userID'] as int,
    json['email'] as String,
    json['nickName'] as String? ?? 'nick_name',
    json['phNum'] as String? ?? 'phone',
    json['address'] == null
        ? null
        : AddressModel.fromJson(json['address'] as Map<String, dynamic>),
  );
}

Map<String, dynamic> _$UserInfoModelToJson(UserInfoModel instance) =>
    <String, dynamic>{
      'userID': instance.userID,
      'email': instance.email,
      'nickName': instance.nickName,
      'phNum': instance.phNum,
      'address': instance.address,
    };
