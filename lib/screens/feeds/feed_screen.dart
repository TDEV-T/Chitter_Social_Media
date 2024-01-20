import 'package:chitter/app_router.dart';
import 'package:chitter/components/feeds/card_feeds.dart';
import 'package:chitter/controller/PostController.dart';
import 'package:chitter/models/PostModel.dart';
import 'package:chitter/screens/posts/create_post.dart';
import 'package:chitter/services/rest_api.dart';
import 'package:chitter/themes/colors.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



class Feed_Screen extends StatefulWidget {

   const Feed_Screen({Key? key,required this.typefeed}) : super(key:key);


   final String typefeed;
  @override
  State<Feed_Screen> createState() => _Feed_ScreenState();
}

class _Feed_ScreenState extends State<Feed_Screen> {
  var refreshKey = GlobalKey<RefreshIndicatorState>();


  @override
  void initState(){
    super.initState();
  }





  @override
  Widget build(BuildContext context) {

    final PostController postController = Get.put(PostController());

    return Scaffold(
      body: RefreshIndicator(
        key:refreshKey,
        onRefresh: () async {
          setState(() {
              Get.find<PostController>().fetchPosts(widget.typefeed);
          });
        },

        child: Obx(
          () => ListView.builder(itemCount: postController.posts.length,itemBuilder:(context,index) {
            return CardFeed(pml: postController.posts[index],refreshKey:refreshKey);
          }),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,MaterialPageRoute(builder:(context) => CreatePost()));
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50)
        ),
        backgroundColor: primary,
        child: const Icon(Icons.add),
      ),
    );

    // return Center(child:Text("Center"));
  }

  Widget _listView(List<PostModel> feeds) {
    return ListView.builder(itemCount: feeds.length, itemBuilder: (context, index) {
      return Padding(padding: const EdgeInsets.all(0),
      child: CardFeed(pml:feeds[index],refreshKey: refreshKey,)
      );
    });
  }
}
