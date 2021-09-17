import 'dart:io';
import 'package:brandcare_mobile_flutter_v2/models/genuine/GenuineDetail_product_model.dart';
import 'package:brandcare_mobile_flutter_v2/models/idPathImages_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'genuineDetail_model.g.dart';

@JsonSerializable()
class GenuineDetailModel {
  final IdPathImagesModel certificateImages;
  final String comment;
  final List<IdPathImagesModel> genuineImages;
  final GenuineDetailProductModel product;

  GenuineDetailModel(this.certificateImages, this.comment, this.genuineImages,
      this.product);

  factory GenuineDetailModel.fromJson(Map<String, dynamic> json) => _$GenuineDetailModelFromJson(json);
  Map<String, dynamic> toJson() => _$GenuineDetailModelToJson(this);
}