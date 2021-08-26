import 'package:json_annotation/json_annotation.dart';
part 'couponList_model.g.dart';

@JsonSerializable()
class CouponListModel{
  final String code;
  final int discount;
  final int id;
  final String path;
  final String title;

  CouponListModel(this.code, this.discount, this.id, this.path, this.title);

  factory CouponListModel.fromJson(Map<String, dynamic> json) => _$CouponListModelFromJson(json);
  Map<String, dynamic> toJson() => _$CouponListModelToJson(this);

// CouponListModel.fromJson(Map<String, dynamic> json):
  //     code = json['code'],
  //     discount = json['discount'],
  //     id = json['id'],
  //     path = json['path'],
  //     title = json['title'];
}