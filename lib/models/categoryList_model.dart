import 'package:json_annotation/json_annotation.dart';
part 'categoryList_model.g.dart';

@JsonSerializable()
class CategoryListModel {
  late int id;
  late String title;

  CategoryListModel(this.id, this.title);

  factory CategoryListModel.fromJson(Map<String, dynamic> json) => _$CategoryListModelFromJson(json);
  Map<String, dynamic> toJson() => _$CategoryListModelToJson(this);
}