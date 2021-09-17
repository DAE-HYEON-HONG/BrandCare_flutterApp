import 'package:json_annotation/json_annotation.dart';
part 'updateProduct_model.g.dart';

@JsonSerializable()
class UpdateProductModel {
  final String title;
  final int categoryId;
  final int brandId;
  final String etc;
  final int price;
  final String serialCode;
  final String buyRoute;
  final String buyDate;
  final List<int> conditionId;
  final List<int> additionId;
  final int id;
  final List<int> deleteImageId;
  final List<String> deleteStr;


  UpdateProductModel({
    required this.title,
    required this.categoryId,
    required this.brandId,
    required this.etc,
    required this.price,
    required this.serialCode,
    required this.buyRoute,
    required this.buyDate,
    required this.conditionId,
    required this.additionId,
    required this.id,
    required this.deleteImageId,
    required this.deleteStr,
  });

  factory UpdateProductModel.fromJson(Map<String, dynamic> json) => _$UpdateProductModelFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateProductModelToJson(this);
}