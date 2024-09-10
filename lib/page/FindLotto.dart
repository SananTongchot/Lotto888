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
          height: 200,
          child: ClipRRect(
            borderRadius: const BorderRadius.only(
              bottomLeft: Radius.circular(30), // การโค้งมนที่มุมล่างซ้าย
              bottomRight: Radius.circular(30), // การโค้งมนที่มุมล่างขวา
            ),
            child: Container(
              color: const Color.fromARGB(
                  255, 235, 229, 229), // สีของ Container ในครึ่งบน
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
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
                          ),
                        ),
                      )
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
  }
}
