import 'package:flutter/material.dart';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/config.dart';
import 'package:flutter_application_1/model/response/LotteryGetResponse.dart';
import 'package:flutter_application_1/page/AdminPage/ChckPrizeAdmin.dart';
import 'package:flutter_application_1/page/AdminPage/ProfileAdmin.dart';
import 'package:http/http.dart' as http; // ใช้สำหรับเรียกใช้งาน HTTP
import 'dart:convert'; // ใช้สำหรับจัดการกับ JSON

class RandomPage extends StatefulWidget {
  final int idx;
  RandomPage({super.key, required this.idx});

  @override
  State<RandomPage> createState() => _RandomPageState();
}

class _RandomPageState extends State<RandomPage> {
  List<LotteryGetResponse> lotteries = [];
  int lastFilledIndex = -1;
  List<TextEditingController> numControllers =
      List.generate(6, (index) => TextEditingController());
  List<FocusNode> focusNodes = List.generate(6, (index) => FocusNode());
  String url = ""; // ตัวแปรสำหรับเก็บ URL
  List<String> prizes = []; // ตัวแปรสำหรับเก็บรางวัล

  @override
  void initState() {
    super.initState();
    // ดึง URL จาก Configuration
    Configuration.getConfig().then((config) {
      setState(() {
        url = config['apiEndpoint'] ?? "";
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text("RANDOM"),
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
              // การทำงานเมื่อกดไอคอนรูปคน
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
                // การทำงานเมื่อเลือกเมนู
              },
            ),
            ListTile(
              leading: const Icon(Icons.delete),
              title: const Text('Reset System'),
              onTap: () {
                // การทำงานเมื่อเลือกเมนู
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 2,
            child: SizedBox(
              child: ClipRRect(
                borderRadius: const BorderRadius.only(
                  bottomLeft: Radius.circular(30),
                  bottomRight: Radius.circular(30),
                ),
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.white, // สีพื้นหลังของ Container
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black, // สีของเงาที่เบาลง
                        spreadRadius: 1, // ขยายรัศมีของเงา
                        blurRadius: 8, // ความเบลอของเงาที่มากขึ้น
                        offset: Offset(0, 4), // การเลื่อนของเงา
                      ),
                    ],
                  ),
                  child: SizedBox(
                    width: double.infinity,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: ListView.builder(
                          itemCount: lotteries.length,
                          itemBuilder: (context, index) {
                            final lottery = lotteries[index];
                            return SizedBox(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  // Price section
                                  const Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
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
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
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
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                        child: Text(
                                          // lottery.lottoNumber,
                                          "554698",
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
                                        },
                                        style: ElevatedButton.styleFrom(
                                          padding: const EdgeInsets.symmetric(
                                              vertical: 5, horizontal: 15),
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(20),
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
                            );
                            // ];
                          }),
                    ),
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3,
            child: Container(
              color: Colors.white,
              child: Center(
                child: ElevatedButton(
                  onPressed: () {
                    _fetchRandomPrizes();
                  }, // เรียกใช้งานฟังก์ชันเมื่อกดปุ่ม
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2445EF),
                    padding: const EdgeInsets.symmetric(
                        horizontal: 40, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    'RANDOM',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: const Color(0xFF2445EF),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white70,
        type: BottomNavigationBarType.fixed,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon:
                Icon(Icons.shuffle), // เปลี่ยนเป็นไอคอนที่เกี่ยวข้องกับการสุ่ม
            label: 'Random',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money),
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
            builder: (context) => CheckPrizeAdmin(idx: widget.idx),
          ));
    } else if (index == 2) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Profileadmin(idx: widget.idx),
          ));
    }
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

  Future<void> _fetchRandomPrizes() async {
    if (url.isEmpty) {
      // URL not set
      return;
    }

    try {
      final response = await http.get(Uri.parse('$url/random'));
      log(response.body);
      if (response.statusCode == 200) {
        final data = json.decode(response.body) as Map<String, dynamic>;
        setState(() {
          prizes = List<String>.from(data['numbers'] ?? []);
        });

        // แสดง SnackBar เมื่อข้อมูลดึงสำเร็จ
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('รางวัลได้รับการอัปเดตเรียบร้อยแล้ว!'),
            backgroundColor: Colors.green,
            duration: Duration(seconds: 2),
          ),
        );
      } else {
        throw Exception('Failed to fetch prizes');
      }
    } catch (e) {
      // Handle errors
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('ข้อผิดพลาด'),
            content: Text('Error: $e'),
            actions: <Widget>[
              TextButton(
                child: Text('ตกลง'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }
  }
}
