import 'package:flutter/material.dart';

class UserAccountShow extends StatelessWidget {
  const UserAccountShow({Key? key , required this.username,required this.imgSrc}) : super(key:key);

  final String username;
  final String imgSrc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: Row(
        children: [
           ClipOval(
             child : Image(image : NetworkImage(imgSrc),width: 50 ,height: 50,fit: BoxFit.cover),
           ),
          const SizedBox(width: 15),
          Text(username),
        ],
      ),
    );
  }
}
