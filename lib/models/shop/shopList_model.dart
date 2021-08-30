import 'package:json_annotation/json_annotation.dart';

part 'shopList_model.g.dart';

@JsonSerializable()
class ShopListModel {
  late String brand;
  late String category;
  late String createdDate;
  late String gi;
  late String image;
  late String price;
  late int shopId;
  late String title;

  ShopListModel(this.brand, this.category, this.createdDate, this.gi, this.image, this.price, this.shopId, this.title);

  factory ShopListModel.fromJson(Map<String, dynamic> json) => _$ShopListModelFromJson(json);
  Map<String, dynamic> toJson() => _$ShopListModelToJson(this);
}
