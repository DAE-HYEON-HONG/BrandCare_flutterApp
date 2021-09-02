import 'package:json_annotation/json_annotation.dart';
part 'updateProduct_model.g.dart';

@JsonSerializable()
class UpdateProductModel {
  late String title;
  late int categoryId;
  late int brandId;
  late String etc;
  late int price;
  late String serialCode;
  late String buyRoute;
  late String buyDate;
  late List<int> conditionId;
  late List<int> additionId;
  late int id;
  late List<int> deleteImageId;


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
  });

  factory UpdateProductModel.fromJson(Map<String, dynamic> json) => _$UpdateProductModelFromJson(json);
  Map<String, dynamic> toJson() => _$UpdateProductModelToJson(this);
}