import 'dart:convert';
import 'dart:io';

import 'package:chitter/components/formWidget/imagepreview.dart';
import 'package:chitter/components/formWidget/rounded_button.dart';
import 'package:chitter/components/formWidget/textfieldpost.dart';
import 'package:chitter/services/rest_api.dart';
import 'package:chitter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

class CreatePost extends StatefulWidget {
  const CreatePost({super.key});

  @override
  State<CreatePost> createState() => _CreatePostState();
}

class _CreatePostState extends State<CreatePost> {
  final _formKeyPost = GlobalKey<FormState>();
  final content = TextEditingController();

  double process = 0.0;
  late int MaxLengthTyping = 100;

  final ImagePicker _picker = ImagePicker();
  List<XFile>? _media = [];
  String mediaType = "";

  Future<void> _pickImage() async {
    final List<XFile>? selectImage = await _picker.pickMultiImage();
    setState(() {
      if (_media != null) {
        _media?.addAll(selectImage!.take(4 - _media!.length));
      } else {
        _media = selectImage?.take(4).toList();
      }

      mediaType = "picture";
    });
  }

  void updateProgress(String text) {
    setState(() {
      process = text.length / MaxLengthTyping;
    });
  }

  @override
  void initState() {
    super.initState();
    content.addListener(() {
      print(content.text);
      updateProgress(content.text);
    });
  }

  @override
  void dispose() {
    content.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Center(child: Text("Chitter")),
        actions: [
          Container(
            margin: const EdgeInsets.all(5),
            child: IconButton(
                icon: Icon(Icons.check),
                onPressed: () async {
                  if (_formKeyPost.currentState!.validate()) {
                    var resp =
                        await RestAPI().createPost(content.text, _media);


                    if (resp != null) {
                      var body = jsonDecode(resp);
                      if(body['message'] != ""){
                        ScaffoldMessenger.of(context).showSnackBar(Utility.showSnackBar(body['message']));
                        Navigator.pop(context);
                      }

                    }
                  }
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
                  onChange: (text) => updateProgress(text.toString()),
                  maxLength: MaxLengthTyping,
                  keyboardType: TextInputType.text),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      child: Row(
                    children: [
                      IconButton(
                        onPressed: _media == null
                            ? _pickImage
                            : _media != null && _media!.length < 4
                                ? _pickImage
                                : null,
                        icon: const Icon(Icons.image),
                      ),
                      IconButton(
                          onPressed: mediaType != "picture" ? () {} : null,
                          icon: const Icon(Icons.gif_box_outlined)),
                      const Text(
                        "Max 4 Picture or 1 Video",
                        style: TextStyle(color: Colors.grey),
                      ),
                    ],
                  )),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: CircularProgressIndicator(
                      value: process,
                      backgroundColor: Colors.grey,
                      valueColor: AlwaysStoppedAnimation<Color>(
                        process >= 1.0
                            ? Colors.red
                            : process >= 0.8
                                ? Colors.orange
                                : Colors.green,
                      ),
                    ),
                  )
                ],
              ),
              ImagePreview(image: _media, mdt: mediaType),
            ],
          ),
        ),
      ),
    );
  }
}
