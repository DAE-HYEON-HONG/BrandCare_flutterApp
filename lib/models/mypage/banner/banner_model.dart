import 'package:brandcare_mobile_flutter_v2/models/idPathImages_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'banner_model.g.dart';

@JsonSerializable()
class BannerModel{
  final bool isUrl;
  final String? url;
  final String bannerModel;
  final int id;
  final IdPathImagesModel image;


  BannerModel( this.isUrl, this.url, this.bannerModel, this.id, this.image);

  factory BannerModel.fromJson(Map<String, dynamic> json) => _$BannerModelFromJson(json);
   Map<String, dynamic> toJson() => _$BannerModelToJson(this);
}