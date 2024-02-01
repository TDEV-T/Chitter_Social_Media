import 'package:chitter/models/UserModel.dart';
import 'package:chitter/screens/drawerpage/profile/edit_profile_screen/edit_information.dart';
import 'package:flutter/material.dart';

class editProfile_Screen extends StatefulWidget {
  const editProfile_Screen({Key? key,required this.ProfileData}) : super(key: key);

  final UserModel ProfileData;
  @override
  _editProfile_ScreenState createState() => _editProfile_ScreenState();
}

class _editProfile_ScreenState extends State<editProfile_Screen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("EditProfile"),
        bottom: TabBar(
          controller: _tabController,
          tabs: const [
            Tab(text: 'Information'),
            Tab(text: 'Password')
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children:  [
          edit_information(usrData: widget.ProfileData,),
          Center(child: Text("Password")),
        ],
      ),
    );
  }
}
