import 'package:chitter/services/rest_api.dart';
import 'package:chitter/utils/utils.dart';
import 'package:flutter/material.dart';

class notification_card extends StatelessWidget {
  const notification_card({Key? key,required this.image, required this.username,required this.uid,required this.refreshKEY}) : super(key:key);

  final String image;
  final String username;
  final int uid;
  final GlobalKey<RefreshIndicatorState> refreshKEY;


  @override
  Widget build(BuildContext context) {
    return Card(
      child: Container(
        margin: const EdgeInsets.all(10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                Image.network(
                  image,
                  width: 50,
                  height: 50,
                ),
                Text(username),
              ],
            ),

            Row(
              children: [
                ElevatedButton(onPressed: ()async {
                  Utility().logger.i(uid);
                  await RestAPI().sendFollowRequest(uid, "submit");
                  refreshKEY.currentState?.show();
                }, child: const Text("Confirm")),
                ElevatedButton(onPressed: () async {
                  Utility().logger.i(uid);
                  await RestAPI().sendFollowRequest(uid, "reject");
                  refreshKEY.currentState?.show();
                }, child: const Text("Reject")),
              ],
            )
          ],
        ),
      ),
    );
  }
}
