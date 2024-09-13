import 'dart:convert';
import 'dart:developer';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/config.dart';
import 'package:flutter_application_1/model/response/LotteryGetResponse.dart';
import 'package:flutter_application_1/model/response/UserGetCheckPrizeResponse.dart';
import 'package:flutter_application_1/model/response/UserGetCreditResponse.dart';
import 'package:flutter_application_1/model/response/UserGetRewardsResponse.dart';
import 'package:flutter_application_1/page/EditProfileUser.dart';
import 'package:flutter_application_1/page/FindLotto.dart';
import 'package:flutter_application_1/page/ProfileUser.dart';
import 'package:flutter_application_1/page/Wallet.dart';
import 'package:http/http.dart' as http;

class Checkprizepage extends StatefulWidget {
  int idx = 0;
  Checkprizepage({super.key, required this.idx});
  @override
  State<Checkprizepage> createState() => CheckprizeState();
}

class CheckprizeState extends State<Checkprizepage> {
  String url = '';
  List<UserGetCheckPrizeResponse> lotteries = [];
  UserGetRewardsResponse? rewards; // กำหนดค่าเริ่มต้นให้กับ rewards

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      Configuration.getConfig().then((config) {
        url = config['apiEndpoint'];
        getWin_Lotto();
      });
    });
  }

  bool isChecked = false;

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
              // Action when the person icon is pressed
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
                // Action when Home is selected
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Action when Settings is selected
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 270,
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
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 3.0,
                            mainAxisSpacing: 16.0,
                            childAspectRatio: 2.0,
                          ),
                          itemCount: 4,
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
                                      'รางวัลที่ ${index + 2}',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(height: 8),
                                    const Text(
                                      '123456',
                                      style: TextStyle(
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
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              FilledButton(
                onPressed: () {
                  setState(() {
                    isChecked = true; // เมื่อกดปุ่มจะเปลี่ยนเป็น true
                    getWin_Lotto(); // เรียกใช้ฟังก์ชันตรวจรางวัล
                  });
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color.fromARGB(255, 89, 117, 255),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'ตรวจรางวัล',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
              SizedBox(
                width: 50,
              ),
              FilledButton(
                onPressed: () async {
                  // แสดง Dialog กำลังโหลดก่อนที่จะเรียก reward()
                  showDialog(
                    context: context,
                    barrierDismissible:
                        false, // ป้องกันไม่ให้ปิด Dialog ก่อนที่การโหลดจะเสร็จ
                    builder: (BuildContext context) {
                      return const Center(
                        child:
                            CircularProgressIndicator(), // แสดง Loading Indicator
                      );
                    },
                  );

                  // รอให้ฟังก์ชัน reward() ทำงานเสร็จสิ้น
                  await reward();

                  // ปิด Dialog กำลังโหลด
                  Navigator.pop(context);

                  // เมื่อ reward() เสร็จแล้วค่อยแสดงข้อมูลใน AlertDialog ใหม่
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text(
                          "ขึ้นเงินรางวัลสำเร็จ",
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                        content: Text(
                          rewards != null
                              ? "${rewards!.totalPrizeAmount} บาท" // แสดงรางวัลเมื่อ rewards ไม่เป็น null
                              : "ไม่มีข้อมูลรางวัล", // ข้อความเมื่อ rewards ยังไม่ได้รับการกำหนดค่า
                          textAlign: TextAlign.center,
                        ),
                        actions: [
                          TextButton(
                            onPressed: () {
                              Navigator.pop(
                                  context); // ปิด AlertDialog เมื่อกดปุ่ม
                            },
                            child: const Text("ปิด"),
                          ),
                        ],
                      );
                    },
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 118, 140, 254),
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                child: const Text(
                  'ขึ้นเงินรางวัล',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: lotteries.length, // ใช้จำนวนรายการจาก lotteries
              itemBuilder: (context, index) {
                final lottery =
                    lotteries[index]; // ข้อมูลลอตเตอรี่ที่ดึงมาจากแต่ละ index

                // ตรวจสอบว่าถูกรางวัลหรือไม่
                bool isWinner = lottery.win == true;

                return Padding(
                  padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                  child: Container(
                    color: Colors.white,
                    child: SizedBox(
                      width: double.infinity,
                      height: 103,
                      child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            // แสดงสีตามเงื่อนไข: ถ้ากดปุ่มแล้ว และถูกรางวัลจะแสดงสีเขียว ถ้าไม่ถูกรางวัลจะแสดงสีแดง
                            color: isChecked
                                ? (isWinner
                                    ? Colors.green[100]
                                    : Colors.red[100])
                                : Colors.grey[200], // ยังไม่กดปุ่มให้แสดงสีเทา
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              // Ticket Number Container
                              Container(
                                padding: const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 20),
                                decoration: BoxDecoration(
                                  color: Colors.blue[300],
                                  borderRadius: BorderRadius.circular(10),
                                ),
                                child: Text(
                                  lottery
                                      .lottoNumber, // ใช้ข้อมูลจาก lottery.number
                                  style: const TextStyle(
                                    fontSize: 30,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              // Text Column
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    'ผลการตรวจ',
                                    style: TextStyle(
                                      fontSize: 18,
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 5),
                                  // แสดงข้อความตามเงื่อนไข
                                  Text(
                                    isChecked
                                        ? (isWinner
                                            ? 'คุณถูก${lottery.prizeRank}' // ข้อมูลรางวัลที่ดึงจาก lottery
                                            : 'คุณไม่ถูกรางวัล') // ข้อความเมื่อไม่ถูกรางวัล
                                        : 'ยังไม่ได้ตรวจรางวัล', // ข้อความเริ่มต้นเมื่อยังไม่กดปุ่ม
                                    style: const TextStyle(
                                      fontSize: 16,
                                      color: Colors.black,
                                    ),
                                  ),
                                ],
                              ),
                              // Multiplier and Amount
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  if (isWinner && isChecked)
                                    Text(
                                      '${lottery.prizeAmount} ฿', // ข้อมูลจำนวนเงินที่ดึงจาก lottery
                                      style: const TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
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
          tapbarNavigator(index);
        },
      ),
    );
  }

  void tapbarNavigator(int index) {
    log(index.toString());
    if (index == 0) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => FindLottoPage(idx: widget.idx),
          ));
    } else if (index == 1) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Wallet(idx: widget.idx),
          ));
    } else if (index == 2) {
      // Navigator.push(
      //     context,
      //     MaterialPageRoute(
      //       builder: (context) => Checkprizepage(idx: widget.idx),
      //     ));
    } else if (index == 3) {
      Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => Profileuser(idx: widget.idx),
          ));
    }
  }

  void getWin_Lotto() async {
    try {
      var model = {"uid": widget.idx};
      final response = await http.post(
        Uri.parse("$url/lotto_buy_finish2"),
        headers: {"Content-Type": "application/json; charset=utf-8"},
        body: jsonEncode(model),
      );
      log("uid" + widget.idx.toString());
      log(response.body);
      lotteries = userGetCheckPrizeResponseFromJson(response.body);

      if (response.statusCode == 200) {
        setState(() {
          lotteries = userGetCheckPrizeResponseFromJson(response.body);

          // resetControllers(); // Reset controllers after fetching data
        });
      } else {
        log('Failed to load lotto data: ${response.statusCode}');
      }
    } catch (e) {
      log('Error occurred while fetching lotto data: $e');
    }
  }

  Future<void> reward() async {
    try {
      var model = {"uid": widget.idx};
      final response = await http.post(
        Uri.parse("$url/reward"),
        headers: {"Content-Type": "application/json; charset=utf-8"},
        body: jsonEncode(model),
      );
      setState(() {
        rewards = userGetRewardsResponseFromJson(response.body);

        // resetControllers(); // Reset controllers after fetching data
      });
      log(rewards!.previousCredit.toString());
      log("uid" + widget.idx.toString());
      log(response.body);
      log(response.statusCode.toString());
      if (response.statusCode == 200) {
      } else {
        log('Failed to load lotto data: ${response.statusCode}');
      }
    } catch (e) {
      log('Error occurred while fetching lotto data: $e');
    }
  }
}
