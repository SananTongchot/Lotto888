// To parse this JSON data, do
//
//     final purchasedRespone = purchasedResponeFromJson(jsonString);

import 'dart:convert';

List<PurchasedRespone> purchasedResponeFromJson(String str) => List<PurchasedRespone>.from(json.decode(str).map((x) => PurchasedRespone.fromJson(x)));

String purchasedResponeToJson(List<PurchasedRespone> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class PurchasedRespone {
    int lid;
    String lottoNumber;
    int amountPrice;
    int amountLottery;

    PurchasedRespone({
        required this.lid,
        required this.lottoNumber,
        required this.amountPrice,
        required this.amountLottery,
    });

    factory PurchasedRespone.fromJson(Map<String, dynamic> json) => PurchasedRespone(
        lid: json["lid"],
        lottoNumber: json["lotto_number"],
        amountPrice: json["amount_price"],
        amountLottery: json["amount_lottery"],
    );

    Map<String, dynamic> toJson() => {
        "lid": lid,
        "lotto_number": lottoNumber,
        "amount_price": amountPrice,
        "amount_lottery": amountLottery,
    };
}
