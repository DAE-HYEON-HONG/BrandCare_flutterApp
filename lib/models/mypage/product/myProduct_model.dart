import 'package:json_annotation/json_annotation.dart';
part 'myProduct_model.g.dart';

@JsonSerializable()
class MyProduct {
  final String? backImage;
  final String? fontImage;
  final String? leftImage;
  final String? rightImage;
  final String? thumbnail;
  final String title;
  final String brand;
  final String category;
  final String? createdDate;
  final String genuine;
  @JsonKey(name: 'id')
  final int productId;

  MyProduct(
      this.backImage,
      this.fontImage,
      this.leftImage,
      this.rightImage,
      this.thumbnail,
      this.title,
      this.brand,
      this.category,
      this.createdDate,
      this.genuine,
      this.productId);

  factory MyProduct.fromJson(Map<String, dynamic> json) => _$MyProductFromJson(json);
  Map<String, dynamic> toJson() => _$MyProductToJson(this);

// MyProduct.fromJson(Map<String, dynamic> json)
  // : backImage = json['backImage'] ?? '', //이미지 없을 수 있음
  //   fontImage = json['frontImage'] ?? '', //이미지 없을 수 있음
  //   leftImage = json['leftImage'] ?? '', //이미지 없을 수 있음
  //   rightImage = json['rightImage'] ?? '', //이미지 없을 수 있음
  //   thumbnail = json['thumbnail'] ?? '', //이미지 없을 수 있음
  //   title = json['title'],
  //   brand = json['brand'],
  //   category = json['category'],
  //   createdDate = json['createdDate'] ?? '', //날짜 확인 필요
  //   genuine = json['genuine'],
  //   productId = json['id'];
}