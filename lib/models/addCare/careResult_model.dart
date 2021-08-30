import 'package:brandcare_mobile_flutter_v2/models/addCare/careInfo_model.dart';
import 'package:json_annotation/json_annotation.dart';

import 'beforeAfterImg_model.dart';

part 'careResult_model.g.dart';
@JsonSerializable()
class CareResultModel {
  CareResultModel(this.careInfo, this.comment, this.results);
  late CareInfoModel careInfo;
  late String comment;
  late List<BeforeAfterImgModel> results;

  factory CareResultModel .fromJson(Map<String, dynamic> json) => _$CareResultModelFromJson(json);
  Map<String, dynamic> toJson() => _$CareResultModelToJson(this);
}