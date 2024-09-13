import 'dart:convert';
import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_application_1/config/config.dart';
import 'package:flutter_application_1/model/response/UserGetCreditResponse.dart';
import 'package:flutter_application_1/page/CheckPrize.dart';
import 'package:flutter_application_1/page/EditProfileUser.dart';
import 'package:flutter_application_1/page/FindLotto.dart';
import 'package:flutter_application_1/page/ProfileUser.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class Wallet extends StatefulWidget {
  int idx = 0;
  Wallet({super.key, required this.idx});
  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  int count = 0; // จำนวนสินค้า
  int countPrice = 0; // ราคารวมสินค้า
  int credit = 0; // ค่าเริ่มต้นของ credit

  @override
  void initState() {
    super.initState();
    getUser(); // เรียก getUser() ตอนเริ่มต้น
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text("Wallet"),
        centerTitle: true,
        backgroundColor: const Color(0xFF2445EF),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // Action for the person icon
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
                // Action for Home
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Action for Settings
              },
            ),
          ],
        ),
      ),
      body: Consumer<CartProvider>(
        builder: (context, cartProvider, child) {
          final items = cartProvider.items;

          // คำนวณจำนวนและราคารวมใหม่
          count = items.length; // นับจำนวนสินค้าทั้งหมด
          countPrice = items.values.fold(
              0,
              (sum, item) =>
                  sum +
                  item.quantity * 80); // คำนวณราคารวม (สมมติสินค้าราคา 80 บาท)

          return Column(
            children: [
              SizedBox(
                width: double.infinity,
                height: 103,
                child: ClipRRect(
                  borderRadius: const BorderRadius.only(
                    bottomLeft: Radius.circular(30),
                    bottomRight: Radius.circular(30),
                  ),
                  child: Container(
                    color: const Color(0xFF2445EF),
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'Balance',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.normal,
                                    ),
                                  ),
                                  Text(
                                    '฿ $credit', // แสดงค่า credit
                                    style: const TextStyle(
                                      fontSize: 30,
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                              Image.asset('assets/images/Icon.png'),
                            ],
                          ),
                          const SizedBox(height: 8),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              // Use Flexible or Expanded to fit the ListView inside the Column
              Expanded(
                // flex: 2,
                child: ListView.builder(
                  itemCount: items.length,
                  itemBuilder: (context, index) {
                    final cartItem = items.values.toList()[index];
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
                                      vertical: 5,
                                      horizontal: 10,
                                    ),
                                    decoration: BoxDecoration(
                                      color: Colors.blue[300],
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      "${cartItem.LottoNmuber}",
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  ElevatedButton(
                                    onPressed: () {
                                      cartProvider
                                          .removeItem(cartItem.id.toString());
                                    },
                                    style: ElevatedButton.styleFrom(
                                      padding: const EdgeInsets.symmetric(
                                        vertical: 5,
                                        horizontal: 15,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(20),
                                      ),
                                    ),
                                    child: const Text(
                                      'ลบ',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 14,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  Text(
                                    "${cartItem.quantity}x",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Color.fromARGB(255, 255, 96, 96),
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
              // แสดงจำนวนและราคารวม
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 20, 0, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'จำนวน',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          count.toString(), // แสดงจำนวนสินค้าทั้งหมด
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'ราคา',
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          countPrice.toString(), // แสดงราคารวมสินค้า
                          style: const TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ],
                    ),
                    FilledButton(
                      onPressed: () {
                        payLottetry(context);
                        // Action for payment
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color.fromARGB(255, 118, 140, 254),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 8),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text(
                        'ชำระเงิน',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          );
        },
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
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FindLottoPage(idx: widget.idx),
          ));
    } else if (index == 1) {
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => Wallet(idx: widget.idx),
      //     ));
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

  void payLottetry(bu) async {
    final cartProvider = Provider.of<CartProvider>(context, listen: false);
    log("Pay");

    // ดึงข้อมูลจาก CartProvider
    List<int> lids = cartProvider.items.values
        .map((cartItem) => int.parse(cartItem.id))
        .toList(); // แปลง id จาก String เป็น int

    var config = await Configuration.getConfig();
    var url = config['apiEndpoint'];

    // สร้างโมเดลข้อมูลที่จะส่งไปใน API
    var model = {
      "uid": widget.idx, // ดึง uid จาก widget ที่ส่งเข้ามา
      "lids": lids, // ส่ง list ของ id ในรูปแบบ List ไม่ใช่ String
    };

    log(model.toString());

    // ส่งข้อมูลผ่าน HTTP POST request
    http
        .post(
      Uri.parse("$url/buy_lottery"),
      headers: {"Content-Type": "application/json; charset=utf-8"},
      body: jsonEncode(model),
    )
        .then((value) {
      // เมื่อส่งข้อมูลสำเร็จ ล้างตะกร้า
      cartProvider.clearCart(); // เรียกใช้ฟังก์ชัน clearCart เพื่อล้างข้อมูล
      log("pay2");
      log(value.body);
      setState(() {
        getUser();
      });
    }).catchError((err) {
      log("Error: $err");
      setState(() {});
    });
  }

  Future<void> getUser() async {
    try {
      var config = await Configuration.getConfig();
      var url = config['apiEndpoint'];
      var model = {"uid": widget.idx};

      var response = await http.post(
        Uri.parse("$url/get1"),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(model),
      );

      if (response.statusCode == 200) {
        var jsonResponse = jsonDecode(response.body);
        setState(() {
          credit = jsonResponse[
              'credit']; // อัพเดต credit และเรียก setState เพื่ออัพเดต UI
        });
        log(credit.toString());
      } else {
        log('Request failed with status: ${response.statusCode}');
      }
    } catch (e) {
      log('Error occurred: $e');
    }
  }
}
