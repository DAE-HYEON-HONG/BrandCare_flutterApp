import 'package:brandcare_mobile_flutter_v2/models/categoryList_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/idPathImages_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'productDetail_model.g.dart';

@JsonSerializable()
class ProductDetailModel{
  late List<CategoryListModel> additionList;

  ProductDetailModel(
      this.additionList,
      this.backImage,
      this.brand,
      this.buyDate,
      this.buyRoute,
      this.category,
      this.conditionList,
      this.createdDate,
      this.etc,
      this.frontImage,
      this.genuine,
      this.id,
      this.image,
      this.leftImage,
      this.price,
      this.rightImage,
      this.serialCode,
      this.thumbnail,
      this.title);

  late String? backImage;
  late String brand;
  late String buyDate;
  late String buyRoute;
  late String category;
  late List<CategoryListModel> conditionList;
  late String? createdDate;
  late String etc;
  late String? frontImage;
  late String genuine;
  late int id;
  late List<IdPathImagesModel> image;
  late String? leftImage;
  late int price;
  late String? rightImage;
  late String serialCode;
  late String thumbnail;
  late String title;

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) => _$ProductDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductDetailModelToJson(this);
}