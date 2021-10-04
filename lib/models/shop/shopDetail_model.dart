import 'package:brandcare_mobile_flutter_v2/models/idPathImages_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'shopDetail_model.g.dart';

@JsonSerializable()
class ShopDetailModel {
  late String brand;

  ShopDetailModel(this.brand, this.category, this.createdDate, this.gi,
      this.hasLike, this.images, this.nickName, this.price, this.shopId,
      this.title, this.userProfile, this.content, this.productImages);

  late String category;
  late String createdDate;
  late String gi;
  late bool hasLike;
  late List<IdPathImagesModel> images;
  late String nickName;
  final String content;
  late int? price;
  late int shopId;
  late String title;
  late String? userProfile;
  late List<IdPathImagesModel>? productImages;

  factory ShopDetailModel.fromJson(Map<String, dynamic> json) => _$ShopDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$ShopDetailModelToJson(this);
}