import 'package:chitter/components/feeds/card_feeds.dart';
import 'package:chitter/controller/UserController.dart';
import 'package:chitter/models/PostModel.dart';
import 'package:chitter/utils/constants.dart';
import 'package:chitter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class profile_Screen extends StatefulWidget {
  const profile_Screen({super.key});

  @override
  State<profile_Screen> createState() => _profile_ScreenState();
}

class _profile_ScreenState extends State<profile_Screen> {
  final UserController usrController = Get.put(UserController());

  @override
  void initState() {
    super.initState();
    int id = Utility.getSharedPrefs("userid");
    usrController.fetchMySelf(id);
  }

  @override
  Widget build(BuildContext context) {
    String username = usrController.myself.value.username ?? "";
    String email = usrController.myself.value.email ?? "";

    return Scaffold(
      appBar: AppBar(
        title: const Text("Profile"),
      ),
      body: ListView(
        children: <Widget>[
          Obx(() {
            var userController = Get.find<UserController>();
            var user = userController.myself.value;
            var profilePicture = imageAPI + user.profilePicture.toString();
            return UserAccountsDrawerHeader(
              accountName: Text(user.username.toString()),
              accountEmail: Text(user.email.toString()),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage(profilePicture),
              ),
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(imageAPI+ user.coverfilePicture!),
                  fit: BoxFit.cover
                ),
              ),
            );
          }),
          ListTile(
            title: const Text('My posts'),
            trailing: const Icon(Icons.keyboard_arrow_right),
            onTap: () {},
          ),

        ],
      ),
    );
  }
}
