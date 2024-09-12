//     final lotteryGetResponse = lotteryGetResponseFromJson(jsonString);

import 'dart:convert';

List<LotteryGetResponse> lotteryGetResponseFromJson(String str) => List<LotteryGetResponse>.from(json.decode(str).map((x) => LotteryGetResponse.fromJson(x)));

String lotteryGetResponseToJson(List<LotteryGetResponse> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class LotteryGetResponse {
    int lid;
    String lottoNumber;
    bool sold;
    int price;

    LotteryGetResponse({
        required this.lid,
        required this.lottoNumber,
        required this.sold,
        required this.price,
    });

    factory LotteryGetResponse.fromJson(Map<String, dynamic> json) => LotteryGetResponse(
        lid: json["lid"],
        lottoNumber: json["lotto_number"],
        sold: json["sold"],
        price: json["price"],
    );

    Map<String, dynamic> toJson() => {
        "lid": lid,
        "lotto_number": lottoNumber,
        "sold": sold,
        "price": price,
    };
}
