import 'package:json_annotation/json_annotation.dart';
part 'idPathImages_model.g.dart';

@JsonSerializable()
class IdPathImagesModel {
  late int id;
  late String path;

  IdPathImagesModel(this.id, this.path);

  factory IdPathImagesModel.fromJson(Map<String, dynamic> json) => _$IdPathImagesModelFromJson(json);
  Map<String, dynamic> toJson() => _$IdPathImagesModelToJson(this);
}

