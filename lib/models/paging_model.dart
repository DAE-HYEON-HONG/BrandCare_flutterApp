import 'package:json_annotation/json_annotation.dart';
part 'paging_model.g.dart';

@JsonSerializable()
class Paging {
  late int currentPage;
  late int totalCount;
  late int totalPage;

  Paging(this.currentPage, this.totalCount, this.totalPage);

  factory Paging.fromJson(Map<String, dynamic> json) => _$PagingFromJson(json);
  Map<String, dynamic> toJson() => _$PagingToJson(this);

// Paging.fromJson(Map<String, dynamic> json)
  // : currentPage = json['currentPage'],
  //   totalCount = json['totalCount'],
  //   totalPage = json['totalPage'];
}