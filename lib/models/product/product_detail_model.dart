import 'package:brandcare_mobile_flutter_v2/models/idPathImages_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/id_title_model.dart';
import 'package:json_annotation/json_annotation.dart';
part 'product_detail_model.g.dart';

@JsonSerializable()
class ProductDetailModel {
  final int id;
  final String title;
  final String brand;
  final String category;
  final String? thumbnail;
  final String? frontImage;
  final String? leftImage;
  final String? backImage;
  final String? rightImage;
  final String genuine;
  final String? createdDate;
  final String price;
  final String etc;
  final String serialCode;
  final String buyRoute;
  final String buyDate;
  
  final List<IdPathImagesModel> image;
  final List<IdTitleModel> additionList;
  final List<IdTitleModel> conditionList;

  ProductDetailModel(
      this.id,
      this.title,
      this.brand,
      this.category,
      this.thumbnail,
      this.frontImage,
      this.leftImage,
      this.backImage,
      this.rightImage,
      this.genuine,
      this.createdDate,
      this.price,
      this.etc,
      this.serialCode,
      this.buyRoute,
      this.buyDate,
      this.image,
      this.additionList,
      this.conditionList);
  
  factory ProductDetailModel.fromJson(Map<String, dynamic> json) => _$ProductDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductDetailModelToJson(this);
}

