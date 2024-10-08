import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/config.dart';
import 'package:flutter_application_1/model/response/LotteryGetResponse.dart';
import 'package:flutter_application_1/page/CheckPrize.dart';
import 'package:flutter_application_1/page/EditProfileUser.dart';
import 'package:flutter_application_1/page/ProfileUser.dart';
import 'package:flutter_application_1/page/Wallet.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:provider/provider.dart';

class FindLottoPage extends StatefulWidget {
  final int idx;

  const FindLottoPage({super.key, required this.idx});

  @override
  State<FindLottoPage> createState() => _FindLottoPageState();
}

class _FindLottoPageState extends State<FindLottoPage> {
  String url = '';
  List<LotteryGetResponse> lotteries = [];

  List<TextEditingController> numControllers =
      List.generate(6, (index) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());

  int lastFilledIndex = -1; // Index of the last filled TextField

  @override
  void initState() {
    super.initState();
    Configuration.getConfig().then((config) {
      setState(() {
        url = config['apiEndpoint'];
        getLotto(); // Fetch all lotto data initially
      });
    });
  }

  Future<void> getLotto() async {
    if (url.isEmpty) {
      log("API URL is not set.");
      return;
    }

    try {
      final response = await http.get(
        Uri.parse("$url/get_lotto_for_buy"),
        headers: {"Content-Type": "application/json; charset=utf-8"},
      );

      if (response.statusCode == 200) {
        setState(() {
          lotteries = lotteryGetResponseFromJson(response.body);
          resetControllers(); // Reset controllers after fetching data
        });
      } else {
        log('Failed to load lotto data: ${response.statusCode}');
      }
    } catch (e) {
      log('Error occurred while fetching lotto data: $e');
    }
  }

  void resetControllers() {
    for (var controller in numControllers) {
      controller.clear(); // Clear text in each controller
    }
    lastFilledIndex = -1; // Reset the index of last filled TextField
    for (var node in focusNodes) {
      node.unfocus(); // Unfocus any focus nodes
    }
  }

  @override
  Widget build(BuildContext context) {
    final cartProvider = Provider.of<CartProvider>(context);
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 235, 229, 229),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              getLotto(); // Refresh data and reset controllers
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Color(0xFF2445EF),
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Action when Settings menu is selected
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 140,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              child: Container(
                color: const Color.fromARGB(255, 235, 229, 229),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 0, 40, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: List.generate(6, (index) {
                          return Container(
                            width: 40,
                            height: 60,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 2,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: TextField(
                              controller: numControllers[index],
                              focusNode: focusNodes[index],
                              keyboardType: TextInputType.number,
                              maxLength: 1,
                              decoration: const InputDecoration(
                                filled: true,
                                fillColor: Colors.white,
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 0.0),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.transparent, width: 0.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      color: Colors.transparent, width: 0.0),
                                ),
                                counterText: "",
                              ),
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  lastFilledIndex = index;
                                  if (index < 5) {
                                    FocusScope.of(context)
                                        .requestFocus(focusNodes[index + 1]);
                                  }
                                } else {
                                  if (index > 0 && lastFilledIndex == index) {
                                    FocusScope.of(context)
                                        .requestFocus(focusNodes[index - 1]);
                                    lastFilledIndex = index - 1;
                                  }
                                }
                              },
                              onEditingComplete: () {
                                if (index < 5) {
                                  FocusScope.of(context)
                                      .requestFocus(focusNodes[index + 1]);
                                } else {
                                  FocusScope.of(context).unfocus();
                                }
                              },
                            ),
                          );
                        }),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 200,
                      child: FilledButton(
                        onPressed: () {
                          getnum();
                          filterLotto(); // Call the filterLotto method
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor:
                              const Color.fromARGB(255, 118, 140, 254),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8),
                        ),
                        child: const Text('ค้นหาล๊อตเตอรี่'),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: lotteries.length,
              itemBuilder: (context, index) {
                final lottery = lotteries[index];
                return SizedBox(
                  width: 360,
                  height: 103,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.lightBlue[50],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          // Price section
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    '80',
                                    style: TextStyle(
                                      fontSize: 30,
                                      color: Colors.red,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  Text(
                                    'บาท',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.red,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          // Lottery number section
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const Text(
                                'สลากกินแบ่งรัฐบาล',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 5, horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.blue[300],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  lottery.lottoNumber,
                                  style: const TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // Button and multiplier
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  // แสดง AlertDialog เพื่อยืนยันการซื้อลอตเตอรี
                                  showDialog(
                                    context: context,
                                    builder: (BuildContext context) {
                                      return AlertDialog(
                                        title: const Text(
                                          "ยืนยัน",
                                          textAlign: TextAlign
                                              .center, // จัดข้อความให้อยู่ตรงกลาง
                                          style: TextStyle(
                                            fontWeight: FontWeight
                                                .bold, // ทำให้ตัวอักษรหนา
                                            fontSize:
                                                18, // ปรับขนาดตัวอักษรหากต้องการ
                                          ),
                                        ),
                                        content: const Text(
                                          "คุณจะซื้อลอตเตอรีนี้ใช่มั้ย?",
                                          textAlign: TextAlign
                                              .center, // จัดข้อความให้อยู่ตรงกลาง
                                        ),
                                        actions: [
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment
                                                .center, // จัดให้อยู่ตรงกลาง
                                            children: [
                                              TextButton(
                                                onPressed: () {
                                                  cartProvider.addItem(
                                                      lottery.lid.toString(),
                                                      lottery.price,
                                                      lottery.lottoNumber);
                                                  Navigator.of(context).pop();
                                                  // Navigator.push(
                                                  //     context,
                                                  //     MaterialPageRoute(
                                                  //         builder: (context) =>
                                                  //             Wallet(
                                                  //               idx: widget.idx,
                                                  //             ))); // ปิด dialog เมื่อกด "ใช่"
                                                },
                                                child: const Text("ใช่"),
                                                style: TextButton.styleFrom(
                                                  foregroundColor: Colors.white,
                                                  backgroundColor:
                                                      const Color(0xFF2445EF),
                                                ),
                                              ),
                                              const SizedBox(
                                                  width:
                                                      70), // ระยะห่างระหว่างปุ่ม
                                              TextButton(
                                                onPressed: () {
                                                  Navigator.of(context)
                                                      .pop(); // ปิด dialog เมื่อกด "ไม่"
                                                },
                                                child: const Text("ไม่"),
                                                style: TextButton.styleFrom(
                                                  foregroundColor: Colors.white,
                                                  backgroundColor:
                                                      Color.fromARGB(
                                                          255, 251, 61, 61),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      );
                                    },
                                  );
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 15),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  backgroundColor: Colors.white,
                                ),
                                child: const Text(
                                  'เลือก',
                                  style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF2445EF),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        type: BottomNavigationBarType.fixed,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopify),
            label: 'Shop',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_card),
            label: 'Lotto',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_pin),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          tapbarNavigator(index);
          // Actions when an item is selected
        },
      ),
    );
  }

  void tapbarNavigator(int index) {
    log(index.toString());
    if (index == 0) {
    } else if (index == 1) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Wallet(idx: widget.idx),
          ));
    } else if (index == 2) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Checkprizepage(idx: widget.idx),
          ));
    } else if (index == 3) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Profileuser(idx: widget.idx),
          ));
    }
  }

  void getnum() {
    final numbers =
        numControllers.map((controller) => controller.text).join('');
    log(numbers);
  }

  void filterLotto() {
    final searchQuery =
        numControllers.map((controller) => controller.text).join('');
    List<LotteryGetResponse> filteredLotteries = [];

    log('Number of lotteries before filtering: ${lotteries.length}');

    if (searchQuery.isNotEmpty) {
      filteredLotteries = lotteries.where((lottery) {
        return lottery.lottoNumber.contains(searchQuery);
      }).toList();
    } else {
      filteredLotteries = lotteries;
    }

    setState(() {
      lotteries = filteredLotteries;
    });
  }
}

class CartItem {
  final String id;
  final String LottoNmuber;
  final int quantity;
  final int price;

  CartItem({
    required this.id,
    required this.LottoNmuber,
    required this.quantity,
    required this.price,
  });
}

class CartProvider with ChangeNotifier {
  Map<String, CartItem> _items = {};

  Map<String, CartItem> get items {
    return {..._items};
  }

  double get totalAmount {
    double total = 0.0;
    _items.forEach((key, cartItem) {
      total += cartItem.price * cartItem.quantity;
    });
    return total;
  }

  void addItem(String productId, int price, String LottoNmuber) {
    // if (_items.containsKey(productId)) {
    //   _items.update(
    //     productId.toString(),
    //     (existingCartItem) => CartItem(
    //       id: existingCartItem.id,
    //       LottoNmuber: existingCartItem.LottoNmuber,
    //       quantity: existingCartItem.quantity + 1,
    //       price: existingCartItem.price,
    //     ),
    //   );
    // } else {
    _items.putIfAbsent(
      productId.toString(),
      () => CartItem(
        id: productId, // ใช้ productId ตรงๆ เป็น id
        LottoNmuber: LottoNmuber,
        quantity: 1,
        price: price,
      ),
    );
    // }
    notifyListeners();
  }

  void removeItem(String productId) {
    log("Attempting to remove item with ID: $productId");

    // แสดงรายการสินค้าในตะกร้าทั้งหมด
    _items.forEach((key, item) {
      log("Item in cart - ID: ${item.id}, Quantity: ${item.quantity}");
    });

    try {
      if (_items.containsKey(productId)) {
        // ดึงข้อมูลของสินค้า
        final cartItem = _items[productId]!;

        if (cartItem.quantity > 1) {
          // หากจำนวนสินค้ามากกว่า 1 ชิ้น ลดจำนวนลงทีละชิ้น
          _items.update(
            productId,
            (existingCartItem) => CartItem(
              id: existingCartItem.id,
              LottoNmuber: existingCartItem.LottoNmuber,
              quantity: existingCartItem.quantity - 1,
              price: existingCartItem.price,
            ),
          );
        } else {
          // หากจำนวนสินค้าน้อยกว่าหรือเท่ากับ 1 ชิ้น ลบออกจากตะกร้า
          _items.remove(productId);
        }

        // อัพเดต UI
        notifyListeners();
        log("Item updated or removed successfully");
      } else {
        log("Item with ID: $productId not found");
        throw Exception('Item not found');
      }
    } catch (e) {
      log('Failed to remove item: ${e.toString()}');
      throw Exception('Failed to remove item: ${e.toString()}');
    }
  }

  // ฟังก์ชันสำหรับล้างข้อมูลทั้งหมดในตะกร้า
  void clearCart() {
    _items = {}; // กำหนดตะกร้าใหม่ให้เป็นค่าว่าง
    notifyListeners(); // แจ้งให้ UI อัพเดต
  }
}
