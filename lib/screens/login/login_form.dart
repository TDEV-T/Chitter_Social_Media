import 'package:chitter/app_router.dart';
import 'package:chitter/components/formWidget/rounded_button.dart';
import 'package:chitter/screens/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../components/formWidget/textfield.dart';

class LoginForm extends StatelessWidget {
  LoginForm({Key? key}) : super(key: key);

  final _formKeyLogin = GlobalKey<FormState>();
  final username = TextEditingController();
  final password = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          Form(
            key: _formKeyLogin,
            child: Column(
              children: [
                TextInputField(
                  controller: username,
                  hintText: "Username",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Username is  Empty !";
                    } else if (value.length < 5) {
                      return "Username minimum 5 Character !";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  prefixIcon: const Icon(Icons.person),
                ),
                const SizedBox(height: 20),
                TextInputField(
                  controller: password,
                  hintText: "Password",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Password is  Empty !";
                    } else if (value.length < 5) {
                      return "Password minimum 5 Character !";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  prefixIcon: const Icon(Icons.password),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      child: Text(
                        "Sign Up",
                        style: const TextStyle(
                          decoration: TextDecoration.underline,
                          decorationColor: Colors.amber,
                          color: Colors.amber,
                        ),
                      ),
                      onTap: () => {Navigator.push(context, MaterialPageRoute(builder: (context) => RegisterPage()))},
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      focusColor: Colors.transparent,
                    ),
                    RoundedButton(label: "Sign in", onPressed: () => {})
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
