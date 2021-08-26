import 'package:json_annotation/json_annotation.dart';
part 'genuineList_model.g.dart';

@JsonSerializable()
class GenuineListModel {
  final String createdDate;
  final int id;
  final String status;
  final String title;
  final String brand;
  final String category;
  final String thumbnail;
  final String type;

  GenuineListModel(this.createdDate, this.id, this.status, this.title,
      this.brand, this.category, this.thumbnail, this.type);

  factory GenuineListModel.fromJson(Map<String, dynamic> json) => _$GenuineListModelFromJson(json);
  Map<String, dynamic> toJson() => _$GenuineListModelToJson(this);

// GenuineListModel.fromJson(Map<String, dynamic> json):
  //       createdDate = json['createdDate'],
  //       id = json['id'],
  //       status = json['status'],
  //       title = json['product_title'] ?? '', //나중에 꼭 다시 삭제 부탁
  //       brand = json['brand'] ?? '',
  //       category = json['category']?? '',
  //       thumbnail = json['thumbnail'] ?? '',
  //       type = json['type'] ?? '';
}