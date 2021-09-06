import 'package:json_annotation/json_annotation.dart';

part 'careProductInfo_model.g.dart';

@JsonSerializable()
class CareProductInfoModel {
  late String category;
  late int id;
  late String image;
  late int price;
  final String largeCategory;

  CareProductInfoModel(this.category, this.id, this.image, this.price, this.largeCategory);

  factory CareProductInfoModel.fromJson(Map<String, dynamic> json) => _$CareProductInfoModelFromJson(json);
  Map<String, dynamic> toJson() => _$CareProductInfoModelToJson(this);
}