import 'package:chitter/app_router.dart';
import 'package:chitter/components/drawerWidget/UserAccountShow.dart';
import 'package:chitter/screens/drawerpage/homepage/homepage_screen.dart';
import 'package:chitter/screens/drawerpage/message/message_Screen.dart';
import 'package:chitter/screens/drawerpage/notification/notification_screen.dart';
import 'package:chitter/screens/drawerpage/profile/profile_screen.dart';
import 'package:chitter/screens/drawerpage/settings/setting_Screen.dart';
import 'package:chitter/screens/feeds/feed_screen.dart';
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
    return true;
  }

  int _currentIndex = 0;

  final List<Widget> _children = [
    homepage__Screen(),
    profile_Screen(),
    notification_Screen(),
    setting_Screen(),
    message_Screen()
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
          IconButton(onPressed: () {}, icon: const Icon(Icons.search_outlined))
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
                            imgSrc:
                                "https://flutter.github.io/assets-for-api-docs/assets/widgets/owl.jpg");
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
                const ListTile(
                  leading: Icon(Icons.search_outlined),
                  title: Text("Search"),
                ),
                const ListTile(
                  leading: Icon(Icons.message_outlined),
                  title: Text("Messaging"),
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
