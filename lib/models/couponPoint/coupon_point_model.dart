import 'package:brandcare_mobile_flutter_v2/models/couponPoint/coupon_list_model.dart';
import 'package:json_annotation/json_annotation.dart';

part 'coupon_point_model.g.dart';

@JsonSerializable()
class CouponPointModel {
  final int countCoupon;
  final int point;
  final List<CouponListModel> couponList;

  CouponPointModel(this.countCoupon, this.point, this.couponList);

  factory CouponPointModel.fromJson(Map<String, dynamic> json) => _$CouponPointModelFromJson(json);
  Map<String, dynamic> toJson() => _$CouponPointModelToJson(this);

}