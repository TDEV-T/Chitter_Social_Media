import 'package:chitter/components/feeds/card_feed_footer.dart';
import 'package:chitter/components/feeds/card_feed_header.dart';
import 'package:chitter/models/PostModel.dart';
import 'package:chitter/screens/posts/detail_post.dart';
import 'package:chitter/utils/constants.dart';
import 'package:flutter/material.dart';
import 'card_feed_content.dart';

class CardFeed extends StatelessWidget {
  const CardFeed({Key? key, required this.pml,required this.refreshKey}) : super(key:key);

  final PostModel pml;

  final GlobalKey<RefreshIndicatorState> refreshKey;
  @override
  Widget build(BuildContext context) {
    String profilePath = pml.user!.profilepicture ?? "default.png";
    String profileImage = imageAPI + profilePath;



    return Container(
      margin: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: (){
          Navigator.push(context,MaterialPageRoute(builder:(context) => detail_Post(pid:pml?.id ?? 0))).then((_) => {
            refreshKey.currentState!.show()
          });
        },
        child: Column(
          children: [
            CardFeedHeader(username: pml.user?.username ?? "", fullname: pml.user?.fullname ?? "", imgSrc: profileImage),
            CardFeedContent(text: pml?.content ?? "", imgSrc: pml?.image ?? "",mdt:pml?.contenttype ?? "picture"),
            CardFeedFooter(comments: pml?.comments ?? [], likes: pml?.likes ?? [],date:pml?.createdAt ?? DateTime.timestamp(),refreshKey: refreshKey , onTap:() {
              Navigator.push(context,MaterialPageRoute(builder:(context) => detail_Post(pid:pml?.id ?? 0))).then((_) => {
                refreshKey.currentState!.show()
              });
            },pid:pml?.id ?? 0),
          ],
        ),
      ),
    );
  }
}
