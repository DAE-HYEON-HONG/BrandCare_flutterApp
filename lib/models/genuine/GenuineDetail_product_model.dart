import 'package:json_annotation/json_annotation.dart';

part 'GenuineDetail_product_model.g.dart';

@JsonSerializable()
class GenuineDetailProductModel {
  final String? backImage;
  final String brand;
  final int brandId;
  final String category;
  final int categoryId;
  final String createdDate;
  final String? frontImage;
  final String genuine;
  final int id;
  final String? leftImage;
  final String? rightImage;
  final String? thumbnail;
  final title;

  GenuineDetailProductModel(
      this.backImage,
      this.brand,
      this.brandId,
      this.category,
      this.categoryId,
      this.createdDate,
      this.frontImage,
      this.genuine,
      this.id,
      this.leftImage,
      this.rightImage,
      this.thumbnail,
      this.title);

  factory GenuineDetailProductModel.fromJson(Map<String, dynamic> json) => _$GenuineDetailProductModelFromJson(json);
  Map<String, dynamic> toJson() => _$GenuineDetailProductModelToJson(this);
}