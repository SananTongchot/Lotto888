import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/config.dart';
import 'package:http/http.dart' as http; // ใช้สำหรับเรียกใช้งาน HTTP
import 'dart:convert'; // ใช้สำหรับจัดการกับ JSON

class CheckPrizeAdmin extends StatefulWidget {
  final int idx;
  CheckPrizeAdmin({super.key, required this.idx});

  @override
  State<CheckPrizeAdmin> createState() => _CheckPrizeAdminState();
}

class _CheckPrizeAdminState extends State<CheckPrizeAdmin> {
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
        title: const Text("Check"),
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
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
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
                    children: [
                      const Text(
                        'รางวัลที่ 1',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const Text(
                        '123456',
                        style: TextStyle(
                          fontSize: 30,
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 8),
                      Expanded(
                        child: GridView.builder(
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 3.0,
                            mainAxisSpacing: 16.0,
                            childAspectRatio: 2.0,
                          ),
                          itemCount: prizes.length, // จำนวนการ์ด
                          itemBuilder: (context, index) {
                            return Card(
                              elevation: 5,
                              shape: const RoundedRectangleBorder(
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(30),
                                  bottom: Radius.circular(20),
                                ),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'รางวัลที่ ${index + 1}',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      prizes.isNotEmpty ? prizes[index] : 'ไม่มีข้อมูล',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
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
                  onPressed: (){
                    _fetchRandomPrizes();
                  }, // เรียกใช้งานฟังก์ชันเมื่อกดปุ่ม
                  style: ElevatedButton.styleFrom(
                    backgroundColor: const Color(0xFF2445EF),
                    padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                  ),
                  child: const Text(
                    'LOTTO888',
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
          // Actions when an item is selected
        },
      ),
    );
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
    } else {
      throw Exception('Failed to fetch prizes');
    }
  } catch (e) {
    // Handle errors
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Error: $e')),
    );
  }
}

}
