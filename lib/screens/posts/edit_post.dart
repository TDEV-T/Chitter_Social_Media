import 'dart:convert';
import 'dart:io';

import 'package:chitter/components/EditPost/image_edit.dart';
import 'package:chitter/components/animation/LoadingIndicator.dart';
import 'package:chitter/components/formWidget/textfieldpost.dart';
import 'package:chitter/controller/PostController.dart';
import 'package:chitter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
class EditPostScreen extends StatefulWidget {
  const EditPostScreen({Key? key,required this.pid}) : super(key:key);

  final int pid;



  @override
  State<EditPostScreen> createState() => _EditPostScreenState();
}

class _EditPostScreenState extends State<EditPostScreen> {
  final PostController postController = Get.put(PostController());
  final _formKeyEditPost = GlobalKey<FormState>();
  final content = TextEditingController();


  bool isLoading = true;
  double process = 0.0;
  late int MaxLengthTyping = 100;

  final ImagePicker _picker = ImagePicker();
  File? _video;
  List<XFile>? _media = [];
  String mediaType = "all";

  late List<dynamic> imageList = [];


  Future<void> _pickVideo() async {
    final video = await _picker.pickVideo(source: ImageSource.gallery);

    if (video != null) {
      setState(() {
        _video = File(video!.path);
      });
    }

    mediaType = "video";
  }

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




  @override
  void initState(){
    super.initState();
    fetchData();
    setState(() {
      isLoading = false;
    });
  }


  void fetchData() async {
    await postController.fetchPostById(widget.pid);
    setState(() {
      content.text = postController.post.value.content!;
      mediaType = postController.post.value.contenttype!;
    });
  }



  void updateProgress(String text) {
    setState(() {
      process = text.length / MaxLengthTyping;
    });
  }



  @override
  Widget build(BuildContext context) {
    var postData = postController.post.value;
    Utility().logger.i(postData);
    if (postData.image != "" && postData.image!.isNotEmpty) {
      var decoded = jsonDecode(postData.image!);
      if (decoded != null) {
        imageList = decoded;
      }
    }


    return (postData.id != null) ?  Scaffold(
      appBar: AppBar(
        title: const Text("Edit Post"),
        actions: [
          IconButton(onPressed: (){}, icon: const Icon(Icons.edit))
        ],
      ),
      body:Container(
        margin: const EdgeInsets.all(10),
        child: Stack(
          children: [
            Form(
              key: _formKeyEditPost,
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
                                onPressed: mediaType != "video" ? _pickImage : null,
                                icon: const Icon(Icons.image),
                              ),
                              IconButton(
                                  onPressed: mediaType != "picture" ? _pickVideo : null,
                                  icon: const Icon(Icons.gif_box_outlined)),
                              const Text(
                                "Max 4 Picture or 1 Video",
                                style: TextStyle(color: Colors.grey),
                              ),
                            ],
                          )),
                    ],
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text("Current Media",style: TextStyle(fontSize: 20),
                      ),
                      ImageEditPreview(
                        imageList: imageList,
                      )
                    ],
                  )

              ],
              ),
            )
          ],
        ),
      )
    )  :  LoadingIndicator(isLoading: isLoading);
  }
}
