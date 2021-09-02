import 'package:json_annotation/json_annotation.dart';
part 'qeustionList_model.g.dart';

@JsonSerializable()
class QuestionListModel{
  final int id;
  final String question;
  final String? answer;
  final String writer;
  final String createdDate;


  QuestionListModel(this.id, this.answer, this.writer, this.createdDate, this.question);

   factory QuestionListModel.fromJson(Map<String, dynamic> json) => _$QuestionListModelFromJson(json);
    Map<String, dynamic> toJson() => _$QuestionListModelToJson(this);
}