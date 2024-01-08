import 'package:chitter/screens/login/login_form.dart';
import 'package:chitter/screens/register/register_form.dart';
import 'package:chitter/themes/colors.dart';
import 'package:flutter/material.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<RegisterPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: ElevatedButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: const Icon(Icons.arrow_back_ios_new_outlined),
                      ),
                    ),
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
                  height: 80,
                ),
                Container(
                  alignment: Alignment.topLeft,
                  margin: const EdgeInsets.only(left: 20),
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
                const SizedBox(height: 10),
                Container(
                  alignment: Alignment.center,
                  margin: const EdgeInsets.all(20),
                  child: RegisterForm(),
                ),
                const SizedBox(height: 50),
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 250,
                      height: 250,
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
