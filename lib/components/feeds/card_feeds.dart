import 'package:chitter/components/feeds/card_feed_footer.dart';
import 'package:chitter/components/feeds/card_feed_header.dart';
import 'package:chitter/models/PostModel.dart';
import 'package:chitter/utils/constants.dart';
import 'package:flutter/material.dart';
import 'card_feed_content.dart';

class CardFeed extends StatelessWidget {
  const CardFeed({Key? key, required this.pml}) : super(key:key);

  final PostModel pml;

  @override
  Widget build(BuildContext context) {
    String profilePath = pml.user?.profilepicture ?? "default.png";
    String profileImage = urlAPI +"images/"+ profilePath;



    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          CardFeedHeader(username: pml.user?.username ?? "", fullname: pml.user?.fullname ?? "", imgSrc: profileImage),
          CardFeedContent(text: pml?.content ?? "", imgSrc: pml?.image ?? ""),
          CardFeedFooter(comments: pml?.comments ?? [], likes: pml?.likes ?? [],date:pml?.createdAt ?? DateTime.timestamp())
        ],
      ),
    );
  }
}
