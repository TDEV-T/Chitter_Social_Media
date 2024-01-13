import 'package:chitter/components/formWidget/rounded_button.dart';
import 'package:chitter/components/formWidget/textfieldpost.dart';
import 'package:flutter/material.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final _formKeyPost = GlobalKey<FormState>();
  final content = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Chitter")),
        actions: [
          Container(
            margin: const EdgeInsets.all(5),
            child: RoundedButton(
                label: "Create",
                onPressed: () async {
                  if (_formKeyPost.currentState!.validate()) {}
                }),
          )
        ],
      ),
      body: Container(
        margin: const EdgeInsets.all(20),
        child: Form(
          key: _formKeyPost,
          child: Column(
            children: [
              TextFieldPost(
                  controller: content,
                  hintText: 'What do u think ? ',
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Content Text  Empty !";
                    }
                  },
                  keyboardType: TextInputType.text)
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    content.dispose();
    super.dispose();
  }
}
