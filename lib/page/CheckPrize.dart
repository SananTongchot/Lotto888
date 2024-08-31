import 'package:flutter/material.dart';

class Checkprizepage extends StatefulWidget {
  const Checkprizepage({super.key});

  @override
  State<Checkprizepage> createState() => CheckprizeState();
}

class CheckprizeState extends State<Checkprizepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, // กำหนดให้ไอคอนเป็นสีขาว
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
      body: Column(
        children: [
          Expanded(
            flex: 2, // ขนาดของครึ่งบน
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30), // การโค้งมนที่มุมล่างซ้าย
                bottomRight: Radius.circular(30), // การโค้งมนที่มุมล่างขวา
              ),
              child: Container(
                color: const Color(0xFF2445EF), // สีของ Container ในครึ่งบน
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: GridView.builder(
                    gridDelegate:const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 2 คอลัมน์
                      crossAxisSpacing: 16.0, // ระยะห่างระหว่างคอลัมน์
                      mainAxisSpacing: 16.0, // ระยะห่างระหว่างแถว
                      childAspectRatio: 1.0, // อัตราส่วนขนาดของ Card
                    ),
                    itemCount: 4, // จำนวนการ์ด
                    itemBuilder: (context, index) {
                      return SizedBox(
                        width: 200, // ความกว้างของการ์ด
                        height: 200, // ความสูงของการ์ด
                        child: Card(
                          elevation: 5,
                          shape:const RoundedRectangleBorder(
                            borderRadius: BorderRadius.vertical(
                              top: Radius.circular(30), // การโค้งมนที่ขอบบน
                              bottom: Radius.circular(20), // การโค้งมนที่ขอบล่าง
                            ),
                          ),
                          child: Center(
                            child: Text(
                              'Card ${index + 1}',
                              style: const TextStyle(fontSize: 16),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 3, // ขนาดของครึ่งล่าง
            child: Container(
              color: Colors.white, // สีของ Container ในครึ่งล่าง
              child: const Center(
                child: Text(
                  'กูขี้เกียจละ',
                  style: TextStyle(color: Colors.black, fontSize: 20),
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
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.shopify),
            label: 'Shop',
          ),
          // BottomNavigationBarItem(
          //   icon: Icon(Icons.add_card),
          //   label: 'Lotto',
          // ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_pin),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          // การทำงานเมื่อเลือกไอเท็ม
        },
      ),
    );
  }
}
