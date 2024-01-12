import 'package:chitter/components/drawerWidget/UserAccountShow.dart';
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

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Center(child:Text("Chitter")),
          actions: [
            IconButton(onPressed: (){}, icon: Icon(Icons.search_outlined))
          ],
          bottom: TabBar(
            tabs: [
              Tab(icon: Icon(Icons.home)),
              Tab(icon: Icon(Icons.people)),
            ],
          ),
        ),
        drawer: Drawer(
          child: Column(
            children: [
              ListView(
                shrinkWrap: true,
                children: [
                  ListTile(
                    leading: Icon(Icons.arrow_back),
                    title: Text("Back"),
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
                  const ListTile(
                    leading: Icon(Icons.home_outlined),
                    title: Text('Home'),
                  ),
                  const ListTile(
                    leading: Icon(Icons.person_outline),
                    title: Text("Profile"),
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
        body:  TabBarView(
          children: [
            Feed_Screen(),
            Container(child:Text("2")),
          ],
        ),
      ),
    );
  }
}
