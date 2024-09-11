// To parse this JSON data, do
//
//     final userRegisterPostRequest = userRegisterPostRequestFromJson(jsonString);

import 'dart:convert';

UserRegisterPostRequest userRegisterPostRequestFromJson(String str) =>
    UserRegisterPostRequest.fromJson(json.decode(str));

String userRegisterPostRequestToJson(UserRegisterPostRequest data) =>
    json.encode(data.toJson());

class UserRegisterPostRequest {
  String username;
  String phone;
  String email;
  String password;

  UserRegisterPostRequest({
    required this.username,
    required this.phone,
    required this.email,
    required this.password,
  });

  factory UserRegisterPostRequest.fromJson(Map<String, dynamic> json) =>
      UserRegisterPostRequest(
        username: json["username"],
        phone: json["phone"],
        email: json["email"],
        password: json["password"],
      );

  Map<String, dynamic> toJson() => {
        "username": username,
        "phone": phone,
        "email": email,
        "password": password,
      };
}
