import 'dart:convert';

import 'package:chitter/utils/utils.dart';
import 'package:flutter/material.dart';
class CardFeedHeader extends StatelessWidget {
  const CardFeedHeader({Key? key,required this.username,required this.fullname ,required this.imgSrc}) : super(key:key);
  final String username;
  final String fullname;
  final String imgSrc;




  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(0),
      child:  Row(
        children: [
          ClipOval(
            child: Image(
                image: NetworkImage(
                    imgSrc),
                width: 40,
                height: 40,
                fit: BoxFit.cover),
          ),
          const SizedBox(width:10),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(username),
              Text("@$fullname",style: TextStyle(color: Colors.grey[500]),)
            ],
          ),
        ],
      ),
    );
  }
}
