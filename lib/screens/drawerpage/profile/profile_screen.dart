  import 'package:chitter/controller/UserController.dart';
  import 'package:chitter/utils/constants.dart';
  import 'package:flutter/material.dart';
  import 'package:get/get.dart';
  import 'package:get/get_core/src/get_main.dart';

  class profile_Screen extends StatefulWidget {
    const profile_Screen({super.key});

    @override
    State<profile_Screen> createState() => _profile_ScreenState();
  }

  class _profile_ScreenState extends State<profile_Screen> {

    @override
    void initState(){
      super.initState();

    }


    @override
    Widget build(BuildContext context) {
      var UserController usrcontrol = Get.put(UserController());
      var profilePicture = imageAPI + usrcontrol.myself.value.profilePicture.toString();



      return Scaffold(
        appBar: AppBar(
          title: const Text("Profile"),
        ),
        body: ListView(
          children: <Widget>[
           const  UserAccountsDrawerHeader(
              accountName: Text('Yuna Lu'),
              accountEmail: Text('San Francisco'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: NetworkImage('url_to_yuna_avatar'),
              ),
              otherAccountsPictures: <Widget>[
                CircleAvatar(
                  backgroundImage: NetworkImage("${imageAPI + (profilePicture ?? 'default_image.png')}"),
                ),
              ],
            ),
            const ListTile(
              title: Text('friendly, exploring, eating, napping, fetch'),
            ),
            ListTile(
              title: const Text('My posts'),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Likes'),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {},
            ),
            ListTile(
              title: const Text('Bookmarks'),
              trailing: const Icon(Icons.keyboard_arrow_right),
              onTap: () {},
            ),
          ],
        ),
      );
    }
  }
