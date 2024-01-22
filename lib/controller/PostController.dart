import 'package:chitter/models/PostModel.dart';
import 'package:chitter/services/rest_api.dart';
import 'package:get/get.dart';

class PostController extends GetxController{
  var posts = <PostModel>[].obs;

  var post = PostModel().obs;

  @override
  void onInit(){
    super.onInit();
    fetchPosts("public");
  }



  void fetchPostById(int id) async {
    var postResult = await RestAPI().getPostById(id);

    if(postResult != null){
      post.value = postResult;
    }
  }

  void fetchPosts(String typefeed) async{
    var postResult = await RestAPI().getFeeds(typefeed) ;

    if (postResult != null){
      posts.value = postResult;
    }
  }
}