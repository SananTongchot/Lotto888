import 'package:flutter/material.dart';

class Editprofileuser extends StatefulWidget {
  const Editprofileuser({super.key});

  @override
  State<Editprofileuser> createState() => _EditprofileuserState();
}

class _EditprofileuserState extends State<Editprofileuser> {
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
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Stack(
                        children: [
                          const CircleAvatar(
                            radius: 70, // ขนาดของไอคอนโปรไฟล์
                            backgroundColor: Color.fromARGB(255, 220, 220,
                                220), // สีพื้นหลังของไอคอนโปรไฟล์
                            child: Icon(
                              Icons.person, // ใช้ไอคอนโปรไฟล์
                              size: 80, // ขนาดของไอคอน
                              color: Color.fromARGB(255, 0, 0, 0), // สีของไอคอน
                            ),
                          ),
                          Positioned(
                            right: -10, // ระยะห่างจากขอบขวา
                            bottom: -10, // ระยะห่างจากขอบล่าง
                            child: IconButton(
                              icon: const Icon(Icons.edit), // ไอคอนแก้ไข
                              color: Colors.white, // สีของไอคอน
                              onPressed: () {
                                // ใส่ฟังก์ชันที่ต้องการเมื่อกดไอคอนแก้ไข
                              },
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                          height: 10), // เว้นระยะห่างระหว่างไอคอนและชื่อ
                      const Text(
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
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(40.0), // การเพิ่มระยะห่างรอบๆ ฟิลด์
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 300, // กำหนดให้ฟิลด์เต็มความกว้างของหน้าจอ
                    height: 50, // กำหนดความสูงของฟิลด์
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Username',
                        filled: true,
                        fillColor: const Color.fromARGB(255, 216, 220, 228),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: Color(0xFF2445EF), width: 2),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16), // เว้นระยะห่างระหว่างฟิลด์
                  SizedBox(
                    width: 300, // กำหนดให้ฟิลด์เต็มความกว้างของหน้าจอ
                    height: 50, // กำหนดความสูงของฟิลด์
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Email',
                        filled: true,
                        fillColor: const Color.fromARGB(255, 216, 220, 228),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: Color(0xFF2445EF), width: 2),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16), // เว้นระยะห่างระหว่างฟิลด์
                  SizedBox(
                    width: 300, // กำหนดให้ฟิลด์เต็มความกว้างของหน้าจอ
                    height: 50, // กำหนดความสูงของฟิลด์
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Password',
                        filled: true,
                        fillColor: const Color.fromARGB(255, 216, 220, 228),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: Color(0xFF2445EF), width: 2),
                        ),
                      ),
                      obscureText: true, // ซ่อนข้อความในฟิลด์รหัสผ่าน
                    ),
                  ),
                  const SizedBox(height: 16), // เว้นระยะห่างระหว่างฟิลด์
                  SizedBox(
                    width: 300, // กำหนดให้ฟิลด์เต็มความกว้างของหน้าจอ
                    height: 50, // กำหนดความสูงของฟิลด์
                    child: TextField(
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        filled: true,
                        fillColor: const Color.fromARGB(255, 216, 220, 228),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                          borderSide: const BorderSide(
                              color: Color(0xFF2445EF), width: 2),
                        ),
                      ),
                      keyboardType: TextInputType
                          .phone, // แสดงคีย์บอร์ดสำหรับหมายเลขโทรศัพท์
                    ),
                  ),
                  const SizedBox(height: 30), // เว้นระยะห่างระหว่างฟิลด์กับปุ่ม
                  SizedBox(
                    width: 160,
                    child: ElevatedButton(
                      onPressed: () {
                        // ใส่ฟังก์ชันที่ต้องการเมื่อกดปุ่ม "บันทึก"
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            const Color(0xFF2445EF), // สีพื้นหลังของปุ่ม
                        padding: const EdgeInsets.symmetric(
                            vertical: 10), // ขนาดของปุ่ม
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(15), // ขอบปุ่มโค้งมน
                        ),
                      ),
                      child: const Text(
                        'Done',
                        style: TextStyle(
                          color: Colors.white,
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
