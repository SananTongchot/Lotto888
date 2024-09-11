import 'package:flutter/material.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    final mediaQuery = MediaQuery.of(context);
    final isLandscape = mediaQuery.orientation == Orientation.landscape;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Register Page"),
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
                  margin: const EdgeInsets.only(top: 100.0), // ปรับจาก 150.0 เป็น 100.0
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
                        const SizedBox(height: 10.0),
                        const Text(
                          'Username',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 5.0),
                        TextField(
                          controller: _usernameController,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide.none,
                            ),
                          ),
                        ),
                        const SizedBox(height: 15.0),
                        const Text(
                          'Phone',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 3.0),
                        TextField(
                          controller: _phoneController,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          keyboardType: TextInputType.phone,
                        ),
                        const SizedBox(height: 15.0),
                        const Text(
                          'Email',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 3.0),
                        TextField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          keyboardType: TextInputType.emailAddress,
                        ),
                        const SizedBox(height: 15.0),
                        const Text(
                          'Password',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 3.0),
                        TextField(
                          controller: _passwordController,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          obscureText: true,
                        ),
                        const SizedBox(height: 15.0),
                        const Text(
                          'Confirm Password',
                          style: TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 3.0),
                        TextField(
                          controller: _confirmPasswordController,
                          decoration: const InputDecoration(
                            filled: true,
                            fillColor: Colors.white,
                            contentPadding: EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(20.0)),
                              borderSide: BorderSide.none,
                            ),
                          ),
                          obscureText: true,
                        ),
                        const SizedBox(height: 15.0),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                Navigator.pop(context);
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
                              child: const Text('Back'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                // Handle sign-in action
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
                              child: const Text('Sign In'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: -50.0,
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
}
