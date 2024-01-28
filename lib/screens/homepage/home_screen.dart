import 'package:chitter/app_router.dart';
import 'package:chitter/components/drawerWidget/UserAccountShow.dart';
import 'package:chitter/screens/drawerpage/homepage/homepage_screen.dart';
import 'package:chitter/screens/drawerpage/message/message_Screen.dart';
import 'package:chitter/screens/drawerpage/notification/notification_screen.dart';
import 'package:chitter/screens/drawerpage/profile/profile_screen.dart';
import 'package:chitter/screens/drawerpage/search/search_screen.dart';
import 'package:chitter/screens/drawerpage/settings/setting_Screen.dart';
import 'package:chitter/utils/constants.dart';
import 'package:chitter/utils/utils.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? username;
  String? email;
  String? imgSrc;
  Future? _getUserFuture;

  @override
  void initState() {
    super.initState();

    _getUserFuture = getUserInfo();
  }

  getUserInfo() async {
    await Utility.initSharedPrefs();
    username = await Utility.getSharedPrefs("username");
    email = await Utility.getSharedPrefs("email");
    imgSrc = await Utility.getSharedPrefs("profile");
    return true;
  }

  int _currentIndex = 0;

  final List<Widget> _children = [
    const homepage__Screen(),
    const profile_Screen(),
    const notification_Screen(),
    const setting_Screen(),
    const search_Screen(),
    const message_Screen()
  ];

  void onDrawerChange(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(child: Text("Chitter")),
        actions: [
          IconButton(onPressed: () {
              Navigator.push(context,MaterialPageRoute(builder:(context) => search_Screen()));
          }, icon: const Icon(Icons.search_outlined))
        ],

      ),
      drawer: Drawer(
        child: Column(
          children: [
            ListView(
              shrinkWrap: true,
              children: [
                ListTile(
                  leading: const Icon(Icons.arrow_back),
                  title: const Text("Back"),
                  onTap: () {
                    Navigator.pop(context);
                  },
                ),
                FutureBuilder(
                    future: getUserInfo(),
                    builder: (context, snapshot) {
                      if (snapshot.hasData) {
                        return UserAccountShow(
                            username: username ?? "",
                            imgSrc: "${imageAPI + imgSrc!}" ?? "");
                      } else {
                        return const CircularProgressIndicator();
                      }
                    }),
                ListTile(
                  leading: const Icon(Icons.home_outlined),
                  title: const Text('Home'),
                  onTap: () {
                    onDrawerChange(0);
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.person_outline),
                  title: const Text("Profile"),
                  onTap: () {
                    onDrawerChange(1);
                  },
                ),
                const ListTile(
                  leading: Icon(Icons.notifications_active_outlined),
                  title: Text("Notifications"),
                ),
                const ListTile(
                  leading: Icon(Icons.settings_outlined),
                  title: Text("Settings"),
                ),
                ListTile(
                  leading: Icon(Icons.search_outlined),
                  title: Text("Search"),
                  onTap: (){
                    onDrawerChange(4);
                  },
                ),
                 ListTile(
                  leading: Icon(Icons.message_outlined),
                  title: Text("Messaging"),
                   onTap:() async {
                    onDrawerChange(5);
                   }
                ),
                ListTile(
                  leading: Icon(Icons.logout_outlined),
                  title:Text("Logout"),
                  onTap: () async {
                    Utility.clearSharedPrefs();
                    Navigator.pushNamedAndRemoveUntil(context, AppRouter.login, (route) => false);
                  },
                )
              ],
            )
          ],
        ),
      ),
      body: _children[_currentIndex],
    );
  }
}
