import 'dart:ffi';

import 'package:chitter/models/PostModel.dart';
import 'package:chitter/services/rest_api.dart';
import 'package:chitter/utils/utils.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
class CardFeedFooter extends StatefulWidget {
  const CardFeedFooter({Key? key,required this.comments,required this.likes,required this.date,required this.onTap,required this.pid , required this.refreshKey}) : super(key:key);

  final List<Comment> comments;
  final List<Comment> likes;
  final DateTime date;
  final int pid;

  final GlobalKey<RefreshIndicatorState>? refreshKey;

  final VoidCallback onTap;

  @override
  State<CardFeedFooter> createState() => _CardFeedFooterState();
}

class _CardFeedFooterState extends State<CardFeedFooter> {
  bool like = false;
  int? uid = Utility.getSharedPrefs("userid");

  @override
  void initState(){
    super.initState();
    checkIfLiked();
  }

  void checkIfLiked(){
    setState(() {
      like = widget.likes.any((like) => like.userId.toString() == uid.toString());
    });
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child:Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
               IconButton(onPressed: () async {
                try{
                  if (like){
                    var resp  = await RestAPI().dislikePost(widget.pid);
                  }else{
                    var resp = await RestAPI().likePost({
                      "pid": widget.pid
                    });
                  }

                  widget.refreshKey?.currentState?.show();

                }catch(e){
                  Utility().logger.e(e);
                }
                 setState(() {
                   like = !like;
                 });
               }, icon: like ?  const Icon(Icons.thumb_up_alt) : const Icon(Icons.thumb_up_alt_outlined)),
              Text(widget.likes.length.toString()),

              const SizedBox(width: 10,),

              IconButton(onPressed: (){
                widget.onTap();
              }, icon: const Icon(Icons.message_outlined)),
              Text(widget.comments.length.toString()),
            ],
          ),
          Row(
            children: [
              Text(formatDate(widget.date, [HH,':',nn ,'  ',M, ' ', dd, ',', yyyy])),
            ],
          )
        ],
      )
    );
  }
}
