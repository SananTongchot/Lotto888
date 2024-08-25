import 'package:flutter/material.dart';

class Wallet extends StatefulWidget {
  const Wallet({super.key});

  @override
  State<Wallet> createState() => _WalletState();
}

class _WalletState extends State<Wallet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text('Wallet')),
        backgroundColor: Color.fromARGB(255, 36, 70, 239),
        foregroundColor: Color.fromARGB(255, 255, 255, 255),
        leading: const Icon(Icons.menu),
        actions: [
          // IconButton(
          //   icon: ImageIcon(AssetImage()),
          //   onPressed: () {
          //     // Action when more icon is pressed
          //   },
          // ),
        ],
      ),
      body: const Column(
        children: [
          SizedBox(
            child: Card(
              color: Color.fromARGB(255, 36, 70, 239),
              elevation: 10,
            ),
          )
        ],
      ),
    );
  }
}
