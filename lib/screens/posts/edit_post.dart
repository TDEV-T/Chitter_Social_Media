import 'dart:convert';
import 'dart:io';

import 'package:chitter/components/EditPost/image_edit.dart';
import 'package:chitter/components/animation/LoadingIndicator.dart';
import 'package:chitter/components/feeds/VideoPreview.dart';
import 'package:chitter/components/formWidget/VideoPreview.dart';
import 'package:chitter/components/formWidget/imagepreview.dart';
import 'package:chitter/components/formWidget/textfieldpost.dart';
import 'package:chitter/controller/PostController.dart';
import 'package:chitter/services/rest_api.dart';
import 'package:chitter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class EditPostScreen extends StatefulWidget {
  const EditPostScreen({Key? key, required this.pid}) : super(key: key);

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
  int limitlength = 4;
  late int freelength = 0;

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
        _media?.addAll(selectImage!.take(freelength - _media!.length));
      } else {
        _media = selectImage?.take(freelength).toList();
      }

      mediaType = "picture";
    });
  }

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  void fetchData() async {
    await postController.fetchPostById(widget.pid);
    setState(() {
      content.text = postController.post.value.content!;
      mediaType = postController.post.value.contenttype!;

      var postData = postController.post.value;
      if (postData.image != "" && postData.image!.isNotEmpty) {
        var decoded = jsonDecode(postData.image!);
        if (decoded != null) {
          setState(() {
            imageList = decoded;

            if (mediaType == "video") {
              freelength = 0;
            }else{
              freelength = limitlength - imageList.length;
            }

          });
        }
      }

      isLoading = false;
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

    return (postData.id != null)
        ? Scaffold(
            appBar: AppBar(
              title: const Text("Edit Post"),
              actions: [
                IconButton(
                    onPressed: () async {
                      if (mediaType == "picture") {
                        String ImageJson = json.encode(imageList);

                        var resp = await RestAPI().updatePost(
                            postData.id!, content.text, _media, ImageJson);

                        var body = jsonDecode(resp);
                        if (body['message'] != "") {
                          if (!mounted) return;

                          ScaffoldMessenger.of(context).showSnackBar(
                              Utility.showSnackBar(body['message']));
                          Navigator.pop(context);
                        }
                      } else if (mediaType == "video") {
                        var resp = await RestAPI().updatePostWithVideo(
                            postData.id!, content.text, _video);

                        var body = jsonDecode(resp);
                        if (body['message'] != "") {
                          if (!mounted) return;

                          ScaffoldMessenger.of(context).showSnackBar(
                              Utility.showSnackBar(body['message']));
                          Navigator.pop(context);
                        }
                      }
                    },
                    icon: const Icon(Icons.edit))
              ],
            ),
            body: Container(
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
                            Row(
                              children: [
                                IconButton(
                                  onPressed:
                                      mediaType != "video" ? _pickImage : null,
                                  icon: const Icon(Icons.image),
                                ),
                                IconButton(
                                    onPressed: mediaType != "picture" && freelength > 0
                                        ? _pickVideo
                                        : null,
                                    icon: const Icon(Icons.video_camera_back_outlined)),
                                const Text(
                                  "Max 4 Picture or 1 Video",
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Text("Length : $freelength"),
                              ],
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Current Media",
                              style: TextStyle(fontSize: 20),
                            ),
                            imageList.isNotEmpty && mediaType == "picture"
                                ? ImageEditPreview(
                                    imageList: imageList,
                                    freelength: freelength,
                                    onPressed: () {
                                      setState(() {
                                        freelength =
                                            limitlength - imageList.length;

                                        if (freelength == limitlength) {
                                          mediaType = "all";
                                        }
                                      });
                                    },
                                  )
                                : imageList.isNotEmpty && mediaType == "video"
                                    ? Stack(
                                        children: [
                                          VideoPreviewContent(
                                              filePath:
                                                  imageList[0].toString()),
                                          Positioned(
                                            top: 0,
                                            right: 0,
                                            child: Container(
                                              margin:
                                                  const EdgeInsets.only(top: 5),
                                              decoration: const BoxDecoration(
                                                  color: Colors.white,
                                                  shape: BoxShape.circle),
                                              child: IconButton(
                                                  iconSize: 20,
                                                  icon: const Icon(
                                                    Icons.close,
                                                    color: Colors.black,
                                                  ),
                                                  onPressed: () async {
                                                    imageList.removeAt(0);
                                                    setState(() {
                                                      mediaType = "all";
                                                      freelength = 4;
                                                    });
                                                  }),
                                            ),
                                          ),
                                        ],
                                      )
                                    : Container()
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "New Media",
                              style: TextStyle(fontSize: 20),
                            ),
                            (mediaType == "picture")
                                ? ImagePreview(
                                    image: _media,
                                    mdt: mediaType,
                                    onPressed: () async {
                                      setState(() {
                                        mediaType = "all";
                                      });
                                    })
                                : (mediaType == "video" && _video != null)
                                    ? VideoPlayerScreen(
                                        filePath: _video!.path,
                                        onPressed: () async {
                                          setState(() {
                                            mediaType = "all";
                                            _video = null;
                                          });
                                        },
                                      )
                                    : Container()
                          ],
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),
          )
        : LoadingIndicator(isLoading: isLoading);
  }
}
