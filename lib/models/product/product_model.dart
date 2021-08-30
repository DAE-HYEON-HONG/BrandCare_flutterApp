import 'package:json_annotation/json_annotation.dart';
part 'product_model.g.dart';

@JsonSerializable()
class ProductModel {
  final int id;
  final String title;
  final String brand;
  final String category;
  final String? thumbnail;
  final String frontImage;
  final String leftImage;
  final String backImage;
  final String rightImage;
  final String genuine;
  final String? createdDate;

  ProductModel(
      this.id,
      this.title,
      this.brand,
      this.category,
      this.thumbnail,
      this.frontImage,
      this.leftImage,
      this.backImage,
      this.rightImage,
      this.genuine,
      this.createdDate);

  factory ProductModel.fromJson(Map<String, dynamic> json) => _$ProductModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductModelToJson(this);
}