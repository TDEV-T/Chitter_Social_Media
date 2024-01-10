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
  void initState(){
    super.initState();
    _getUserFuture = getUserInfo();
  }

  getUserInfo() async {
    await Utility.initSharedPrefs();
    username = await Utility.getSharedPrefs("username");
    email = await Utility.getSharedPrefs("email");
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

      ),
      drawer: Drawer(
          child:Column(
              children: [
                ListView(
                  shrinkWrap: true,
                  children: [
                    FutureBuilder(
                        future: getUserInfo(),
                        builder: (context, snapshot) {
                          if (snapshot.hasData) {
                            return UserAccountsDrawerHeader(accountName: Text(username ?? ""), accountEmail: Text(email ?? ""));
                          } else {
                            return CircularProgressIndicator();
                          }
                        }
                    ),
                    ListTile(
                      leading: Icon(Icons.home_outlined),
                      title: Text('Home'),
                    ),
                  ],
                )
              ],
          )
      ),
      body: Center(
        child:Text("Home Screen"),
      ),
    );
  }
}
