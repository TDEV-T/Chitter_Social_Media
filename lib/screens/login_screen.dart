import 'package:chitter/screens/login_form.dart';
import 'package:chitter/themes/colors.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Container(
                      width: 175,
                      height: 175,
                      decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(0),
                              bottomLeft: Radius.circular(300),
                              bottomRight: Radius.circular(0),
                            ),
                          ),
                          gradient: LinearGradient(
                              colors: [Colors.amber, primaryDark],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter)),
                      alignment: Alignment.topRight,
                      padding: const EdgeInsets.only(
                          top: 0, right: 0, bottom: 0, left: 0),
                    )
                  ],
                ),
                const SizedBox(
                  height: 100,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(left: 20),
                  child: const Column(
                    children: [
                      Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 30, fontWeight: FontWeight.bold),
                        textAlign: TextAlign.start,
                      ),
                      Text(
                        "Please Sign in",
                        style: TextStyle(fontSize: 20, color: secondaryText),
                        textAlign: TextAlign.start,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(20),
                  child: LoginForm(),
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 200,
                      height: 200,
                      decoration: const ShapeDecoration(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(0),
                              topRight: Radius.circular(300),
                              bottomLeft: Radius.circular(0),
                              bottomRight: Radius.circular(0),
                            ),
                          ),
                          gradient: LinearGradient(
                              colors: [Colors.amber, primaryDark],
                              begin: Alignment.topCenter,
                              end: Alignment.bottomCenter)),
                      alignment: Alignment.topRight,
                      padding: const EdgeInsets.only(
                          top: 0, right: 0, bottom: 0, left: 0),
                    )
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
