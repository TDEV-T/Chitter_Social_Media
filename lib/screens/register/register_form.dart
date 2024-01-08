import 'package:chitter/app_router.dart';
import 'package:chitter/components/formWidget/rounded_button.dart';
import 'package:chitter/screens/register/register_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../components/formWidget/textfield.dart';

class RegisterForm extends StatelessWidget {
  RegisterForm({Key? key}) : super(key: key);

  final _formKeyLogin = GlobalKey<FormState>();
  final username = TextEditingController();
  final password = TextEditingController();
  final fullname = TextEditingController();
  final email = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Column(
        children: [
          const SizedBox(
            height: 10,
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
                  prefixIcon: const Icon(Icons.person_2_outlined),
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
                  prefixIcon: const Icon(Icons.password_outlined),
                ),
                const SizedBox(height: 20),
                TextInputField(
                  controller: fullname,
                  hintText: "Fullname",
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Fullname is  Empty !";
                    } else if (value.length < 5) {
                      return "Fullname minimum 5 Character !";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  prefixIcon: const Icon(Icons.person_3_outlined),
                ),
                const SizedBox(height: 20),
                TextInputField(
                  controller: email,
                  hintText: "Email",
                  validator: (value) {
                    final regex = RegExp(
                        r"^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-z]{2,}$");
                    if (value == null || value.isEmpty) {
                      return "Email is Empty !";
                    } else if (!regex.hasMatch(value)) {
                      return "Invalid email address !";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  prefixIcon: const Icon(Icons.email_outlined),
                ),
                const SizedBox(height: 20),
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    RoundedButton(label: "Sign Up", onPressed: () => {})
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