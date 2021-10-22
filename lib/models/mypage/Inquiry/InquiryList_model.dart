import 'package:json_annotation/json_annotation.dart';

part 'InquiryList_model.g.dart';

@JsonSerializable()

class InquiryListModel{
  final String? answer;
  final String? answerer;
  final String content;
  final String createdDate;
  final String? answerCreatedDate;
  final int id;
  final String title;

  InquiryListModel(this.answer, this.answerer, this.content, this.createdDate, this.answerCreatedDate,
      this.id, this.title);

  factory InquiryListModel.fromJson(Map<String, dynamic> json) => _$InquiryListModelFromJson(json);
  Map<String, dynamic> toJson() => _$InquiryListModelToJson(this);
}