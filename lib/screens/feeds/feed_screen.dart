import 'package:chitter/app_router.dart';
import 'package:chitter/components/feeds/card_feeds.dart';
import 'package:chitter/models/PostModel.dart';
import 'package:chitter/screens/posts/create_post.dart';
import 'package:chitter/services/rest_api.dart';
import 'package:chitter/themes/colors.dart';
import 'package:flutter/material.dart';

class Feed_Screen extends StatefulWidget {
  const Feed_Screen({super.key});

  @override
  State<Feed_Screen> createState() => _Feed_ScreenState();
}

class _Feed_ScreenState extends State<Feed_Screen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(future: RestAPI().getFeeds(), builder: (context,AsyncSnapshot snapshot){
        if(snapshot.hasError){
          return Text("Failed to Load Feeds");
        }else if(snapshot.connectionState == ConnectionState.done){
          List<PostModel> feeds = snapshot.data;

          return _listView(feeds);
        }else {
          return Center(child:CircularProgressIndicator());
        }
      },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(context,MaterialPageRoute(builder:(context) => CreatePost()));
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50)
        ),
        child: Icon(Icons.add),
        backgroundColor: primary,
      ),
    );

    // return Center(child:Text("Center"));
  }

  Widget _listView(List<PostModel> feeds) {
    return ListView.builder(itemCount: feeds.length, itemBuilder: (context, index) {
      return Padding(padding: const EdgeInsets.all(0),
      child: CardFeed(pml:feeds[index])
      );
    });
  }
}
