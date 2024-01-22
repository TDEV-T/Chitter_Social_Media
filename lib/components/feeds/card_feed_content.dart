import 'dart:convert';

import 'package:chitter/components/feeds/VideoPreview.dart';
import 'package:chitter/utils/constants.dart';
import 'package:chitter/utils/utils.dart';
import 'package:flutter/material.dart';

class CardFeedContent extends StatelessWidget {
  CardFeedContent(
      {Key? key, required this.text, required this.imgSrc, required this.mdt})
      : super(key: key);

  final String text;
  final String imgSrc;
  final String mdt;

  late List<dynamic> imageList = [];
  late int gridViewLayout = 2;

  @override
  Widget build(BuildContext context) {
    if (imgSrc != "" && imgSrc.isNotEmpty) {
      var decoded = jsonDecode(imgSrc);
      if (decoded != null) {
        imageList = decoded;
      }
      gridViewLayout = imageList.length == 1 ? 1 : 2;
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(text),
        imageList.isNotEmpty && mdt == "picture"
            ? Container(child: _gridView(imageList))
            : imageList.isNotEmpty && mdt == "video"
                ? VideoPreviewContent(filePath: imageList[0].toString())
                : Container(),
      ],
    );
  }

  Widget _gridView(List<dynamic> img) {
    return GridView.builder(
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: gridViewLayout,
        ),
        itemCount: imageList.length,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(child: Image.network(imageAPI + img[index])),
          );
        });
  }
}
