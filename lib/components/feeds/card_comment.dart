import 'package:chitter/components/feeds/card_feed_header.dart';
import 'package:chitter/models/PostModel.dart';
import 'package:chitter/utils/constants.dart';
import 'package:flutter/material.dart';

class cardcomment extends StatefulWidget {
  const cardcomment({Key? key, required this.comments}) : super(key: key);

  final List<Comment> comments;
  @override
  State<cardcomment> createState() => _cardcommentState();
}

class _cardcommentState extends State<cardcomment> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: widget.comments.map((comment) {
          return Column(
            children: [
              CardFeedHeader(
                username: comment.user!.username ?? "",
                fullname: comment.user!.fullname ?? "",
                imgSrc:
                    '${imageAPI + comment.user!.profilepicture.toString()}' ??
                        "",
                  statusOwner : false,
                pid:0,
              ),
              Align(
                alignment: Alignment.topLeft,
                child: Text(comment!.content ?? ""),
              ),
              const SizedBox(
                height: 10,
              )
            ],
          );
        }).toList(),
      ),
    );
  }
}
