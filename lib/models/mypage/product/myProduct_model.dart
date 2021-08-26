class MyProduct {
  late String backImage;
  late String fontImage;
  late String leftImage;
  late String rightImage;
  late String thumbnail;
  late String title;
  late String brand;
  late String category;
  late String createdDate;
  late String genuine;
  late int productId;

  MyProduct.fromJson(Map<String, dynamic> json)
  : backImage = json['backImage'] ?? '', //이미지 없을 수 있음
    fontImage = json['frontImage'] ?? '', //이미지 없을 수 있음
    leftImage = json['leftImage'] ?? '', //이미지 없을 수 있음
    rightImage = json['rightImage'] ?? '', //이미지 없을 수 있음
    thumbnail = json['thumbnail'] ?? '', //이미지 없을 수 있음
    title = json['title'],
    brand = json['brand'],
    category = json['category'],
    createdDate = json['createdDate'] ?? '', //날짜 확인 필요
    genuine = json['genuine'],
    productId = json['id'];
}