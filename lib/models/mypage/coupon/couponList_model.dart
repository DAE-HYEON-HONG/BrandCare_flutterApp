class CouponListModel{
  late String code;
  late int discount;
  late int id;
  late String path;
  late String title;

  CouponListModel.fromJson(Map<String, dynamic> json):
      code = json['code'],
      discount = json['discount'],
      id = json['id'],
      path = json['path'],
      title = json['title'];
}