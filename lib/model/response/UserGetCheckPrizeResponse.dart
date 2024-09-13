// To parse this JSON data, do
//
//     final userGetCheckPrizeResponse = userGetCheckPrizeResponseFromJson(jsonString);

import 'dart:convert';

List<UserGetCheckPrizeResponse> userGetCheckPrizeResponseFromJson(String str) =>
    List<UserGetCheckPrizeResponse>.from(
        json.decode(str).map((x) => UserGetCheckPrizeResponse.fromJson(x)));

String userGetCheckPrizeResponseToJson(List<UserGetCheckPrizeResponse> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class UserGetCheckPrizeResponse {
  int lid;
  String lottoNumber;
  bool win;
  int prizeAmount;
  String prizeRank;

  UserGetCheckPrizeResponse({
    required this.lid,
    required this.lottoNumber,
    required this.win,
    required this.prizeAmount,
    required this.prizeRank,
  });

  factory UserGetCheckPrizeResponse.fromJson(Map<String, dynamic> json) =>
      UserGetCheckPrizeResponse(
        lid: json["lid"],
        lottoNumber: json["lotto_number"],
        win: json["win"],
        prizeAmount: json["prize_amount"],
        prizeRank: json["prize_rank"],
      );

  Map<String, dynamic> toJson() => {
        "lid": lid,
        "lotto_number": lottoNumber,
        "win": win,
        "prize_amount": prizeAmount,
        "prize_rank": prizeRank,
      };
}
