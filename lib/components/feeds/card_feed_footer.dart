import 'dart:ffi';

import 'package:chitter/models/PostModel.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
class CardFeedFooter extends StatefulWidget {
  const CardFeedFooter({Key? key,required this.comments,required this.likes,required this.date,required this.onTap}) : super(key:key);

  final List<Comment> comments;
  final List<Comment> likes;
  final DateTime date;

  final VoidCallback onTap;

  @override
  State<CardFeedFooter> createState() => _CardFeedFooterState();
}

class _CardFeedFooterState extends State<CardFeedFooter> {
  bool like = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      child:Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
               IconButton(onPressed: (){
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
