import 'package:brandcare_mobile_flutter_v2/models/addCare/carePersonInfo_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/genuine/placer_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'genuineStatus_model.g.dart';

@JsonSerializable()
class GenuineStatusModel{
  late CarePersonInfoModel sender;
  late CarePersonInfoModel receiver;
  late int id;
  late String createdDate;
  late PlacerModel placer;
  late String status;
  late String request_term;
  late String title;
  late String category;
  late String returnType;
  late String product_image;
  late String brand;

  GenuineStatusModel(
      this.id,
      this.createdDate,
      this.placer,
      this.status,
      this.request_term,
      this.title,
      this.category,
      this.product_image,
      this.brand);

  factory GenuineStatusModel.fromJson(Map<String, dynamic> json) => _$GenuineStatusModelFromJson(json);
  Map<String, dynamic> toJson() => _$GenuineStatusModelToJson(this);
}