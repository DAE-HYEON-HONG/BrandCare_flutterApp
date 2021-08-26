class GenuineListModel {
  late String createdDate;
  late int id;
  late String status;
  late String title;
  late String brand;
  late String category;
  late String thumbnail;
  late String type;
  GenuineListModel.fromJson(Map<String, dynamic> json):
        createdDate = json['createdDate'],
        id = json['id'],
        status = json['status'],
        title = json['product_title'] ?? '', //나중에 꼭 다시 삭제 부탁
        brand = json['brand'] ?? '',
        category = json['category']?? '',
        thumbnail = json['thumbnail'] ?? '',
        type = json['type'] ?? '';
}