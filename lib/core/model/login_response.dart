// To parse this JSON data, do
//
//     final loginResponse = loginResponseFromJson(jsonString);

import 'dart:convert';

LoginResponse loginResponseFromJson(String str) => LoginResponse.fromJson(json.decode(str));

String loginResponseToJson(LoginResponse data) => json.encode(data.toJson());

class LoginResponse {
  LoginResponse({
    required this.resultCode,
    required this.message,
    required this.responseTime,
    required this.data,
  });

  int resultCode;
  String message;
  int responseTime;
  Data data;

  factory LoginResponse.fromJson(Map<String, dynamic> json) => LoginResponse(
    resultCode: json["resultCode"],
    message: json["message"],
    responseTime: json["responseTime"],
    data: Data.fromJson(json["data"]),
  );

  Map<String, dynamic> toJson() => {
    "resultCode": resultCode,
    "message": message,
    "responseTime": responseTime,
    "data": data.toJson(),
  };
}

class Data {
  Data({
    required this.tokenInfo,
    required this.userInfo,
  });

  TokenInfo tokenInfo;
  UserInfo userInfo;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    tokenInfo: TokenInfo.fromJson(json["tokenInfo"]),
    userInfo: UserInfo.fromJson(json["userInfo"]),
  );

  Map<String, dynamic> toJson() => {
    "tokenInfo": tokenInfo.toJson(),
    "userInfo": userInfo.toJson(),
  };
}

class TokenInfo {
  TokenInfo({
    required this.accessToken,
    required this.timeExprise,
  });

  String accessToken;
  int timeExprise;

  factory TokenInfo.fromJson(Map<String, dynamic> json) => TokenInfo(
    accessToken: json["accessToken"],
    timeExprise: json["timeExprise"],
  );

  Map<String, dynamic> toJson() => {
    "accessToken": accessToken,
    "timeExprise": timeExprise,
  };
}

class UserInfo {
  UserInfo({
    required this.id,
    required this.active,
    required this.clientId,
    this.fullName,
    required this.userName,
    this.passwordnew,
    this.birthday,
    this.email,
    this.gender,
    this.indentity,
    this.title,
    this.photo,
    this.signature,
    this.phoneCaProvider,
    this.employeeId,
    required this.isSeller,
    required this.moneySeller,
    required this.khoiluongShipper,
    this.roles,
    this.authorize,
    this.position,
    this.groupId,
    this.address,
    required this.tenKhuVuc,
  });

  int id;
  bool active;
  int clientId;
  dynamic fullName;
  String userName;
  dynamic passwordnew;
  dynamic birthday;
  dynamic email;
  dynamic gender;
  dynamic indentity;
  dynamic title;
  dynamic photo;
  dynamic signature;
  dynamic phoneCaProvider;
  dynamic employeeId;
  bool isSeller;
  double moneySeller;
  double khoiluongShipper;
  dynamic roles;
  dynamic authorize;
  dynamic position;
  dynamic groupId;
  dynamic address;
  String tenKhuVuc;

  factory UserInfo.fromJson(Map<String, dynamic> json) => UserInfo(
    id: json["id"],
    active: json["active"],
    clientId: json["clientId"],
    fullName: json["fullName"],
    userName: json["userName"],
    passwordnew: json["passwordnew"],
    birthday: json["birthday"],
    email: json["email"],
    gender: json["gender"],
    indentity: json["indentity"],
    title: json["title"],
    photo: json["photo"],
    signature: json["signature"],
    phoneCaProvider: json["phoneCAProvider"],
    employeeId: json["employeeId"],
    isSeller: json["isSeller"],
    moneySeller: json["moneySeller"],
    khoiluongShipper: json["khoiluongShipper"],
    roles: json["roles"],
    authorize: json["authorize"],
    position: json["position"],
    groupId: json["groupId"],
    address: json["address"],
    tenKhuVuc: json["tenkhuvuc"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "active": active,
    "clientId": clientId,
    "fullName": fullName,
    "userName": userName,
    "passwordnew": passwordnew,
    "birthday": birthday,
    "email": email,
    "gender": gender,
    "indentity": indentity,
    "title": title,
    "photo": photo,
    "signature": signature,
    "phoneCAProvider": phoneCaProvider,
    "employeeId": employeeId,
    "isSeller": isSeller,
    "moneySeller": moneySeller,
    "khoiluongShipper": khoiluongShipper,
    "roles": roles,
    "authorize": authorize,
    "position": position,
    "groupId": groupId,
    "address": address,
  };
}
