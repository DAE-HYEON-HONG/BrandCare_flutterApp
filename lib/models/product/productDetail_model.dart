import 'package:brandcare_mobile_flutter_v2/models/category/categoryList_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/idPathImages_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'productDetail_model.g.dart';

@JsonSerializable()
class ProductDetailModel{
  ProductDetailModel(
      this.additionList,
      this.backImage,
      this.brand,
      this.categoryId,
      this.brandId,
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
      this.title,
      this.activationId,);

  late String? backImage;
  late String brand;
  late int brandId;
  late String buyDate;
  late String buyRoute;
  late String category;
  late int categoryId;
  late List<CategoryListModel> conditionList;
  late List<CategoryListModel> additionList;
  late String? createdDate;
  late String etc;
  late String? frontImage;
  late String genuine;
  late int id;
  late List<IdPathImagesModel>? image;
  late String? leftImage;
  late String price;
  late String? rightImage;
  late String serialCode;
  late String? thumbnail;
  late String title;
  final int? activationId;

  factory ProductDetailModel.fromJson(Map<String, dynamic> json) => _$ProductDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$ProductDetailModelToJson(this);
}