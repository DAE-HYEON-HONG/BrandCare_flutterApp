import 'package:json_annotation/json_annotation.dart';
part 'careSubCategory_model.g.dart';

@JsonSerializable()
class CareSubCategoryModel{
  final int id;
  final String title;
  final int price;
  final String? reMark;

  CareSubCategoryModel(this.id, this.title, this.price, this.reMark);

  factory CareSubCategoryModel.fromJson(Map<String, dynamic> json) => _$CareSubCategoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$CareSubCategoryModelToJson(this);
}