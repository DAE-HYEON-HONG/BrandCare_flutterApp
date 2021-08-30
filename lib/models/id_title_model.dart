import 'package:json_annotation/json_annotation.dart';
part 'id_title_model.g.dart';

@JsonSerializable()
class IdTitleModel {
  final int id;
  final String title;

  IdTitleModel(this.id, this.title);

  factory IdTitleModel.fromJson(Map<String, dynamic> json) => _$IdTitleModelFromJson(json);
  Map<String, dynamic> toJson() => _$IdTitleModelToJson(this);
}
    