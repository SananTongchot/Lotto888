// To parse this JSON data, do
//
//     final get5WinResponse = get5WinResponseFromJson(jsonString);

import 'dart:convert';

List<Get5WinResponse> get5WinResponseFromJson(String str) => List<Get5WinResponse>.from(json.decode(str).map((x) => Get5WinResponse.fromJson(x)));

String get5WinResponseToJson(List<Get5WinResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Get5WinResponse {
    String lottoNumber;
    int prizeAmount;
    int lid;

    Get5WinResponse({
        required this.lottoNumber,
        required this.prizeAmount,
        required this.lid,
    });

    factory Get5WinResponse.fromJson(Map<String, dynamic> json) => Get5WinResponse(
        lottoNumber: json["lotto_number"],
        prizeAmount: json["prize_amount"],
        lid: json["lid"],
    );

    Map<String, dynamic> toJson() => {
        "lotto_number": lottoNumber,
        "prize_amount": prizeAmount,
        "lid": lid,
    };
}
