import 'dart:convert';

import 'package:chitter/components/EditProfile/customSwitch.dart';
import 'package:chitter/components/EditProfile/customTextField.dart';
import 'package:chitter/models/UserModel.dart';
import 'package:chitter/services/rest_api.dart';
import 'package:chitter/utils/constants.dart';
import 'package:chitter/utils/utils.dart';
import 'package:flutter/material.dart';

class edit_information extends StatefulWidget {
  const edit_information({Key? key, required this.usrData}) : super(key: key);

  final UserModel usrData;

  @override
  State<edit_information> createState() => _edit_informationState();
}

class _edit_informationState extends State<edit_information> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController bioController = TextEditingController();
  final _formKeyInformation = GlobalKey<FormState>();
  bool privateAccount = false;

  @override
  void initState() {
    usernameController.text = widget.usrData!.username!;
    fullNameController.text = widget.usrData!.fullName!;
    emailController.text = widget.usrData!.email!;
    bioController.text = widget.usrData!.bio!;
    privateAccount = widget.usrData!.privateAccount!;

  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      reverse: false,
      child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKeyInformation,
            child: Column(
              children: [
                UserAccountsDrawerHeader( accountName: Text(widget.usrData.username.toString()),
                  accountEmail: Text(""),
                  currentAccountPicture: CircleAvatar(
                    backgroundImage: NetworkImage(imageAPI+widget.usrData.profilePicture.toString()),
                  ),
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image:
                        NetworkImage(imageAPI + widget.usrData.coverfilePicture!),
                        fit: BoxFit.cover),
                  ),),
                custom_TextField(
                  label: 'Username',
                  controller: usernameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter some text';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  enableStatus: false,
                ),
                custom_TextField(
                  label: 'Name',
                  controller: fullNameController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter some text';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  enableStatus: true,
                ),
                custom_TextField(
                  label: 'Email',
                  controller: emailController,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Please Enter some text';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  enableStatus: true,
                ),
                custom_TextField(
                  label: 'Bio',
                  controller: bioController,
                  validator: (value) {
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  enableStatus: true,
                ),
                custom_Switch(
                    label: 'PrivateStatus',
                    value: privateAccount,
                    onChanged: (value){
                      setState(() {
                        privateAccount = value;
                      });
                    }),
                ElevatedButton(onPressed: ()async{
                  if(_formKeyInformation.currentState!.validate()){
                    Utility().logger.i("Submit");
                    // var resp = await RestAPI().updateInformation();
                  }
                }, child: const Text('Confirm'))
              ],
            ),
          )
      ),
    );
  }
}
