import 'package:json_annotation/json_annotation.dart';
part 'myProfileInfo_model.g.dart';

@JsonSerializable()
class MyProfileInfoModel {
  final int activationCount;
  final int careCount;
  final int productCount;
  final String lastLoginData;
  final String nickName;
  final String? profileImg;

  MyProfileInfoModel(this.activationCount, this.careCount, this.productCount, this.lastLoginData, this.nickName, this.profileImg);

  factory MyProfileInfoModel.fromJson(Map<String, dynamic> json) => _$MyProfileInfoModelFromJson(json);
  Map<String, dynamic> toJson() => _$MyProfileInfoModelToJson(this);
  // MyProfileInfoModel.fromJson(Map<String, dynamic> json)
  // : activationCount = json['activationCount'],
  //   careCount = json['careCount'],
  //   productCount = json['productCount'],
  //   lastLoginData = json['lastLoginDate'],
  //   nickName = json['nickName'],
  //   profileImg = json['profile'] ?? '';
}