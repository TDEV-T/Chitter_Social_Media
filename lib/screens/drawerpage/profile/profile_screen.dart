import 'package:chitter/components/animation/LoadingIndicator.dart';
import 'package:chitter/components/feeds/card_feeds.dart';
import 'package:chitter/controller/UserController.dart';
import 'package:chitter/models/PostModel.dart';
import 'package:chitter/models/UserModel.dart';
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
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  late int id = 0;

  @override
  void initState() {
    super.initState();
    id = Utility.getSharedPrefs("userid");
    fetchData();
  }

  fetchData() async{
    await usrController.fetchMySelf(id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile : ${usrController.myself.value.username}"),
      ),
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: () async {
          setState(() {
            Get.find<UserController>().fetchMySelf(id);
          });
        },
        child: SingleChildScrollView(
          child: Obx(() {
            var userController = Get.find<UserController>();
            var user = userController.myself.value;
            var profilePicture = imageAPI + user.profilePicture.toString();
            if (user.username != null) {
              return Container(
                child: Column(
                  children: [
                    UserAccountsDrawerHeader(
                      accountName: Text(user.username.toString()),
                      accountEmail: Text(user.email.toString()),
                      currentAccountPicture: CircleAvatar(
                        backgroundImage: NetworkImage(profilePicture),
                      ),
                      decoration: BoxDecoration(
                        image: DecorationImage(
                            image:
                                NetworkImage(imageAPI + user.coverfilePicture!),
                            fit: BoxFit.cover),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            const Text('Posts'),
                            Text(user.posts?.length.toString() ?? "0"),
                          ],
                        ),
                        Column(
                          children: [
                            const Text('Followers'),
                            Text(user.followingCount.toString() ?? '0'),
                          ],
                        ),
                        Column(
                          children: [
                            const Text('Following'),
                            Text(user.followingCount.toString() ?? '0'),
                          ],
                        ),
                      ],
                    ),
                    ListView.builder(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: user.posts?.length,
                      itemBuilder: (context, index) {
                        return CardFeed(
                            pml: user.posts![index], refreshKey: refreshKey);
                      },
                    ),
                  ],
                ),
              );
            } else {
              return const LoadingIndicator(
                isLoading: true,
              );
            }
          }),
        ),
      ),
    );
  }
}

