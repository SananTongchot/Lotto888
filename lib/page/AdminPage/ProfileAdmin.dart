import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/page/AdminPage/EditProfileAdmin.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/config/config.dart';
import 'package:flutter_application_1/page/LoginPage.dart'; // นำเข้า LoginPage

class Profileadmin extends StatefulWidget {
  final int idx;
  const Profileadmin({super.key, required this.idx});

  @override
  State<Profileadmin> createState() => _ProfileadminState();
}

class _ProfileadminState extends State<Profileadmin> {
  String url = '';

  @override
  void initState() {
    super.initState();
    Configuration.getConfig().then((config) {
      setState(() {
        url = config['apiEndpoint'] ?? ''; // ตรวจสอบว่ามีค่า
      });
    });
  }

 Future<void> resetSystem() async {
  if (url.isEmpty) {
    log("API URL is not set.");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('URL ของ API ยังไม่ได้ตั้งค่า')),
    );
    return;
  }
  try {
    final response = await http.post(
      Uri.parse("$url/reset"),
      headers: {"Content-Type": "application/json; charset=utf-8"},
    );

    if (response.statusCode == 200) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('รีเซ็ตระบบเสร็จสิ้น')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('เกิดข้อผิดพลาด: ${response.statusCode}')),
      );
    }
  } catch (e) {
    log("Error during reset: $e");
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('การเชื่อมต่อ API ล้มเหลว')),
    );
  }
}


  Future<void> confirmResetSystem() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // ป้องกันการปิด Dialog ด้วยการกดพื้นที่นอก Dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ยืนยันการรีเซ็ตระบบ'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('คุณแน่ใจหรือไม่ว่าต้องการรีเซ็ตระบบ?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ยกเลิก'),
              onPressed: () {
                Navigator.of(context).pop(); // ปิด Dialog ถ้าเลือก "ยกเลิก"
              },
              style: TextButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 0, 0, 0), // Text color
                backgroundColor: const Color.fromARGB(255, 255, 255, 255), // Background color
              ),
            ),
            const SizedBox(width: 20), // เว้นระยะห่างระหว่างปุ่ม
            TextButton(
              child: const Text('ยืนยัน'),
              onPressed: () {
                Navigator.of(context).pop(); // ปิด Dialog แล้วทำการยืนยัน
                resetSystem(); // เรียกฟังก์ชัน ResetSystem
              },
              style: TextButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 255, 255, 255), // Text color
                backgroundColor: Color.fromARGB(255, 255, 0, 0), // Background color
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> confirmLogout() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // ป้องกันการปิด Dialog ด้วยการกดพื้นที่นอก Dialog
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('ยืนยันการออกจากระบบ'),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text('คุณแน่ใจหรือไม่ว่าต้องการออกจากระบบ?'),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('ยกเลิก'),
              onPressed: () {
                Navigator.of(context).pop(); // ปิด Dialog ถ้าเลือก "ยกเลิก"
              },
               style: TextButton.styleFrom(
                foregroundColor: const Color.fromARGB(255, 7, 7, 7), // Text color
                backgroundColor: Color.fromARGB(255, 255, 255, 255), // Background color
              ),
              
            ),
            const SizedBox(width: 20), // เว้นระยะห่างระหว่างปุ่ม
            TextButton(
              child: const Text('ยืนยัน'),
              onPressed: () {
                Navigator.of(context).pop(); // ปิด Dialog แล้วออกจากระบบ
                Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(builder: (context) => const Loginpage()),
                );
              },
               style: TextButton.styleFrom(
                foregroundColor: Colors.white, // Text color
                backgroundColor: Color.fromARGB(255, 0, 59, 252), // Background color
              ),
            ),
          ],
        );
      },
    );
  }

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
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                            255, 255, 255, 255), // สีพื้นหลังของปุ่ม
                        padding: const EdgeInsets.symmetric(
                            vertical: 10), // ขนาดของปุ่ม (ไม่มี horizontal padding)
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5), // ขอบปุ่มโค้งมน
                        ),
                      ),
                      child: const Text(
                        'แก้ไขข้อมูลโปรไฟล์',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 0, 0, 0), // สีของข้อความ
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20), // เว้นระยะห่างระหว่างปุ่ม
                  SizedBox(
                    width: 250, // กำหนดความกว้างของปุ่ม
                    child: ElevatedButton(
                      onPressed: () {
                        confirmLogout(); // เรียกการยืนยันการออกจากระบบ
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color.fromARGB(
                            255, 255, 255, 255), // สีพื้นหลังของปุ่ม
                        padding: const EdgeInsets.symmetric(
                            vertical: 10), // ขนาดของปุ่ม (ไม่มี horizontal padding)
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5), // ขอบปุ่มโค้งมน
                        ),
                      ),
                      child: const Text(
                        'ออกจากระบบ',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 0, 0, 0), // สีของข้อความ
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20), // เว้นระยะห่างระหว่างปุ่ม
                  SizedBox(
                    width: 250, // กำหนดความกว้างของปุ่ม
                    child: ElevatedButton(
                      onPressed: () {
                        confirmResetSystem(); 
                        // เรียกการยืนยันการรีเซ็ตระบบ
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Color.fromARGB(255, 248, 109, 109), // สีพื้นหลังของปุ่ม
                        padding: const EdgeInsets.symmetric(
                            vertical: 10), // ขนาดของปุ่ม (ไม่มี horizontal padding)
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5), // ขอบปุ่มโค้งมน
                        ),
                      ),
                      child: const Text(
                        'รีเซ็ตระบบ',
                        style: TextStyle(
                          fontSize: 16,
                          color: Color.fromARGB(255, 0, 0, 0), // สีของข้อความ
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
