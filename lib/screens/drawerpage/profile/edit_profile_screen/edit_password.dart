import 'dart:convert';

import 'package:chitter/components/EditProfile/customTextField.dart';
import 'package:chitter/services/rest_api.dart';
import 'package:chitter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
class edit_Password extends StatefulWidget {
  const edit_Password({super.key});

  @override
  State<edit_Password> createState() => _edit_PasswordState();
}

class _edit_PasswordState extends State<edit_Password> {
  final TextEditingController curpassController = TextEditingController();
  final TextEditingController newpassController = TextEditingController();
  final TextEditingController newpass2Controller = TextEditingController();

  final _formKeyPassword = GlobalKey<FormState>();


  @override
  Widget build(BuildContext context) {
    return  Padding(
        padding: const EdgeInsets.all(10),
      child: Form(
        key: _formKeyPassword,
        child: Column(
          children: [
            custom_TextField(
              label: 'Current Password',
              controller: curpassController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please Enter some text';
                }
                return null;
              },
              keyboardType: TextInputType.text,
              enableStatus: true,
              isPassword: true,

            ),

            custom_TextField(
              label: 'New Password',
              controller: newpassController,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please Enter some text';
                }
                return null;
              },
              keyboardType: TextInputType.text,
              enableStatus: true,
              isPassword: true,

            ),

            custom_TextField(
              label: 'New Password Confirm',
              controller: newpass2Controller,
              validator: (value) {
                if (value!.isEmpty) {
                  return 'Please Enter some text';
                }
                return null;
              },
              keyboardType: TextInputType.text,
              enableStatus: true,
              isPassword: true,

            ),

            ElevatedButton(
                onPressed: () async {

                  if(newpassController.text != newpass2Controller.text){
                    Utility.showAlertDialog(context, "warning", "New Password and Password Confirm not match!");
                    return;
                  }

                  if (_formKeyPassword.currentState!.validate()) {
                    try{
                      var resp = await RestAPI().updatePassword(curpassController.text, newpassController.text);

                      var body = resp;
                      if (body['message'] != ""){
                        Navigator.pop(context);
                      }
                    }catch(e){
                      Utility.showAlertDialog(context, "Error", "Password Incorrect !");
                    }
                  }
                },
                child: const Text('Confirm')),
          ],
        ),
      ),

    );
  }
}
