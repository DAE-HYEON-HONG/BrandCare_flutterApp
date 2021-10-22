import 'dart:io';

class ModProductShopModel {
  late String title;
  late int productIdx;
  late int price;
  late String content;
  late String id;
  late List<File> pictures;

  ModProductShopModel({
    required this.title,
    required this.productIdx,
    required this.price,
    required this.content,
    required this.id,
    required this.pictures,
  });
}