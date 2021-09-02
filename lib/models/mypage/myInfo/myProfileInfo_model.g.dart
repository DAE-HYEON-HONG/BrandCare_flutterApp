// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'myProfileInfo_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyProfileInfoModel _$MyProfileInfoModelFromJson(Map<String, dynamic> json) {
  return MyProfileInfoModel(
    json['activationCount'] as int,
    json['careCount'] as int,
    json['productCount'] as int,
    json['lastLoginDate'] as String,
    json['nickName'] as String?,
    json['profile'] as String?,
  );
}

Map<String, dynamic> _$MyProfileInfoModelToJson(MyProfileInfoModel instance) =>
    <String, dynamic>{
      'activationCount': instance.activationCount,
      'careCount': instance.careCount,
      'productCount': instance.productCount,
      'lastLoginDate': instance.lastLoginDate,
      'nickName': instance.nickName,
      'profile': instance.profile,
    };
