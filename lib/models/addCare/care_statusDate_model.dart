import 'package:json_annotation/json_annotation.dart';

part 'care_statusDate_model.g.dart';

@JsonSerializable()
class CareStatusDateModel {
  late bool? progress;
  late String? pickUpDate;
  late String? wareHouseIngDate;
  late String? caringDate;
  late String? be_releasedDate;
  late String? completedDate;
  late String? applicationDate;
  late String? deliveringDate;

  CareStatusDateModel(
      this.progress,
      this.pickUpDate,
      this.wareHouseIngDate,
      this.caringDate,
      this.be_releasedDate,
      this.completedDate,
      this.applicationDate,
      this.deliveringDate);

  factory CareStatusDateModel.fromJson(Map<String, dynamic> json) => _$CareStatusDateModelFromJson(json);
  Map<String, dynamic> toJson() => _$CareStatusDateModelToJson(this);
}