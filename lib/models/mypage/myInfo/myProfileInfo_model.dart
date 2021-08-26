class MyProfileInfoModel {
  late int activationCount;
  late int careCount;
  late int productCount;
  late String lastLoginData;
  late String nickName;
  late String profileImg;

  MyProfileInfoModel(this.activationCount, this.careCount, this.productCount, this.lastLoginData, this.nickName, this.profileImg);
  MyProfileInfoModel.fromJson(Map<String, dynamic> json)
  : activationCount = json['activationCount'],
    careCount = json['careCount'],
    productCount = json['productCount'],
    lastLoginData = json['lastLoginDate'],
    nickName = json['nickName'],
    profileImg = json['profile'] ?? '';
}