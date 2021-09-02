import 'package:json_annotation/json_annotation.dart';

part 'placer_model.g.dart';

@JsonSerializable()
class PlacerModel{
  late int id;
  late String email;
  late String name;
  late String phone;

  PlacerModel(this.id, this.email, this.name, this.phone);

  factory PlacerModel.fromJson(Map<String, dynamic> json) => _$PlacerModelFromJson(json);
  Map<String, dynamic> toJson() => _$PlacerModelToJson(this);
}