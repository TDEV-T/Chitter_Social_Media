import 'dart:async';
import 'dart:convert';

import 'package:chitter/models/MessageModel.dart';
import 'package:chitter/utils/constants.dart';
import 'package:chitter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class chat_Screen extends StatefulWidget {
  const chat_Screen({Key? key,required this.rcid}) : super(key:key);


  final int rcid;
  @override
  State<chat_Screen> createState() => _chat_ScreenState();
}

class _chat_ScreenState extends State<chat_Screen> {
  late IOWebSocketChannel channel;
  List<MessageModel> MessageAll = [];
  late bool isLoading = true;
  final StreamController<List<MessageModel>> _streamController = StreamController<List<MessageModel>>();


  fetchData() async {
    String token = await Utility.getSharedPrefs("token");
    var apiSocket = "${websocketAPI}chat?authtoken=${token}&receiverId=${widget.rcid}";
    channel = IOWebSocketChannel.connect(apiSocket);
    channel.stream.listen((event) {
      var data = jsonDecode(event);
      MessageAll.add(MessageModel.fromJson(data));
      _streamController.add(MessageAll);
    });
    setState(() {
      isLoading = false;
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chitter Chat"),
      ),
      body: isLoading ?
          const Center(
            child: CircularProgressIndicator(),
          ) :
          StreamBuilder(stream: _streamController.stream, builder: (context,snapshot){
            if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData){
              return const Text("Text");
            } else {
              return Container();
            }
          }
          )
    );
  }
}
