import 'package:chitter/screens/login/login_form.dart';
import 'package:chitter/screens/register/register_form.dart';
import 'package:chitter/themes/colors.dart';
import 'package:flutter/material.dart';

// ... your other imports

class RegisterScreen extends StatefulWidget {
  // ... your widget code

  @override
  _RegisterScreen createState() => _RegisterScreen();
}

class _RegisterScreen extends State<RegisterScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          Positioned(
            top: 25,
            left: 20,
            child: ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: const Icon(Icons.arrow_back_ios_new_outlined),
            ),
          ),
          Positioned(
            top: 0,
            left: 200,
            right: 0,
            child: Container(
              height: 200,
              decoration: const ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(0),
                    bottomLeft: Radius.circular(300),
                    bottomRight: Radius.circular(0),
                  ),
                ),
                gradient: LinearGradient(
                  colors: [Colors.amber, primaryDark],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
          Center(
            child: Column(
              children: [
                const SizedBox(height: 130),
                Container(
                  alignment: Alignment.centerLeft,
                  margin: const EdgeInsets.all(20),
                  child: const Column(
                    children: [
                      Text(
                        "Sign Up",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(20),
                  child: RegisterForm(),
                ),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 200,
            child: Container(
              height: 175,
              decoration: const ShapeDecoration(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(0),
                      bottomLeft: Radius.circular(0),
                      bottomRight: Radius.circular(0),
                      topRight: Radius.circular(300)),
                ),
                gradient: LinearGradient(
                  colors: [Colors.amber, primaryDark],
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
