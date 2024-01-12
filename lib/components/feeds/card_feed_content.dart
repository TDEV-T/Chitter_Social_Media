import 'dart:convert';

import 'package:chitter/utils/constants.dart';
import 'package:flutter/material.dart';

class CardFeedContent extends StatelessWidget {
  CardFeedContent({Key? key, required this.text, required this.imgSrc})
      : super(key: key);

  final String text;
  final String imgSrc;

  late List<String> imageList;

  @override
  Widget build(BuildContext context) {
    // if(imgSrc.isNotEmpty){
    //   print(imgSrc);
    // imageList = jsonDecode(imgSrc) as List<String>;
    // }
    return Container(
        child: Column(
        children: [
        Text(textContent),
        Container(height: 300, child: _gridView()),
      ],
    ));
  }

  Widget _gridView() {
    return GridView.builder(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2 // จำนวนคอลัมน์
            ),
        itemCount: 4,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.grey,
                      offset: Offset(0, 1),
                      blurRadius: 2,
                    )
                  ]),
            ),
          );
        });
  }
}
