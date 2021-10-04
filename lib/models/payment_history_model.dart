import 'package:json_annotation/json_annotation.dart';
part 'payment_history_model.g.dart';

@JsonSerializable()
class PaymentHistoryModel {
  final int usePoint;
  final int useCouponDisCount;
  final int price;
  final int paymentAmount;
  final int shippingFee;

  PaymentHistoryModel(this.usePoint, this.useCouponDisCount, this.price,
      this.paymentAmount, this.shippingFee);

  factory PaymentHistoryModel.fromJson(Map<String, dynamic> json) => _$PaymentHistoryModelFromJson(json);
  Map<String, dynamic> toJson() => _$PaymentHistoryModelToJson(this);
}