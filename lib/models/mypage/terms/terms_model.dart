import 'package:json_annotation/json_annotation.dart';
part 'terms_model.g.dart';

@JsonSerializable()
class TermsModel {
  final int id;
  final String content;
  final String termsType;

  TermsModel(this.id, this.content, this.termsType);

  factory TermsModel.fromJson(Map<String, dynamic> json) => _$TermsModelFromJson(json);
  Map<String, dynamic> toJson() => _$TermsModelToJson(this);

}