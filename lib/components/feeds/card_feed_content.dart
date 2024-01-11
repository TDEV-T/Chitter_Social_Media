import 'package:flutter/material.dart';

class CardFeedContent extends StatelessWidget {
  const CardFeedContent({Key?key,required this.text,required this.imgSrc}) : super(key:key);

  final String text;
  final String imgSrc;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        Image.network('https://example.com/images/my_image.jpg'),
        Image.network('https://example.com/images/my_image_2.jpg'),
        Image.network('https://example.com/images/my_image_3.jpg'),
      ],
    );
  }
}
