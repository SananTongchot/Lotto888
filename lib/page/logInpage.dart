import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/page/AdminPage/ChckPrizeAdmin.dart';
import 'package:flutter_application_1/page/FindLotto.dart';
import 'package:flutter_application_1/page/Wallet.dart';
import 'RegisterPage.dart';
import 'package:flutter_application_1/config/config.dart';
import 'package:http/http.dart' as http;

class Loginpage extends StatefulWidget {
  const Loginpage({super.key});

  @override
  State<Loginpage> createState() => _LoginpageState();
}

//
class _LoginpageState extends State<Loginpage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  String textResLogin = "";
  String url = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    Configuration.getConfig().then((config) {
      url = config['apiEndpoint'];
    });
  }

  @override
  Widget build(BuildContext context) {
    @override
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Login Page"),
      ),
      backgroundColor: const Color(0xFF7EDDE5),
      body: Center(
        child: SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: isLandscape ? mediaQuery.size.width * 0.8 : 335.0,
            ),
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Card(
                  margin: const EdgeInsets.only(
                      top: 150.0), // เพิ่มระยะห่างให้การ์ดอยู่ต่ำลงจากโลโก้
                  color: Colors.white.withOpacity(0.8),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  elevation: 4.0,
                  child: Padding(
                    padding: const EdgeInsets.all(30.0),
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                            height: 10.0), // ลดขนาด height เพื่อขยับขึ้น
                        const Text(
                          'Email',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5.0),
                        TextField(
                          controller: _usernameController,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 0.5,
                              horizontal: 16.0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),

                        const SizedBox(height: 35.0),
                        const Text(
                          'Password',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5.0),
                        TextField(
                          controller: _passwordController,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 0.5,
                              horizontal: 16.0,
                            ),
                            border: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          obscureText: true,
                        ),

                        Text(textResLogin),
                        const SizedBox(height: 20.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          const RegisterPage()),
                                );
                              },
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all<Color>(
                                  const Color(0xFF768CFE),
                                ),
                                foregroundColor: WidgetStateProperty.all<Color>(
                                  Colors.white,
                                ),
                                elevation: WidgetStateProperty.all<double>(5.0),
                                shape: WidgetStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                              ),
                              child: const Text('Sign Up'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                login();
                                // Handle login action
                              },
                              style: ButtonStyle(
                                backgroundColor: WidgetStateProperty.all<Color>(
                                  const Color(0xFF768CFE),
                                ),
                                foregroundColor: WidgetStateProperty.all<Color>(
                                  Colors.white,
                                ),
                                elevation: WidgetStateProperty.all<double>(5.0),
                                shape: WidgetStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.0),
                                  ),
                                ),
                              ),
                              child: const Text('Login'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: -50.0, // ขยับโลโก้ขึ้นอีกเพื่อให้บางส่วนซ่อนไปใต้การ์ด
                  child: Image.asset(
                    'assets/images/LOTTObg.png',
                    width: 220.0,
                    height: 220.0,
                    fit: BoxFit.contain,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
Future<void> login() async {
  var config = await Configuration.getConfig();
  var url = config['apiEndpoint'];

  if (_usernameController.text.isEmpty || _passwordController.text.isEmpty) {
    setState(() {
      textResLogin = "Email or password must not empty";
    });
  } else {
    log(_usernameController.text + _passwordController.text);
    var model = {
      "email": _usernameController.text,
      "password": _passwordController.text
    };
    log(model.toString());

    http.post(
      Uri.parse("$url/login"),
      headers: {"Content-Type": "application/json; charset=utf-8"},
      body: jsonEncode(model),
    ).then((value) {
      log(value.body);
      var responseData = jsonDecode(value.body);

      // ตรวจสอบค่าของ uid และ type ก่อนใช้งาน
      int uid = responseData['uid'] ?? 0;  // ให้ค่า default เป็น 0 หากไม่มีค่า
      String type = responseData['type'] ?? "";  // ให้ค่า default เป็น "" หากไม่มีค่า

      // ตรวจสอบว่าเป็น Admin หรือ User โดยเช็คจากค่า type
      if (type == "1") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => CheckPrizeAdmin(idx: uid)),
        );
      } else if (type == "2") {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => FindLottoPage(idx: uid)),
        );
      } else {
        setState(() {
          textResLogin = "Email or password incorrect";
        });
      }
    }).catchError((err) {
      setState(() {
        textResLogin = err.toString();
      });
    });
  }
}



}
