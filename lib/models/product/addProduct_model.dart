import 'dart:io';

class AddProductModel {
  late String title;
  late int categoryId;
  late int brandId;
  late String etc;
  late int price;
  late String serialCode;
  late String buyRoute;
  late String buyDate;
  late List<int> conditionId;
  late List<int> additionId;


  AddProductModel({
    required this.title,
    required this.categoryId,
    required this.brandId,
    required this.etc,
    required this.price,
    required this.serialCode,
    required this.buyRoute,
    required this.buyDate,
    required this.conditionId,
    required this.additionId,
  });
}