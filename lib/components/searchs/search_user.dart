import 'dart:ffi';

import 'package:chitter/models/SearchModel.dart';
import 'package:chitter/models/UserModel.dart';
import 'package:chitter/screens/profile/profile_screen.dart';
import 'package:chitter/utils/constants.dart';
import 'package:flutter/material.dart';

class search_Header extends StatefulWidget {
  const search_Header({Key? key,required this.usrData}) : super(key:key);

  final User usrData;

  @override
  State<search_Header> createState() => _search_HeaderState();
}

class _search_HeaderState extends State<search_Header> {
  @override
  Widget build(BuildContext context) {
    return  Container(
      margin: const EdgeInsets.all(0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              ClipOval(
                child: Image(
                    image: NetworkImage("$imageAPI${widget.usrData.profilepicture}"),
                    width: 40,
                    height: 40,
                    fit: BoxFit.cover),
              ),
              const SizedBox(width: 10),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(widget.usrData!.fullname.toString()),
                  Text(
                    "@${widget.usrData!.username}",
                    style: TextStyle(color: Colors.grey[500]),
                  )
                ],
              ),
            ],
          ),
          IconButton(
            onPressed: () async {
              Navigator.push(context,MaterialPageRoute(builder: (context) => profile_Screen_View(uid: widget.usrData?.id ?? 0)));
            },
            icon: const Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}
