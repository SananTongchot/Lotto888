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

  TextEditingController num1Clt = TextEditingController();
  TextEditingController num2Clt = TextEditingController();
  TextEditingController num3Clt = TextEditingController();
  TextEditingController num4Clt = TextEditingController();
  TextEditingController num5Clt = TextEditingController();
  TextEditingController num6Clt = TextEditingController();

  @override
  void initState() {
    super.initState();
    // เรียกใช้ getLottoData() ใน initState() เพื่อโหลดข้อมูลตอนเริ่มต้น
    loadData = getLottoData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.black),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 235, 229, 229),
        titleTextStyle: const TextStyle(color: Colors.black, fontSize: 20, fontWeight: FontWeight.bold),
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
              child: Text('Menu', style: TextStyle(color: Colors.white, fontSize: 24)),
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
                          Container(
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
                              controller: num1Clt,
                              keyboardType: TextInputType.number,
                              maxLength: 1,
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
                            ),
                          ),
                          // Add other number fields here
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      width: 200,
                      child: FilledButton(
                        onPressed: () {
                          getLottoData();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(255, 118, 140, 254),
                          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
            child: FutureBuilder<void>(
              future: loadData,
              builder: (context, snapshot) {
                if (snapshot.connectionState != ConnectionState.done) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                }
                if (lottoData.isEmpty) {
                  return const Center(child: Text('ไม่มีข้อมูลล็อตเตอรี่'));
                }

                return ListView.builder(
                  itemCount: lottoData.length,
                  itemBuilder: (context, index) {
                    final lotto = lottoData[index];
                    return Card(
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
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  '${lotto.price} บาท',
                                  style: TextStyle(
                                    fontSize: 30,
                                    color: Colors.red,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  'เลข: ${lotto.lottoNumber}',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                              ],
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Handle lotto selection
                              },
                              style: ElevatedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
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
                      ),
                    );
                  },
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
          // Handle navigation
        },
      ),
    );
  }

  Future<void> getLottoData() async {
    var value = await Configuration.getConfig();
    url = value['apiEndpoint'];

    var response = await http.get(Uri.parse('$url/get_lotto_for_buy'));
    if (response.statusCode == 200) {
      List<dynamic> jsonResponse = json.decode(response.body);
      setState(() {
        lottoData = jsonResponse.map((data) => Lotto.fromJson(data)).toList();
      });
    } else {
      throw Exception('Failed to load lotto data');
    }
  }
}
