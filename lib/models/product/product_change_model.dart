import 'package:json_annotation/json_annotation.dart';
part 'product_change_model.g.dart';

@JsonSerializable()
class ProductChangeModel {
  final int id;
  final int productId;
  final String brand;
  final String category;
  final String title;
  final String genuine;
  final String image;
  final String? currentEmail;
  final String? beforeEmail;

  ProductChangeModel(this.id, this.productId, this.brand, this.category,
      this.title, this.genuine, this.image, this.currentEmail, this.beforeEmail);
  
  factory ProductChangeModel.fromJson(Map<String, dynamic> json) => _$ProductChangeModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductChangeModelToJson(this);
}