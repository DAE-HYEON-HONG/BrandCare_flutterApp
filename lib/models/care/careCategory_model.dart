import 'package:brandcare_mobile_flutter_v2/models/care/careSubCategory_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'careCategory_model.g.dart';

@JsonSerializable()
class CareCategoryModel {
  final int id;
  final String title;
  late List<CareSubCategoryModel> subCategory;

  CareCategoryModel(this.id, this.title, this.subCategory);
  factory CareCategoryModel.fromJson(Map<String, dynamic> json) => _$CareCategoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$CareCategoryModelToJson(this);
}