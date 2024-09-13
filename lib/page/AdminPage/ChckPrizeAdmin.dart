import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/config.dart';
import 'package:http/http.dart' as http; // ใช้สำหรับเรียกใช้งาน HTTP
import 'dart:convert'; // ใช้สำหรับจัดการกับ JSON

class CheckPrizeAdmin extends StatefulWidget {
   int idx;
  CheckPrizeAdmin({super.key, required this.idx});

  @override
  State<CheckPrizeAdmin> createState() => _CheckPrizeAdminState();
}

class _CheckPrizeAdminState extends State<CheckPrizeAdmin> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    throw UnimplementedError();
  }
 
}
