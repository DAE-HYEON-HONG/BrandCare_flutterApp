import 'dart:io';

// json 용도가 아님.
class AddCareListModel {
  String category;
  String secondCategory;
  int price;
  File picture;

  AddCareListModel({
    required this.category,
    required this.secondCategory,
    required this.price,
    required this.picture,
  });
}