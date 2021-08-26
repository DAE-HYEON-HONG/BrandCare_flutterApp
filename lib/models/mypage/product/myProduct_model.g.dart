// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'myProduct_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyProduct _$MyProductFromJson(Map<String, dynamic> json) {
  return MyProduct(
    json['backImage'] as String?,
    json['fontImage'] as String?,
    json['leftImage'] as String?,
    json['rightImage'] as String?,
    json['thumbnail'] as String?,
    json['title'] as String,
    json['brand'] as String,
    json['category'] as String,
    json['createdDate'] as String,
    json['genuine'] as String,
    json['productId'] as int,
  );
}

Map<String, dynamic> _$MyProductToJson(MyProduct instance) => <String, dynamic>{
      'backImage': instance.backImage,
      'fontImage': instance.fontImage,
      'leftImage': instance.leftImage,
      'rightImage': instance.rightImage,
      'thumbnail': instance.thumbnail,
      'title': instance.title,
      'brand': instance.brand,
      'category': instance.category,
      'createdDate': instance.createdDate,
      'genuine': instance.genuine,
      'productId': instance.productId,
    };
