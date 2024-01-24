import 'package:chitter/utils/constants.dart';
import 'package:flutter/material.dart';

class ImageEditPreview extends StatefulWidget {
  const ImageEditPreview({Key? key, required this.imageList}) : super(key: key);

  final List<dynamic> imageList;

  @override
  State<ImageEditPreview> createState() => _ImageEditPreviewState();
}

class _ImageEditPreviewState extends State<ImageEditPreview> {
  @override
  Widget build(BuildContext context) {
    return (widget.imageList.length != 0)
        ? Semantics(
            child: GridView.builder(
              shrinkWrap: true,
              itemCount: widget.imageList.length!,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (BuildContext context, int index) {
                return Semantics(
                  child:Stack(
                    children: [
                      Image.network(
                        imageAPI+widget.imageList[index],
                        width: 150,
                        height: 150,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        top: 0,
                        left: 75,
                        right: 0,
                        child: Container(
                          margin: const EdgeInsets.only(top:5),
                          height: 25,
                          width: 30,
                          decoration: BoxDecoration(color:Colors.white,shape: BoxShape.circle),
                          child: IconButton(
                            iconSize: 10,
                            icon: const Icon(
                              Icons.close,
                              color: Colors.black,
                            ),
                            onPressed: () {
                              setState(() {
                                widget.imageList.removeAt(index);
                              });
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          )
        : const Text("No Media Content");
  }
}
