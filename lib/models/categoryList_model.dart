import 'package:json_annotation/json_annotation.dart';
part 'categoryList_model.g.dart';

@JsonSerializable()
class CategoryListModel {
  late String category;
  late int categoryId;

  CategoryListModel(this.categoryId, this.category);

  factory CategoryListModel.fromJson(Map<String, dynamic> json) => _$CategoryListModelFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryListModelToJson(this);
}