// To parse this JSON data, do
//
//     final userGetRewardsResponse = userGetRewardsResponseFromJson(jsonString);

import 'dart:convert';

UserGetRewardsResponse userGetRewardsResponseFromJson(String str) =>
    UserGetRewardsResponse.fromJson(json.decode(str));

String userGetRewardsResponseToJson(UserGetRewardsResponse data) =>
    json.encode(data.toJson());

class UserGetRewardsResponse {
  int currentCredit;
  String message;
  int previousCredit;
  int totalPrizeAmount;
  List<WinningNumber> winningNumbers;

  UserGetRewardsResponse({
    required this.currentCredit,
    required this.message,
    required this.previousCredit,
    required this.totalPrizeAmount,
    required this.winningNumbers,
  });

  factory UserGetRewardsResponse.fromJson(Map<String, dynamic> json) =>
      UserGetRewardsResponse(
        currentCredit: json["current_credit"],
        message: json["message"],
        previousCredit: json["previous_credit"],
        totalPrizeAmount: json["total_prize_amount"],
        winningNumbers: List<WinningNumber>.from(
            json["winning_numbers"].map((x) => WinningNumber.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "current_credit": currentCredit,
        "message": message,
        "previous_credit": previousCredit,
        "total_prize_amount": totalPrizeAmount,
        "winning_numbers":
            List<dynamic>.from(winningNumbers.map((x) => x.toJson())),
      };
}

class WinningNumber {
  int lid;
  String lottoNumber;
  int prizeAmount;

  WinningNumber({
    required this.lid,
    required this.lottoNumber,
    required this.prizeAmount,
  });

  factory WinningNumber.fromJson(Map<String, dynamic> json) => WinningNumber(
        lid: json["lid"],
        lottoNumber: json["lotto_number"],
        prizeAmount: json["prize_amount"],
      );

  Map<String, dynamic> toJson() => {
        "lid": lid,
        "lotto_number": lottoNumber,
        "prize_amount": prizeAmount,
      };
}
