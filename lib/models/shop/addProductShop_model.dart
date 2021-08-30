import 'dart:io';

class AddProductShopModel {
  late String title;
  late int productIdx;
  late int price;
  late String content;
  late List<File> pictures;

  AddProductShopModel({
    required this.title,
    required this.productIdx,
    required this.price,
    required this.content,
    required this.pictures,
  });
}