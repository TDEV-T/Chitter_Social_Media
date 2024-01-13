import 'dart:convert';

import 'package:chitter/utils/constants.dart';
import 'package:flutter/material.dart';

class CardFeedContent extends StatelessWidget {
  CardFeedContent({Key? key, required this.text, required this.imgSrc})
      : super(key: key);

  final String text;
  final String imgSrc;

  late List<dynamic> imageList;
  late int gridViewLayout = 2;

  @override
  Widget build(BuildContext context) {
    if(imgSrc.isNotEmpty || imgSrc != ""){
    imageList = jsonDecode(imgSrc) as List<dynamic>;
    gridViewLayout = imageList.length == 1 ? 1 : 2;
    }
    return Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start
          ,
        children: [
          Text(text),
        Container(child: _gridView(imageList)),
      ],
    ));
  }

  Widget _gridView(List<dynamic> img) {
    return GridView.builder(
      shrinkWrap: true,
        gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: gridViewLayout,
            ),
        itemCount: imageList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
             child:Image.network(imageAPI+img[index])
            ),
          );
        });
  }
}
