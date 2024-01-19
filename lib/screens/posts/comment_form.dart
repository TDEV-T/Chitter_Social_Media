import 'package:chitter/components/formWidget/textfield.dart';
import 'package:flutter/material.dart';


class CommentForm extends StatelessWidget {
   CommentForm({super.key});

  final _formContentKey = GlobalKey<FormState>();
  final content = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return  Form(
      key:_formContentKey,
      child: Column(
        children: [
          TextInputField(
            controller: content,
            hintText: "Username",
            validator: (value) {
              if (value == null || value.isEmpty) {
                return "Username is  Empty !";
              } else if (value.length < 5) {
                return "Username minimum 5 Character !";
              }
              return null;
            },
            keyboardType: TextInputType.text,
            prefixIcon: const Icon(Icons.message_outlined),
          ),
        ],
      ),
    );
  }
}
