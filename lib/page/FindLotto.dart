import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/config.dart';
import 'package:http/http.dart' as http;

// นำเข้าโมเดล Lotto ของคุณ
import 'package:flutter_application_1/model/request/lottoget.dart';

class FindLottoPage extends StatefulWidget {
  final int idx;
  FindLottoPage({super.key, required this.idx});

  @override
  State<FindLottoPage> createState() => _FindLottoPageState();
}

class _FindLottoPageState extends State<FindLottoPage> {
  String url = '';
  late Future<void> loadData;
  List<Lotto> lottoData = [];
  List<Lotto> filteredLottoData = [];

  TextEditingController num1Clt = TextEditingController();
  TextEditingController num2Clt = TextEditingController();
  TextEditingController num3Clt = TextEditingController();
  TextEditingController num4Clt = TextEditingController();
  TextEditingController num5Clt = TextEditingController();
  TextEditingController num6Clt = TextEditingController();

  FocusNode num1Focus = FocusNode();
  FocusNode num2Focus = FocusNode();
  FocusNode num3Focus = FocusNode();
  FocusNode num4Focus = FocusNode();
  FocusNode num5Focus = FocusNode();
  FocusNode num6Focus = FocusNode();

  @override
  void initState() {
    super.initState();
    // เรียกใช้ loadData() ใน initState() เพื่อโหลดข้อมูลตอนเริ่มต้น
    loadData = getLottoData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 235, 229, 229),
        titleTextStyle: const TextStyle(
            color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              // Action for profile
            },
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            const DrawerHeader(
              decoration: BoxDecoration(color: Color(0xFF2445EF)),
              child: Text('Menu',
                  style: TextStyle(color: Colors.white, fontSize: 24)),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Home'),
              onTap: () {
                Navigator.pop(context);
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
                        children: [
                          _buildDigitTextField(num1Clt, num1Focus, num2Focus),
                          _buildDigitTextField(num2Clt, num2Focus, num3Focus),
                          _buildDigitTextField(num3Clt, num3Focus, num4Focus),
                          _buildDigitTextField(num4Clt, num4Focus, num5Focus),
                          _buildDigitTextField(num5Clt, num5Focus, num6Focus),
                          _buildDigitTextField(num6Clt, num6Focus, null),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 200,
                      child: FilledButton(
                        onPressed: () {
                          String searchQuery =
                              '${num1Clt.text}${num2Clt.text}${num3Clt.text}${num4Clt.text}${num5Clt.text}${num6Clt.text}';
                          searchLottoData(searchQuery); // Call the search function
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
              itemCount: filteredLottoData.length,
              itemBuilder: (context, index) {
                final lotto = filteredLottoData[index];
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
                          // ส่วนของราคาที่เป็นสีแดง
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${lotto.price}',
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
                          // ส่วนของหมายเลขสลาก
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
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
                                  lotto.lottoNumber,
                                  style: TextStyle(
                                    fontSize: 20,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          // ปุ่มและตัวคูณ
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  // Handle lotto selection
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 5,
                                    horizontal: 15,
                                  ),
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
                              const SizedBox(height: 5),
                              const Text(
                                '100x',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.black,
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
          )
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
          // Handle navigation
        },
      ),
    );
  }

  Future<void> getLottoData() async {
    var value = await Configuration.getConfig();
    url = value['apiEndpoint'];

    final apiUrl = '$url/get_lotto_for_buy';
    var response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      setState(() {
        lottoData = jsonResponse.map((data) => Lotto.fromJson(data)).toList();
        filteredLottoData = List.from(lottoData);
      });
    } else {
      log('Failed to load lotto data');
    }
  }

  void searchLottoData(String query) {
    setState(() {
      if (query.isEmpty) {
        filteredLottoData = List.from(lottoData); // แสดงทั้งหมดถ้าช่องค้นหาว่าง
      } else {
        filteredLottoData = lottoData
            .where((lotto) => lotto.lottoNumber.contains(query))
            .toList();
      }
    });
  }

  Widget _buildDigitTextField(
    TextEditingController currentController,
    FocusNode currentFocus,
    FocusNode? nextFocus,
  ) {
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
        controller: currentController,
        focusNode: currentFocus,
        textAlign: TextAlign.center,
        maxLength: 1,
        keyboardType: TextInputType.number,
        style: const TextStyle(
          fontSize: 24,
          fontWeight: FontWeight.bold,
          color: Colors.black,
        ),
        decoration: const InputDecoration(
          filled: true,
          fillColor: Colors.white,
          border: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.white, width: 0.0),
          ),
          enabledBorder: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.transparent, width: 0.0),
            borderRadius: BorderRadius.all(Radius.circular(10)),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.all(Radius.circular(10)),
            borderSide: BorderSide(color: Colors.transparent, width: 0.0),
          ),
          counterText: "",
        ),
        onChanged: (value) {
          if (value.length == 1 && nextFocus != null) {
            FocusScope.of(context).requestFocus(nextFocus);
          } else if (value.isEmpty) {
            FocusScope.of(context).previousFocus();
          }
        },
      ),
    );
  }
}
