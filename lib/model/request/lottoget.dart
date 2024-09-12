import 'dart:convert';

// Function to parse JSON data
Lotto lottoFromJson(String str) => Lotto.fromJson(json.decode(str));

// Function to convert the object to JSON format
String lottoToJson(Lotto data) => json.encode(data.toJson());

class Lotto {
  int lid;
  String lottoNumber;
  bool sold;
  int price;

  Lotto({
    required this.lid,
    required this.lottoNumber,
    required this.sold,
    required this.price,
  });

  // Factory method to create an instance from JSON data
  factory Lotto.fromJson(Map<String, dynamic> json) => Lotto(
        lid: json["lid"],
        lottoNumber: json["lotto_number"],
        sold: json["sold"],
        price: json["price"],
      );

  // Method to convert the instance to JSON format
  Map<String, dynamic> toJson() => {
        "lid": lid,
        "lotto_number": lottoNumber,
        "sold": sold,
        "price": price,
      };
}
