import 'package:chitter/utils/constants.dart';
import 'package:flutter/material.dart';

class chat_header extends StatefulWidget {
  const chat_header({Key? key, required this.imgProfile}) : super(key: key);

  final String? imgProfile;

  @override
  State<chat_header> createState() => _chat_headerState();
}

class _chat_headerState extends State<chat_header> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Image.network(imageAPI + widget.imgProfile!),
        Text("Flutter Dev"),
      ],
    );
  }
}
