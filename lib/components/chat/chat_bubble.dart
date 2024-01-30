import 'package:flutter/material.dart';

class ChatBubble extends StatelessWidget {
  final String message;
  final bool isCurrentUser;

  const ChatBubble({
    Key? key,
    required this.message,
    required this.isCurrentUser,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isCurrentUser ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 10),
          padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
          decoration: BoxDecoration(
            color: isCurrentUser ? Colors.blue : Colors.grey,
            borderRadius: BorderRadius.circular(15),
          ),
          child: Text(
            message,
            style: TextStyle(
              color: isCurrentUser ? Colors.white : Colors.black,
            ),
          ),
        ),
      ],
    );
  }
}
