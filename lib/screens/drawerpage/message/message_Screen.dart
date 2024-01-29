import 'dart:convert';

import 'package:chitter/models/ChatAll.dart';
import 'package:chitter/utils/constants.dart';
import 'package:chitter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
class message_Screen extends StatefulWidget {
  const message_Screen({Key? key}) : super(key:key);

  @override
  State<message_Screen> createState() => _message_ScreenState();
}





class _message_ScreenState extends State<message_Screen> {
  late IOWebSocketChannel channel;
  bool isLoading = true;
  List<Chat>chatAll = [];

  @override
  void initState() {
    super.initState();
    fetchData();
    chatAll = [];
  }

  fetchData() async {
    String token = await Utility.getSharedPrefs("token");
    var apiSocket = "${websocketAPI}chatAll?authtoken=${token}";
    channel =  IOWebSocketChannel.connect(apiSocket);
    await channel.ready;
    await Future.delayed(Duration(seconds: 2));
    setState(() {
      isLoading = false;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat App'),
      ),
      body: isLoading ? const Center(child: CircularProgressIndicator(),) :  StreamBuilder(
        stream: channel?.stream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if(snapshot.hasData) {
            var data = jsonDecode(snapshot.data);
            chatAll.add(Chat.fromJson(data));
            Utility().logger.i(chatAll);
            return ListView.builder(
              itemCount: chatAll.length,
              itemBuilder: (context, index) {
                return Text(chatAll[index].members[0].username.toString());
              },
            );
          }else {
            return const Center(child:Text("U dont' have Message"));
          }
        },
      ),
    );
  }

  @override
  void dispose() {
    channel.sink.close();
    super.dispose();
  }
}
