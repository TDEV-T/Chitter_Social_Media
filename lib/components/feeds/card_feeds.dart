import 'package:chitter/components/feeds/card_feed_footer.dart';
import 'package:chitter/components/feeds/card_feed_header.dart';
import 'package:chitter/models/PostModel.dart';
import 'package:chitter/screens/posts/detail_post.dart';
import 'package:chitter/utils/constants.dart';
import 'package:chitter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'card_feed_content.dart';

class CardFeed extends StatefulWidget {
  const CardFeed({Key? key, required this.pml,required this.refreshKey}) : super(key:key);

  final PostModel pml;

  final GlobalKey<RefreshIndicatorState> refreshKey;


  @override
  State<CardFeed> createState() => _CardFeedState();
}

class _CardFeedState extends State<CardFeed> {
    bool statusOwner = false;
  @override
  void initState()  {
    super.initState();
    checkOwner();
  }

  Future<void> checkOwner() async {
    int id = Utility.getSharedPrefs("userid");
    if(id == widget.pml.userId) {
      setState(() {
        statusOwner = true;
      });
    }
  }


  @override
  Widget build(BuildContext context) {
    String profilePath = widget.pml.user!.profilepicture ?? "default.png";
    String profileImage = imageAPI + profilePath;

    return Container(
      margin: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: (){
          Navigator.push(context,MaterialPageRoute(builder:(context) => detail_Post(pid:widget.pml?.id ?? 0))).then((_) => {
            widget.refreshKey.currentState!.show()
          });
        },
        child: Column(
          children: [
            CardFeedHeader(username: widget.pml.user?.username ?? "", fullname: widget.pml.user?.fullname ?? "", imgSrc: profileImage,uid: widget.pml.user?.id ?? 0, statusOwner :statusOwner,pid:widget.pml?.id ?? 0),
            CardFeedContent(text: widget.pml?.content ?? "", imgSrc: widget.pml?.image ?? "",mdt:widget.pml?.contenttype ?? "picture"),
            CardFeedFooter(comments: widget.pml?.comments ?? [], likes: widget.pml?.likes ?? [],date:widget.pml?.createdAt ?? DateTime.timestamp(),refreshKey: widget.refreshKey , onTap:() {
              Navigator.push(context,MaterialPageRoute(builder:(context) => detail_Post(pid:widget.pml?.id ?? 0))).then((_) => {
                widget.refreshKey.currentState!.show()
              });
            },pid:widget.pml?.id ?? 0),
          ],
        ),
      ),
    );
  }
}
