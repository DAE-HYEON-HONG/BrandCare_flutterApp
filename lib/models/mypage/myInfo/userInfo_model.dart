import 'package:brandcare_mobile_flutter_v2/models/mypage/myInfo/address_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'userInfo_model.g.dart';

@JsonSerializable()
class UserInfoModel {
  final int userID;
  final String email;
  @JsonKey(defaultValue: 'nick_name')
  final String nickName;
  @JsonKey(defaultValue: 'phone')
  final String phNum;
  final AddressModel? address;
  UserInfoModel(this.userID, this.email, this.nickName, this.phNum, this.address);


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