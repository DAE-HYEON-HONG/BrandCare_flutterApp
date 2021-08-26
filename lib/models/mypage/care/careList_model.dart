class CareListModel {
  late String createdDate;
  late int id;
  late String status;
  late String title;
  CareListModel.fromJson(Map<String, dynamic> json):
      createdDate = json['createdDate'],
      id = json['id'],
      status = json['status'],
      title = json['title'];
}