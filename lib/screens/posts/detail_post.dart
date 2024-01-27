import 'package:chitter/components/feeds/card_comment.dart';
import 'package:chitter/components/feeds/card_feed_content.dart';
import 'package:chitter/components/feeds/card_feed_footer.dart';
import 'package:chitter/components/feeds/card_feed_header.dart';
import 'package:chitter/controller/PostController.dart';
import 'package:chitter/screens/posts/comment_form.dart';
import 'package:chitter/models/PostModel.dart';
import 'package:chitter/utils/constants.dart';
import 'package:chitter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class detail_Post extends StatefulWidget {
  const detail_Post({Key? key, required this.pid}) : super(key: key);
  final int pid;
  @override
  State<detail_Post> createState() => _detail_PostState();
}

class _detail_PostState extends State<detail_Post> {
  final PostController postController = Get.put(PostController());
  int id = 0;
  bool statusOwner = false;

  @override
  void initState() {
    super.initState();
    id = Utility.getSharedPrefs("userid");
    postController.fetchPostById(widget.pid);
  }

  @override
  Widget build(BuildContext context) {
    String profilePath =
        postController.post.value.user?.profilepicture ?? "default.png";
    String profileImage = urlAPI + "images/" + profilePath;

    if (id == postController.post.value.userId) {
      statusOwner = true;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text("Post"),
      ),
      body: SingleChildScrollView(
        child: Obx(
          () => Container(
            margin: const EdgeInsets.all(15),
            child: Column(
              children: [
                CardFeedHeader(
                  username: postController.post.value.user?.username ?? "",
                  fullname: postController.post.value.user?.fullname ?? "",
                  uid: postController.post.value.user?.id ?? 0,
                  imgSrc: profileImage,
                  statusOwner: statusOwner,
                  pid: postController.post.value.id ?? 0,
                ),
                CardFeedContent(
                    text: postController.post.value?.content ?? "",
                    imgSrc: postController.post.value?.image ?? "",
                    mdt: postController.post.value?.contenttype ?? "picture"),
                CardFeedFooter(
                    comments: postController.post.value?.comments ?? [],
                    likes: postController.post.value?.likes ?? [],
                    date: postController.post.value?.createdAt ??
                        DateTime.timestamp(),
                    refreshKey: null,
                    onTap: () {},
                    pid: postController.post.value?.id ?? 0),
                cardcomment(
                    comments: postController.post.value?.comments ?? []),
                CommentForm(pid: postController.post.value?.id ?? 0),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
