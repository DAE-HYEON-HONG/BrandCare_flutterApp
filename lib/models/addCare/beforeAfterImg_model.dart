import 'package:json_annotation/json_annotation.dart';
part 'beforeAfterImg_model.g.dart';

@JsonSerializable()
class BeforeAfterImgModel{
  BeforeAfterImgModel(this.afterImage, this.beforeImage, this.id);
  late String afterImage;
  late String beforeImage;
  late int id;

  factory BeforeAfterImgModel.fromJson(Map<String, dynamic> json) => _$BeforeAfterImgModelFromJson(json);
  Map<String, dynamic> toJson() => _$BeforeAfterImgModelToJson(this);
}