class PointListModel {
  late String title;
  late String history;
  late String createdDate;
  late int usedPoint;

  PointListModel.fromJson(Map<String, dynamic> json):
      title = json['content'],
      history = json['history'],
      createdDate = json['createdDate'],
      usedPoint = json['usePoint'];
}