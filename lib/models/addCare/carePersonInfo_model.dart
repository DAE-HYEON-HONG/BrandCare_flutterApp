import 'package:brandcare_mobile_flutter_v2/models/mypage/myInfo/address_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'carePersonInfo_model.g.dart';

@JsonSerializable()
class CarePersonInfoModel {
  late AddressModel address;
  late String name;
  late String phone;

  CarePersonInfoModel(this.address, this.name, this.phone);

  factory CarePersonInfoModel.fromJson(Map<String, dynamic> json) => _$CarePersonInfoModelFromJson(json);
  Map<String, dynamic> toJson() => _$CarePersonInfoModelToJson(this);
}