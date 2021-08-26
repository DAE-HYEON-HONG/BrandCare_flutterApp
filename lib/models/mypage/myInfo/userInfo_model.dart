class UserInfoModel {
  late int userID;
  late String email;
  late String nickName;
  late String phNum;
  late String addressCity;
  late String addressStreet;
  late String zipCode;
  UserInfoModel(this.userID, this.email, this.nickName, this.phNum, this.addressCity, this.addressStreet, this.zipCode);

  UserInfoModel.fromJson(Map<String, dynamic> json)
    : userID = json['userId'],
      email = json['email'],
      nickName = json['nick_name'],
      phNum = json['phone'] ?? "",
      addressCity = json['address']['city'],
      addressStreet = json['address']['street'],
      zipCode = json['address']['zipCode'];
}