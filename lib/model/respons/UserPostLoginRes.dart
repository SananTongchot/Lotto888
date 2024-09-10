// To parse this JSON data, do
//
//     final userPostLoginResponse = userPostLoginResponseFromJson(jsonString);

import 'dart:convert';

UserPostLoginResponse userPostLoginResponseFromJson(String str) =>
    UserPostLoginResponse.fromJson(json.decode(str));

String userPostLoginResponseToJson(UserPostLoginResponse data) =>
    json.encode(data.toJson());

class UserPostLoginResponse {
  int uid;
  String username;
  String phone;
  String email;
  String password;
  String type;
  String credit;

  UserPostLoginResponse({
    required this.uid,
    required this.username,
    required this.phone,
    required this.email,
    required this.password,
    required this.type,
    required this.credit,
  });

  factory UserPostLoginResponse.fromJson(Map<String, dynamic> json) =>
      UserPostLoginResponse(
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
