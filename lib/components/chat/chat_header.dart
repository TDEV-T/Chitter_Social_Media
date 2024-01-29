import 'package:chitter/app_router.dart';
import 'package:chitter/screens/chat/chat_screen.dart';
import 'package:chitter/utils/constants.dart';
import 'package:chitter/utils/utils.dart';
import 'package:flutter/material.dart';

class chat_header extends StatefulWidget {
  const chat_header({Key? key, required this.imgProfile,required this.username,required this.uid}) : super(key: key);

  final int? uid;
  final String? imgProfile;
  final String? username;

  @override
  State<chat_header> createState() => _chat_headerState();
}

class _chat_headerState extends State<chat_header> {
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: GestureDetector(
        onTap: () {
          Utility().logger.i(widget.uid);
          Navigator.pushReplacement(context,MaterialPageRoute(builder: (context) => chat_Screen(rcid:widget.uid!)));
        },
        child: Row(

          children: [
            Image.network(widget.imgProfile!,
                width: 40, height: 40, fit: BoxFit.cover),
            Text(widget.username!),
          ],
        ),
      ),
    );
  }
}
