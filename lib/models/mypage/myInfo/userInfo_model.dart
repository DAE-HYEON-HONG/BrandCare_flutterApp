import 'package:brandcare_mobile_flutter_v2/models/mypage/myInfo/address_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'userInfo_model.g.dart';

@JsonSerializable()
class UserInfoModel {
  final int userId;
  final String email;
  @JsonKey(name: 'nick_name')
  final String nickName;
  @JsonKey(name: 'phone')
  late String? phNum;
  final AddressModel? address;
  final List<int> alarmIds;
  final String code;
  UserInfoModel(this.userId, this.email, this.nickName, this.phNum, this.address, this.alarmIds, this.code);


  factory UserInfoModel.fromJson(Map<String, dynamic> json) => _$UserInfoModelFromJson(json);
  Map<String, dynamic> toJson() => _$UserInfoModelToJson(this);
  // UserInfoModel.fromJson(Map<String, dynamic> json)
  //   : userID = json['userId'],
  //     email = json['email'],
  //     nickName = json['nick_name'],
  //     phNum = json['phone'] ?? "",
  //     addressCity = json['address']['city'],
  //     addressStreet = json['address']['street'],
  //     zipCode = json['address']['zipCode'];
}