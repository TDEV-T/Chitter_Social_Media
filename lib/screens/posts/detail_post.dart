import 'package:chitter/components/feeds/card_comment.dart';
import 'package:chitter/components/feeds/card_feed_content.dart';
import 'package:chitter/components/feeds/card_feed_footer.dart';
import 'package:chitter/components/feeds/card_feed_header.dart';
import 'package:chitter/screens/posts/comment_form.dart';
import 'package:chitter/models/PostModel.dart';
import 'package:chitter/utils/constants.dart';
import 'package:flutter/material.dart';
class detail_Post extends StatefulWidget {
  const detail_Post({Key? key,required this.pml}) : super(key:key);
  final PostModel pml;
  @override
  State<detail_Post> createState() => _detail_PostState();
}

class _detail_PostState extends State<detail_Post> {

  @override
  Widget build(BuildContext context) {
    String profilePath = widget.pml.user?.profilepicture ?? "default.png";
    String profileImage = urlAPI +"images/"+ profilePath;
    return Scaffold(
      appBar: AppBar(
        title:  const Text("Post"),

      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CardFeedHeader(username: widget.pml.user?.username ?? "", fullname: widget.pml.user?.fullname ?? "", imgSrc: profileImage),
            CardFeedContent(text: widget.pml?.content ?? "", imgSrc: widget.pml?.image ?? "",mdt:widget.pml?.contenttype ?? "picture"),
            CardFeedFooter(comments: widget.pml?.comments ?? [], likes: widget.pml?.likes ?? [],date:widget.pml?.createdAt ?? DateTime.timestamp(),onTap:(){}),
            const Divider(color:Colors.black),
            cardcomment(comments: widget.pml?.comments ?? []),
            CommentForm(),
          ],
        ),
        ),
    );
  }
}
