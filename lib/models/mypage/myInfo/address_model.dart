import 'package:json_annotation/json_annotation.dart';
part 'address_model.g.dart';

@JsonSerializable()
class AddressModel {
  final String city;
  final String street;
  final String zipCode;

  AddressModel(this.city, this.street, this.zipCode);

  factory AddressModel.fromJson(Map<String, dynamic> json) => _$AddressModelFromJson(json);
  Map<String, dynamic> toJson() => _$AddressModelToJson(this);
}