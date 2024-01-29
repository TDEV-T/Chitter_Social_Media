import 'dart:async';
import 'dart:convert';

import 'package:chitter/components/chat/chat_header.dart';
import 'package:chitter/models/ChatAll.dart';
import 'package:chitter/utils/constants.dart';
import 'package:chitter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class message_Screen extends StatefulWidget {
  const message_Screen({Key? key}) : super(key: key);

  @override
  State<message_Screen> createState() => _message_ScreenState();
}

class _message_ScreenState extends State<message_Screen> {
  late IOWebSocketChannel channel;
  bool isLoading = true;
  List<Chat> chatAll = [];
  final StreamController<List<Chat>> _streamController =
      StreamController<List<Chat>>();

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    String token = await Utility.getSharedPrefs("token");
    var apiSocket = "${websocketAPI}chatAll?authtoken=${token}";
    channel = IOWebSocketChannel.connect(apiSocket);
    channel.stream.listen((event) {
      var data = jsonDecode(event);
      chatAll.add(Chat.fromJson(data));
      _streamController.add(chatAll);
    });
    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chat'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : StreamBuilder(
              stream: _streamController.stream,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Text('Error: ${snapshot.error}');
                } else if (snapshot.hasData) {
                  var chatAll = snapshot.data as List<Chat>;
                  return ListView.builder(
                    itemCount: chatAll.length,
                    itemBuilder: (context, index) {
                      return chat_header(
                        imgProfile:
                            imageAPI + chatAll[index].members[0].profilepicture,
                        username: chatAll[index].members[0].username,
                        uid: chatAll[index].members[0].id,
                      );
                    },
                  );
                } else {
                  return const Center(child: Text("U dont' have Message"));
                }
              },
            ),
    );
  }

  @override
  void dispose() {
    channel.sink.close();
    _streamController.close();
    super.dispose();
  }
}
