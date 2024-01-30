import 'package:flutter/material.dart';

class chat_message_input extends StatelessWidget {
  const chat_message_input(
      {Key? key, required this.controller, required this.onSubmit})
      : super(key: key);
  final TextEditingController controller;
  final VoidCallback onSubmit;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        Flexible(
            child: Container(
          margin: const EdgeInsets.all(10),
          child: TextField(
            controller: controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide: const BorderSide(style: BorderStyle.none, width: 0),
              ),
              hintText: "Message ...",
              filled: true,
              fillColor: Colors.grey[100],
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
                borderSide:
                    const BorderSide(color: Colors.amberAccent, width: 2),
              ),
            ),

            onSubmitted:(String text){
              onSubmit();
            }
          ),
        ))
      ],
    );
  }
}
