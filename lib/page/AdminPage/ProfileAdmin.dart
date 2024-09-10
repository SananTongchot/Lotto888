import 'package:flutter/material.dart';
import 'package:flutter_application_1/page/AdminPage/EditProfileAdmin.dart';

class Profileadmin extends StatefulWidget {
  const Profileadmin({super.key});

  @override
  State<Profileadmin> createState() => _ProfileadminState();
}

class _ProfileadminState extends State<Profileadmin> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white, // กำหนดให้ไอคอนเป็นสีขาว
        ),
        centerTitle: true,
        backgroundColor: const Color(0xFF2445EF),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back), // เปลี่ยนเป็นไอคอนลูกศรย้อนกลับ
          onPressed: () {
            Navigator.pop(context); // กดแล้วจะย้อนกลับไปหน้าก่อนหน้า
          },
        ),
      ),
      body: Column(
        children: [
          Expanded(
            flex: 1, // ขนาดของครึ่งบน
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30), // การโค้งมนที่มุมล่างซ้าย
                bottomRight: Radius.circular(30), // การโค้งมนที่มุมล่างขวา
              ),
              child: Container(
                color: const Color(0xFF2445EF), // สีของ Container ในครึ่งบน
                child: const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircleAvatar(
                        radius: 70, // ขนาดของไอคอนโปรไฟล์
                        backgroundColor: Color.fromARGB(
                            255, 220, 220, 220), // สีพื้นหลังของไอคอนโปรไฟล์
                        child: Icon(
                          Icons.person, // ใช้ไอคอนโปรไฟล์
                          size: 80, // ขนาดของไอคอน
                          color: Color.fromARGB(255, 0, 0, 0), // สีของไอคอน
                        ),
                      ),
                      SizedBox(height: 10), // เว้นระยะห่างระหว่างไอคอนและชื่อ
                      Text(
                        'Deconto Tomson', // ชื่อที่จะแสดง
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2, // ขนาดของครึ่งล่าง
            child: Padding(
              padding: const EdgeInsets.all(16.0), // การเพิ่มระยะห่างรอบๆ ปุ่ม
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start, // ชิดด้านบน
                children: [
                  const SizedBox(height: 50), // เว้นระยะห่างระหว่างปุ่ม
                  SizedBox(
                    width: 250, // กำหนดความกว้างของปุ่ม
                    child: ElevatedButton(
                      onPressed: () {
                          Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Editprofileadmin()),
                        );
                        // ใส่ฟังก์ชันที่ต้องการเมื่อกดปุ่ม "แก้ไขข้อมูล"
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                            255, 255, 255, 255), // สีพื้นหลังของปุ่ม
                        padding: const EdgeInsets.symmetric(
                            vertical:
                                10), // ขนาดของปุ่ม (ไม่มี horizontal padding)
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(5), // ขอบปุ่มโค้งมน
                        ),
                      ),
                      child: const Text(
                        'แก้ไขข้อมูล',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15), // เว้นระยะห่างระหว่างปุ่ม
                  SizedBox(
                    width: 250, // กำหนดความกว้างของปุ่ม
                    child: ElevatedButton(
                      onPressed: () {
                        // ใส่ฟังก์ชันที่ต้องการเมื่อกดปุ่ม "เกี่ยวกับ"
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                            255, 255, 255, 255), // สีพื้นหลังของปุ่ม
                        padding: const EdgeInsets.symmetric(
                            vertical:
                                10), // ขนาดของปุ่ม (ไม่มี horizontal padding)
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(5), // ขอบปุ่มโค้งมน
                        ),
                      ),
                      child: const Text(
                        'เกี่ยวกับ',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 15), // เว้นระยะห่างระหว่างปุ่ม
                  SizedBox(
                    width: 250, // กำหนดความกว้างของปุ่ม
                    child: ElevatedButton(
                      onPressed: () {
                        // ใส่ฟังก์ชันที่ต้องการเมื่อกดปุ่ม "ออกจากระบบ"
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                            255, 255, 255, 255), // สีพื้นหลังของปุ่ม
                        padding: const EdgeInsets.symmetric(
                            vertical:
                                10), // ขนาดของปุ่ม (ไม่มี horizontal padding)
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(5), // ขอบปุ่มโค้งมน
                        ),
                      ),
                      child: const Text(
                        'ออกจากระบบ',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                  const Spacer(), // เพิ่ม Spacer ที่นี่เพื่อดันปุ่มสุดท้ายไปอยู่ด้านล่าง
                  SizedBox(
                    width: 250, // กำหนดความกว้างของปุ่ม
                    child: ElevatedButton(
                      onPressed: () {
                        // ใส่ฟังก์ชันที่ต้องการเมื่อกดปุ่ม "รีเซ็ตระบบทั้งหมด"
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                            255, 255, 255, 255), // สีพื้นหลังของปุ่ม
                        padding: const EdgeInsets.symmetric(
                            vertical:
                                10), // ขนาดของปุ่ม (ไม่มี horizontal padding)
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(5), // ขอบปุ่มโค้งมน
                        ),
                      ),
                      child: const Text(
                        'รีเซ็ตระบบทั้งหมด',
                        style: TextStyle(
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
