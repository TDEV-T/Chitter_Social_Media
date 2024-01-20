import 'package:flutter/material.dart';

class profile_Screen extends StatefulWidget {
  const profile_Screen({super.key});

  @override
  State<profile_Screen> createState() => _profile_ScreenState();
}

class _profile_ScreenState extends State<profile_Screen> {
  @override
  Widget build(BuildContext context) {
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
                backgroundImage: NetworkImage('url_to_cover_photo'),
              ),
            ],
          ),
          const ListTile(
            title: Text('friendly, exploring, eating, napping, fetch'),
          ),
          ListTile(
            title: Text('My posts'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {},
          ),
          ListTile(
            title: Text('Likes'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {},
          ),
          ListTile(
            title: Text('Bookmarks'),
            trailing: Icon(Icons.keyboard_arrow_right),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
