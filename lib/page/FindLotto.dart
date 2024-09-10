import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class FineLottoPage extends StatefulWidget {
  const FineLottoPage({super.key});

  @override
  State<FineLottoPage> createState() => _FineLottoPageState();
}

class _FineLottoPageState extends State<FineLottoPage> {
  TextEditingController num1Clt = TextEditingController();
  TextEditingController num2Clt = TextEditingController();
  TextEditingController num3Clt = TextEditingController();
  TextEditingController num4Clt = TextEditingController();
  TextEditingController num5Clt = TextEditingController();
  TextEditingController num6Clt = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black, // กำหนดให้ไอคอนเป็นสีขาว
        ),
        // title: const Text("Check"),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 235, 229, 229),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person), // ไอคอนรูปคน
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
              leading: Icon(Icons.home),
              title: Text('Home'),
              onTap: () {
                // การทำงานเมื่อเลือกเมนู
              },
            ),
            ListTile(
              leading: Icon(Icons.settings),
              title: Text('Settings'),
              onTap: () {
                // การทำงานเมื่อเลือกเมนู
              },
            ),
          ],
        ),
      ),
      body: Column(children: [
        SizedBox(
          width: double.infinity,
          height: 140,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30), // การโค้งมนที่มุมล่างซ้าย
              bottomRight: Radius.circular(30), // การโค้งมนที่มุมล่างขวา
            ),
            child: Container(
              color: const Color.fromARGB(
                  255, 235, 229, 229), // สีของ Container ในครึ่งบน
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
                            color: Colors.white, // กำหนดสีพื้นหลัง
                            borderRadius:
                                BorderRadius.circular(10), // ความโค้งมนของขอบ
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.5), // สีของเงาและความโปร่งใส
                                spreadRadius: 2, // กระจายเงา
                                blurRadius: 5, // ความเบลอของเงา
                                offset: Offset(
                                    0, 3), // ตำแหน่งของเงา (แนวนอน, แนวตั้ง)
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: num1Clt,
                            keyboardType: TextInputType.number,
                            maxLength: 1,

                            // controller: phoneCtl,
                            // onChanged: (value) {
                            //   log(value);
                            //   phone = value;
                            // },
                            decoration: const InputDecoration(
                              filled: true, // เปิดใช้งานสีพื้นหลัง
                              fillColor: Colors.white,

                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 0.0)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors
                                      .transparent, // ทำให้ขอบโปร่งใสเมื่อไม่ได้โฟกัส
                                  width: 0.0,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                  color: Colors
                                      .transparent, // ทำให้ขอบโปร่งใสเมื่อโฟกัส
                                  width: 0.0,
                                ),
                              ),
                              counterText: "",
                            ),
                          ),
                        ),
                        Container(
                          width: 40,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white, // กำหนดสีพื้นหลัง
                            borderRadius:
                                BorderRadius.circular(10), // ความโค้งมนของขอบ
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.5), // สีของเงาและความโปร่งใส
                                spreadRadius: 2, // กระจายเงา
                                blurRadius: 5, // ความเบลอของเงา
                                offset: Offset(
                                    0, 3), // ตำแหน่งของเงา (แนวนอน, แนวตั้ง)
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: num2Clt,
                            keyboardType: TextInputType.number,
                            maxLength: 1,

                            // controller: phoneCtl,
                            // onChanged: (value) {
                            //   log(value);
                            //   phone = value;
                            // },
                            decoration: const InputDecoration(
                              filled: true, // เปิดใช้งานสีพื้นหลัง
                              fillColor: Colors.white,

                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 0.0)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors
                                      .transparent, // ทำให้ขอบโปร่งใสเมื่อไม่ได้โฟกัส
                                  width: 0.0,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                  color: Colors
                                      .transparent, // ทำให้ขอบโปร่งใสเมื่อโฟกัส
                                  width: 0.0,
                                ),
                              ),
                              counterText: "",
                            ),
                          ),
                        ),
                        Container(
                          width: 40,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white, // กำหนดสีพื้นหลัง
                            borderRadius:
                                BorderRadius.circular(10), // ความโค้งมนของขอบ
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.5), // สีของเงาและความโปร่งใส
                                spreadRadius: 2, // กระจายเงา
                                blurRadius: 5, // ความเบลอของเงา
                                offset: Offset(
                                    0, 3), // ตำแหน่งของเงา (แนวนอน, แนวตั้ง)
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: num3Clt,
                            keyboardType: TextInputType.number,
                            maxLength: 1,

                            // controller: phoneCtl,
                            // onChanged: (value) {
                            //   log(value);
                            //   phone = value;
                            // },
                            decoration: const InputDecoration(
                              filled: true, // เปิดใช้งานสีพื้นหลัง
                              fillColor: Colors.white,

                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 0.0)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors
                                      .transparent, // ทำให้ขอบโปร่งใสเมื่อไม่ได้โฟกัส
                                  width: 0.0,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                  color: Colors
                                      .transparent, // ทำให้ขอบโปร่งใสเมื่อโฟกัส
                                  width: 0.0,
                                ),
                              ),
                              counterText: "",
                            ),
                          ),
                        ),
                        Container(
                          width: 40,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white, // กำหนดสีพื้นหลัง
                            borderRadius:
                                BorderRadius.circular(10), // ความโค้งมนของขอบ
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.5), // สีของเงาและความโปร่งใส
                                spreadRadius: 2, // กระจายเงา
                                blurRadius: 5, // ความเบลอของเงา
                                offset: Offset(
                                    0, 3), // ตำแหน่งของเงา (แนวนอน, แนวตั้ง)
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: num4Clt,
                            keyboardType: TextInputType.number,
                            maxLength: 1,

                            // controller: phoneCtl,
                            // onChanged: (value) {
                            //   log(value);
                            //   phone = value;
                            // },
                            decoration: const InputDecoration(
                              filled: true, // เปิดใช้งานสีพื้นหลัง
                              fillColor: Colors.white,

                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 0.0)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors
                                      .transparent, // ทำให้ขอบโปร่งใสเมื่อไม่ได้โฟกัส
                                  width: 0.0,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                  color: Colors
                                      .transparent, // ทำให้ขอบโปร่งใสเมื่อโฟกัส
                                  width: 0.0,
                                ),
                              ),
                              counterText: "",
                            ),
                          ),
                        ),
                        Container(
                          width: 40,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white, // กำหนดสีพื้นหลัง
                            borderRadius:
                                BorderRadius.circular(10), // ความโค้งมนของขอบ
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.5), // สีของเงาและความโปร่งใส
                                spreadRadius: 2, // กระจายเงา
                                blurRadius: 5, // ความเบลอของเงา
                                offset: Offset(
                                    0, 3), // ตำแหน่งของเงา (แนวนอน, แนวตั้ง)
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: num5Clt,
                            keyboardType: TextInputType.number,
                            maxLength: 1,

                            // controller: phoneCtl,
                            // onChanged: (value) {
                            //   log(value);
                            //   phone = value;
                            // },
                            decoration: const InputDecoration(
                              filled: true, // เปิดใช้งานสีพื้นหลัง
                              fillColor: Colors.white,

                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 0.0)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors
                                      .transparent, // ทำให้ขอบโปร่งใสเมื่อไม่ได้โฟกัส
                                  width: 0.0,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                  color: Colors
                                      .transparent, // ทำให้ขอบโปร่งใสเมื่อโฟกัส
                                  width: 0.0,
                                ),
                              ),
                              counterText: "",
                            ),
                          ),
                        ),
                        Container(
                          width: 40,
                          height: 60,
                          decoration: BoxDecoration(
                            color: Colors.white, // กำหนดสีพื้นหลัง
                            borderRadius:
                                BorderRadius.circular(10), // ความโค้งมนของขอบ
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey
                                    .withOpacity(0.5), // สีของเงาและความโปร่งใส
                                spreadRadius: 2, // กระจายเงา
                                blurRadius: 5, // ความเบลอของเงา
                                offset: Offset(
                                    0, 3), // ตำแหน่งของเงา (แนวนอน, แนวตั้ง)
                              ),
                            ],
                          ),
                          child: TextField(
                            controller: num6Clt,
                            keyboardType: TextInputType.number,
                            maxLength: 1,

                            // controller: phoneCtl,
                            // onChanged: (value) {
                            //   log(value);
                            //   phone = value;
                            // },
                            decoration: const InputDecoration(
                              filled: true, // เปิดใช้งานสีพื้นหลัง
                              fillColor: Colors.white,

                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(10)),
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 0.0)),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors
                                      .transparent, // ทำให้ขอบโปร่งใสเมื่อไม่ได้โฟกัส
                                  width: 0.0,
                                ),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(10)),
                                borderSide: BorderSide(
                                  color: Colors
                                      .transparent, // ทำให้ขอบโปร่งใสเมื่อโฟกัส
                                  width: 0.0,
                                ),
                              ),
                              counterText: "",
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 20,
                  ),
                  SizedBox(
                    width: 200,
                    child: FilledButton(
                        onPressed: () {
                          getnum();
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                              255, 118, 140, 254), // เปลี่ยนสีพื้นหลังของปุ่ม
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16, vertical: 8), // เพิ่ม padding
                        ),
                        child: Text('ค้นหาล๊อตเตอรี่')),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          height: 10,
        ),
        SizedBox(
          width: 360,
          height: 103,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // การโค้งมนของการ์ด
            ),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.lightBlue[50], // สีพื้นหลังของการ์ด
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // ส่วนของราคาที่เป็นสีแดง
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
                  // ส่วนของหมายเลขสลาก
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
                          color: Colors.blue[300], // สีพื้นหลังของเลขสลาก
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          '13424532',
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
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 15,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20),
                            ),
                            backgroundColor: Colors.white
                            // primary: Colors.white, // สีพื้นหลังของปุ่ม
                            // onPrimary: Colors.grey, // สีของข้อความปุ่ม
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
        ),
        SizedBox(
          width: 360,
          height: 103,
          child: Card(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20), // การโค้งมนของการ์ด
            ),
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.lightBlue[50], // สีพื้นหลังของการ์ด
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // ส่วนของราคาที่เป็นสีแดง
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
                  // ส่วนของหมายเลขสลาก
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
                          color: Colors.blue[300], // สีพื้นหลังของเลขสลาก
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Text(
                          '13424532',
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
                        onPressed: () {},
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            vertical: 5,
                            horizontal: 15,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          // primary: Colors.white, // สีพื้นหลังของปุ่ม
                          // onPrimary: Colors.grey, // สีของข้อความปุ่ม
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
        ),
      ]),
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

  void getnum() {
    // num1Clt.text
    log(num1Clt.text +
        num2Clt.text +
        num3Clt.text +
        num4Clt.text +
        num5Clt.text +
        num6Clt.text);
  }
}
