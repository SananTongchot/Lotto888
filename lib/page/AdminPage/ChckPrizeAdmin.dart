import 'package:flutter/material.dart';

class CheckPrizeAdmin extends StatefulWidget {
  const CheckPrizeAdmin({super.key});

  @override
  State<CheckPrizeAdmin> createState() => _CheckPrizeAdminState();
}

class _CheckPrizeAdminState extends State<CheckPrizeAdmin> {
  @override
 
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
                                '123456', // แสดงตัวเลข 6 หลัก
                                style: TextStyle(
                                  fontSize: 30,
                                    color: Colors.white,
                                  fontWeight: FontWeight.bold, // ทำให้ตัวเลขเด่นขึ้น
                                ),
                              ),
                const SizedBox(height: 8), // ระยะห่างระหว่างข้อความและ GridView
                Expanded(
                  child: GridView.builder(
                    gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2, // 2 คอลัมน์
                      crossAxisSpacing: 3.0, // ระยะห่างระหว่างคอลัมน์
                      mainAxisSpacing: 16.0, // ระยะห่างระหว่างแถว
                      childAspectRatio: 2.0, // อัตราส่วนขนาดของ Card (กว้างยาว)
                    ),
                    itemCount: 4, // จำนวนการ์ด
                    itemBuilder: (context, index) {
                      return Card(
                        elevation: 5,
                        shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.vertical(
                            top: Radius.circular(30), // การโค้งมนที่ขอบบน
                            bottom: Radius.circular(20), // การโค้งมนที่ขอบล่าง
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisSize: MainAxisSize.min, // จัดเรียงข้อความให้ใช้พื้นที่น้อยที่สุด
                            mainAxisAlignment: MainAxisAlignment.center, // จัดข้อความให้อยู่กึ่งกลาง
                            children: [
                              Text(
                                'รางวัลที่ ${index + 2}',
                                style: const TextStyle(fontSize: 16),
                              ),
                              const SizedBox(height: 8), // เพิ่มระยะห่างระหว่างข้อความและตัวเลข
                              const Text(
                                '123456', // แสดงตัวเลข 6 หลัก
                                style: TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold, // ทำให้ตัวเลขเด่นขึ้น
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
      flex: 3, // ขนาดของครึ่งล่าง
child: Container(
  color: Colors.white, // สีของ Container ในครึ่งล่าง
  child: Center(
    child: ElevatedButton(
      onPressed: () {}, // ใส่ฟังก์ชันที่คุณต้องการเมื่อกดปุ่ม
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFF2445EF), // สีของปุ่ม
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20), // ขยายขนาดของปุ่ม
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15), // มุมปุ่มมน
        ),
      ),
      child: const Text(
        'LOTTO888',
        style: TextStyle(
          color: Colors.white, // สีของข้อความ
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
}
