import 'dart:io';

import 'package:chitter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mime/mime.dart';

class ImagePreview extends StatefulWidget {
   ImagePreview({Key? key, required this.image,required this.mdt,required this.onPressed}) : super(key: key);

  final List<XFile>? image;
  String mdt;
   final VoidCallback onPressed;
  @override
  State<ImagePreview> createState() => _ImagePreviewState();
}

class _ImagePreviewState extends State<ImagePreview> {
  @override
  Widget build(BuildContext context) {
    return (widget.mdt == "picture") ?
     (widget.image != null)
        ? Semantics(
            label: "Image List",
            child: GridView.builder(
                shrinkWrap: true,
                key: UniqueKey(),
                itemBuilder: (BuildContext context, int index) {
                  final String? mime =
                      lookupMimeType(widget.image![index].path);
                  return Semantics(
                    label: 'Image picker example',
                    child: Stack(
                      alignment: Alignment.topRight,
                      children: [
                        Image.file(
                          File(widget.image![index].path),
                          width: 150,
                          height: 150,
                          fit: BoxFit.cover,
                        ),
                        Positioned(
                          top: 0,
                          right: 0,
                          child: Container(
                            margin: const EdgeInsets.only(top:5),
                            height: 25,
                            width: 30,
                            decoration: BoxDecoration(color:Colors.white,shape: BoxShape.circle),
                            child: IconButton(
                              iconSize: 10,
                              icon: Icon(
                                Icons.close,
                                color: Colors.black,
                              ),
                              onPressed: () {
                                setState(() {
                                  if (widget.image != null &&
                                      index < widget.image!.length) {
                                    setState(() {
                                      widget.image!.removeAt(index);

                                      if(widget.image!.length < 1){
                                        widget.mdt = "all";
                                        widget.onPressed();
                                        Utility().logger.i("MDT Change" + widget.mdt);
                                      }
                                    });
                                  }
                                });
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
                itemCount: widget.image!.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2)),
          )
        : const Text("No Image Selected")
        : (widget.mdt == "video") ?
        const Text("Video")
        : const Text("No Media Selected");
  }
}
