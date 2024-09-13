import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/config/config.dart';
import 'package:flutter_application_1/model/response/Get_5_WinResponse.dart';
import 'package:flutter_application_1/page/AdminPage/ProfileAdmin.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class CheckPrizeAdmin extends StatefulWidget {
  final int idx;
  CheckPrizeAdmin({super.key, required this.idx});

  @override
  State<CheckPrizeAdmin> createState() => _CheckPrizeAdminState();
}

class _CheckPrizeAdminState extends State<CheckPrizeAdmin> {
  String url = '';
  Get5WinResponse? firstPrize;
  List<Get5WinResponse> otherPrizes = [];
  bool isLoading = true; // Track loading state
  bool showButtons = true; // Track whether to show the buttons

  @override
  void initState() {
    super.initState();
    Configuration.getConfig().then((config) {
      setState(() {
        url = config['apiEndpoint'];
        getPrizes(); // Fetch prize data initially
      });
    });
  }

  Future<void> getPrizes() async {
    if (url.isEmpty) {
      log("API URL is not set.");
      setState(() {
        isLoading = false; // Stop loading
      });
      return;
    }

    try {
      final response = await http.get(
        Uri.parse("$url/get_win_prize"),
        headers: {"Content-Type": "application/json; charset=utf-8"},
      );
      log(url);
      log('API Response Status Code: ${response.statusCode}');
      log('API Response Body: ${response.body}');

      if (response.statusCode == 200) {
        List<Get5WinResponse> prizes = get5WinResponseFromJson(response.body);
        log('Parsed Prizes: $prizes');
        setState(() {
          // Assuming the first item is the first prize
          if (prizes.isNotEmpty) {
            firstPrize = prizes[0];
            otherPrizes = prizes.sublist(1); // Get the rest as other prizes
          }
          showButtons = false; // Hide buttons once data is loaded
          isLoading = false; // Stop loading
        });
      } else {
        log('Failed to load prize data: ${response.statusCode}');
        setState(() {
          isLoading = false; // Stop loading
        });
      }
    } catch (e) {
      log('Error occurred while fetching prize data: $e');
      setState(() {
        isLoading = false; // Stop loading
      });
    }
  }

  // Function to call the API to draw prizes
  Future<void> drawPrizes() async {
    if (url.isEmpty) return;

    try {
      final response = await http.post(
        Uri.parse("$url/win_lotto"),
        headers: {"Content-Type": "application/json; charset=utf-8"},
      );
      log('API DrawPrizesAll Response Status Code: ${response.statusCode}');
      log('API DrawPrizesAll Response Body: ${response.body}');

      if (response.statusCode == 200) {
        log('Prizes successfully drawn');
        await getPrizes(); // Refresh prize data after successful draw
      } else {
        log('Failed to draw prizes: ${response.statusCode}');
      }
    } catch (e) {
      log('Error occurred while drawing prizes: $e');
    }
  }

Future<void> drawPrizes2() async {
    if (url.isEmpty) return;

    try {
      final response = await http.post(
        Uri.parse("$url/win_lotto_all"),
        headers: {"Content-Type": "application/json; charset=utf-8"},
      );
      log('API DrawPrizesAll Response Status Code: ${response.statusCode}');
      log('API DrawPrizesAll Response Body: ${response.body}');

      if (response.statusCode == 200) {
        log('Prizes successfully drawn');
        await getPrizes(); // Refresh prize data after successful draw
      } else {
        log('Failed to draw prizes: ${response.statusCode}');
      }
    } catch (e) {
      log('Error occurred while drawing prizes: $e');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.white,
        ),
        title: const Text("Check Prizes"),
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
      body: isLoading
          ? Center(child: CircularProgressIndicator()) // Show loading indicator
          : showButtons
              ? Center(
                  // Display two buttons centered when there is no data
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          await drawPrizes(); // Call drawPrizes function
                          setState(() {
                            showButtons = false; // Hide buttons after pressed
                          });
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
                          'ออกรางวัลจาก lotto ที่ซื้อ',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () async {
                          await drawPrizes2(); // Call drawPrizes function
                          setState(() {
                            showButtons = false; // Hide buttons after pressed
                          });
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
                          'ออกรางวัลจาก lotto ทั้งหมด',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              : Column(
                  children: [
                    // Display the first prize
                    if (firstPrize != null)
                      Container(
                        width: double.infinity,
                        height: 270,
                        decoration: BoxDecoration(
                          color: const Color(0xFF2445EF),
                          borderRadius: const BorderRadius.only(
                            bottomLeft: Radius.circular(30),
                            bottomRight: Radius.circular(30),
                          ),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text(
                                'รางวัลที่ 1',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 24,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                firstPrize!.lottoNumber,
                                style: const TextStyle(
                                  fontSize: 30,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Text(
                                '${firstPrize!.prizeAmount} บาท',
                                style: const TextStyle(
                                  fontSize: 20,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    const SizedBox(height: 10),
                    // Display the other prizes
                    Expanded(
                      child: ListView.builder(
                        itemCount: otherPrizes.length,
                        itemBuilder: (context, index) {
                          final prize = otherPrizes[index];
                          return Card(
                            elevation: 5,
                            shape: const RoundedRectangleBorder(
                              borderRadius: BorderRadius.vertical(
                                top: Radius.circular(30),
                                bottom: Radius.circular(20),
                              ),
                            ),
                            child: ListTile(
                              title: Text(
                                'รางวัลที่ ${index + 2}',
                                style: const TextStyle(fontSize: 16),
                              ),
                              subtitle: Text(
                                prize.lottoNumber,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              trailing: Text(
                                '${prize.prizeAmount} บาท',
                                style: const TextStyle(fontSize: 16),
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  ],
                ),
    );
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
}
