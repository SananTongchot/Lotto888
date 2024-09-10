import 'package:flutter/material.dart';
import 'package:flutter_application_1/page/AdminPage/ChckPrizeAdmin.dart';
// import 'package:flutter_application_1/page/AdminPage/EditProfileAdmin.dart';
import 'package:flutter_application_1/page/AdminPage/ProfileAdmin.dart';
// import 'package:flutter_application_1/page/EditProfileUser.dart';
// import 'package:flutter_application_1/page/ProfileUser.dart';
import 'package:flutter_application_1/page/CheckPrize.dart';
import 'package:flutter_application_1/page/FindLotto.dart';
<<<<<<< Updated upstream
import 'package:flutter_application_1/page/logInpage.dart';
=======
import 'package:flutter_application_1/page/ProfileUser.dart';
>>>>>>> Stashed changes

//import 'package:flutter_application_1/page/CheckPrize.dart';
// import 'package:flutter_application_1/page/logInpage.dart';
void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Lotto888',
<<<<<<< Updated upstream
      home: Loginpage(),
=======
      // home: Checkprizepage(),
      home: Profileuser(),
>>>>>>> Stashed changes
    );
  }
}
