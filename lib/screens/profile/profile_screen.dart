import 'package:chitter/components/animation/LoadingIndicator.dart';
import 'package:chitter/components/feeds/card_feeds.dart';
import 'package:chitter/controller/UserController.dart';
import 'package:chitter/models/PostModel.dart';
import 'package:chitter/models/UserModel.dart';
import 'package:chitter/screens/chat/chat_screen.dart';
import 'package:chitter/screens/drawerpage/message/message_Screen.dart';
import 'package:chitter/services/rest_api.dart';
import 'package:chitter/utils/constants.dart';
import 'package:chitter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

var refreshKey = GlobalKey<RefreshIndicatorState>();

class profile_Screen_View extends StatefulWidget {
  const profile_Screen_View({Key? key, required this.uid}) : super(key: key);

  final int uid;

  @override
  State<profile_Screen_View> createState() => _profile_ScreenState();
}

class _profile_ScreenState extends State<profile_Screen_View> {
  final UserController usrController = Get.put(UserController());
  late bool privateStatus = true;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    fetchData();
    isLoading = false;
  }

  fetchData() async {
    await usrController.fetchMySelf(widget.uid);
    privateStatus = usrController.myself.value.privateAccount ?? true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Profile : ${usrController.myself.value.username}"),
      ),
      body: isLoading
          ? const CircularProgressIndicator()
          : RefreshIndicator(
              key: refreshKey,
              onRefresh: () async {
                setState(() {
                  Get.find<UserController>().fetchMySelf(widget.uid);
                });
              },
              child: SingleChildScrollView(
                child: Obx(() {
                  var userController = Get.find<UserController>();
                  var user = userController.myself.value;
                  var profilePicture =
                      imageAPI + user.profilePicture.toString();
                  if (user.username != null) {
                    return Container(
                      margin: const EdgeInsets.all(10),
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
                                  image: NetworkImage(
                                      imageAPI + user.coverfilePicture!),
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
                          _buildFollowButton(context,
                              user.statusfollower ?? "none", widget.uid),
                          (privateStatus &&
                                      (user.statusfollower == "active_send" ||
                                          user.statusfollower ==
                                              "active_recei")) ||
                                  !privateStatus
                              ? ListView.builder(
                                  shrinkWrap: true,
                                  physics: const NeverScrollableScrollPhysics(),
                                  itemCount: user.posts?.length,
                                  itemBuilder: (context, index) {
                                    return CardFeed(
                                        pml: user.posts![index],
                                        refreshKey: refreshKey);
                                  },
                                )
                              : Container(
                                  child: const Center(
                                    child:  Text("Account Is Private"),
                                  ),
                                )
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

Widget _buildFollowButton(BuildContext context , String statusfollower, int uid) {
  if (statusfollower != "myself") {
    if (statusfollower == "none") {
      return ElevatedButton(
        onPressed: () async {
          var resp = await RestAPI().sendFollowRequest(uid, "req");
          if (resp) {
            refreshKey.currentState!.show();
          }
        },
        child: const Text('Follow'),
      );
    } else if (statusfollower == "pending_send") {
      return ElevatedButton(
        onPressed: () async {
          var resp = await RestAPI().sendFollowRequest(uid, "unfol");
          if (resp) {
            refreshKey.currentState!.show();
          }
        },
        child: const Text('Cancel Request'),
      );
    } else if (statusfollower == "active_send") {
     return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context) => chat_Screen(rcid: uid)));
            },
            child: const Text('Message'),
          ),
          ElevatedButton(
            onPressed: () async {
              var resp = await RestAPI().sendFollowRequest(uid, "unfol");
              if (resp) {
                refreshKey.currentState!.show();
              }
            },
            child: const Text('Block'),
          ),
        ],
      );
    } else if (statusfollower == "pending_recei") {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () async {
              var resp = await RestAPI().sendFollowRequest(uid, "submit");
              if (resp) {
                refreshKey.currentState!.show();
              }
            },
            child: const Text('Accept'),
          ),
          ElevatedButton(
            onPressed: () async {
              var resp = await RestAPI().sendFollowRequest(uid, "reject");
              if (resp) {
                refreshKey.currentState!.show();
              }
            },
            child: const Text('Reject'),
          ),
        ],
      );
    } else if (statusfollower == "active_recei") {
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(
                      builder: (context) => chat_Screen(rcid: uid)));
            },
            child: const Text('Message'),
          ),
          ElevatedButton(
            onPressed: () async {
              var resp = await RestAPI().sendFollowRequest(uid, "unfol");
              if (resp) {
                refreshKey.currentState!.show();
              }
            },
            child: const Text('Block'),
          ),
        ],
      );
    }
  }
  return Container();
}
