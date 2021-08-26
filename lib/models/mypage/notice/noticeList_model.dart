class NoticeListModel {
  late String title;
  late String content;
  late String createdDate;
  late int id;

  NoticeListModel.fromJson(Map<String, dynamic> json):
      title = json['title'],
      content = json['content'],
      createdDate = json['createdDate'],
      id = json['id'];
}