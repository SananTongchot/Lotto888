import 'package:flutter/material.dart';
import 'dart:developer';
import 'package:flutter_application_1/config/config.dart';
import 'package:flutter_application_1/model/response/LotteryGetResponse.dart';
import 'package:flutter_application_1/page/AdminPage/ChckPrizeAdmin.dart';
import 'package:flutter_application_1/page/AdminPage/ProfileAdmin.dart';
import 'package:http/http.dart' as http;

class RandomPage extends StatefulWidget {
  final int idx;
  RandomPage({super.key, required this.idx});

  @override
  State<RandomPage> createState() => _RandomPageState();
}

class _RandomPageState extends State<RandomPage> {
  String url = '';
  List<LotteryGetResponse> lotteries = [];

  @override
  void initState() {
    super.initState();
    Configuration.getConfig().then((config) {
      setState(() {
        url = config['apiEndpoint'];
        getLotto(); // Fetch all lotto data initially
      });
    });
  }

  Future<void> getLotto() async {
    if (url.isEmpty) {
      log("API URL is not set.");
      return;
    }

    try {
      final response = await http.get(
        Uri.parse("$url/get_all_lotto"),
        headers: {"Content-Type": "application/json; charset=utf-8"},
      );

      if (response.statusCode == 200) {
        setState(() {
          lotteries = lotteryGetResponseFromJson(response.body);
        });
      } else {
        log('Failed to load lotto data: ${response.statusCode}');
      }
    } catch (e) {
      log('Error occurred while fetching lotto data: $e');
    }
  }

  void tapbarNavigator(int index) {
    log(index.toString());
    if (index == 0) {
      // Handle Random tab action
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => CheckPrizeAdmin(idx: widget.idx),
        ),
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Profileadmin(idx: widget.idx),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 235, 229, 229),
        titleTextStyle: const TextStyle(
          color: Colors.black,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.person),
            onPressed: () {
              getLotto(); // Refresh data
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
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Settings'),
              onTap: () {
                // Action when Settings menu is selected
              },
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          // Gray area with button
          SizedBox(
            width: double.infinity,
            height: 140,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                bottomLeft: Radius.circular(30),
                bottomRight: Radius.circular(30),
              ),
              child: Container(
                color: const Color.fromARGB(255, 235, 229, 229),
                child: Center(
                  child: ElevatedButton(
                    onPressed: () {
                      // Add functionality for the button
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF2445EF),
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: const Text(
                      'INSERT 100 LOTTO',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Lotto data list
          Expanded(
            child: ListView.builder(
              itemCount: lotteries.length,
              itemBuilder: (context, index) {
                final lottery = lotteries[index];
                return SizedBox(
                  width: 360,
                  height: 103,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: Colors.lightBlue[50],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Row(
                        children: [
                          // Price section
                          const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                '80',
                                style: TextStyle(
                                  fontSize: 30,
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                'บาท',
                                style: TextStyle(
                                  fontSize: 14,
                                  color: Colors.red,
                                ),
                              ),
                            ],
                          ),
                          Expanded(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text(
                                  'สลากกินแบ่งรัฐบาล',
                                  style: TextStyle(
                                    fontSize: 14,
                                    color: Colors.black,
                                  ),
                                ),
                                const SizedBox(height: 5),
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 5, horizontal: 10),
                                  decoration: BoxDecoration(
                                    color: Colors.blue[300],
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Text(
                                    lottery.lottoNumber,
                                    style: const TextStyle(
                                      fontSize: 20,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
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
            icon: Icon(Icons.shuffle),
            label: 'Random',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.money),
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
}
