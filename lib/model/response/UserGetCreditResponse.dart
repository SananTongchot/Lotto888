// To parse this JSON data, do
//
//     final userGetCreditResponse = userGetCreditResponseFromJson(jsonString);

import 'dart:convert';

UserGetCreditResponse userGetCreditResponseFromJson(String str) =>
    UserGetCreditResponse.fromJson(json.decode(str));

String userGetCreditResponseToJson(UserGetCreditResponse data) =>
    json.encode(data.toJson());

class UserGetCreditResponse {
  int uid;
  String username;
  String phone;
  String email;
  String password;
  String type;
  int credit;

  UserGetCreditResponse({
    required this.uid,
    required this.username,
    required this.phone,
    required this.email,
    required this.password,
    required this.type,
    required this.credit,
  });

  factory UserGetCreditResponse.fromJson(Map<String, dynamic> json) =>
      UserGetCreditResponse(
        uid: json["uid"],
        username: json["username"],
        phone: json["phone"],
        email: json["email"],
        password: json["password"],
        type: json["type"],
        credit: json["credit"],
      );

  Map<String, dynamic> toJson() => {
        "uid": uid,
        "username": username,
        "phone": phone,
        "email": email,
        "password": password,
        "type": type,
        "credit": credit,
      };
}
