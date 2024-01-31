import 'package:chitter/components/notification/notification_card.dart';
import 'package:chitter/models/FollowModel.dart';
import 'package:chitter/services/rest_api.dart';
import 'package:chitter/utils/constants.dart';
import 'package:chitter/utils/utils.dart';
import 'package:flutter/material.dart';

class notification_Screen extends StatefulWidget {
  const notification_Screen({Key? key}) : super(key: key);

  @override
  State<notification_Screen> createState() => _notification_ScreenState();
}

class _notification_ScreenState extends State<notification_Screen> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();
  late FollowModel follow;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<FollowModel> fetchData() async {
    return await RestAPI().GetFollow();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Notification "),
      ),
      body: FutureBuilder<FollowModel>(
          future: fetchData(),
          builder: (BuildContext context, AsyncSnapshot<FollowModel> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text("Error : ${snapshot.error}");
            } else {
              follow = snapshot.data!;
              return RefreshIndicator(
                  key: refreshKey,
                  onRefresh: () async {
                    setState(() {});
                  },
                  child: follow.followerReq!.isNotEmpty
                      ? ListView.builder(
                          itemBuilder: (context, index) {
                            return notification_card(
                                image: imageAPI +
                                    follow.followerReq![index].follower!
                                        .profilepicture!,
                                username: follow
                                    .followerReq![index].follower!.username!,
                                uid: follow.followerReq![index].follower!.id!,
                                refreshKEY: refreshKey);
                          },
                          itemCount: follow.followerReq?.length ?? 1,
                        )
                      : Container());
            }
          }),
    );
  }
}
