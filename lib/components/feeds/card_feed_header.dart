import 'dart:convert';

import 'package:chitter/screens/posts/edit_post.dart';
import 'package:chitter/screens/profile/profile_screen.dart';
import 'package:chitter/utils/utils.dart';
import 'package:flutter/material.dart';

class CardFeedHeader extends StatelessWidget {
  const CardFeedHeader(
      {Key? key,
      required this.username,
      required this.fullname,
      required this.imgSrc,
      required this.pid,
      required this.uid,
      required this.statusOwner})
      : super(key: key);
  final String username;
  final String fullname;
  final int uid;
  final String imgSrc;
  final bool statusOwner;
  final int pid;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () async {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => profile_Screen_View(uid: uid)));
            },
            child: Row(
              children: [
                ClipOval(
                  child: Image(
                      image: NetworkImage(imgSrc),
                      width: 40,
                      height: 40,
                      fit: BoxFit.cover),
                ),
                const SizedBox(width: 10),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(username),
                    Text(
                      "@$fullname",
                      style: TextStyle(color: Colors.grey[500]),
                    )
                  ],
                ),
              ],
            ),
          ),
          statusOwner && pid != 0
              ? IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => EditPostScreen(pid: pid)));
                  },
                  icon: const Icon(Icons.menu),
                )
              : Container()
        ],
      ),
    );
  }
}
