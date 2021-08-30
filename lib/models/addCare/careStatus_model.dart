import 'package:brandcare_mobile_flutter_v2/models/addCare/carePersonInfo_model.dart';
import 'package:json_annotation/json_annotation.dart';
import 'careProductInfo_model.dart';
part 'careStatus_model.g.dart';

@JsonSerializable()
class CareStatusModel {
  List<CareProductInfoModel> careProduct;
  String careProductCategory;
  String createdDate;
  int id;
  CarePersonInfoModel receiver;
  String request_term;
  String returnType;
  CarePersonInfoModel sender;
  String status;

  CareStatusModel(
      this.careProduct,
      this.careProductCategory,
      this.createdDate,
      this.id,
      this.receiver,
      this.request_term,
      this.returnType,
      this.sender,
      this.status,
  );
  factory CareStatusModel.fromJson(Map<String, dynamic> json) => _$CareStatusModelFromJson(json);
  Map<String, dynamic> toJson() => _$CareStatusModelToJson(this);
}