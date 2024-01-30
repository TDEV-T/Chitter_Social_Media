import 'dart:async';
import 'dart:convert';

import 'package:chitter/components/chat/chat_bubble.dart';
import 'package:chitter/components/chat/chat_message_input.dart';
import 'package:chitter/models/MessageModel.dart';
import 'package:chitter/utils/constants.dart';
import 'package:chitter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';

class chat_Screen extends StatefulWidget {
  const chat_Screen({Key? key, required this.rcid}) : super(key: key);

  final int rcid;
  @override
  State<chat_Screen> createState() => _chat_ScreenState();
}

class _chat_ScreenState extends State<chat_Screen> {
  late IOWebSocketChannel channel;
  List<MessageModel> MessageAll = [];
  late bool isLoading = true;
  late StreamController<List<MessageModel>> _streamController =
      StreamController<List<MessageModel>>();

  final TextEditingController _textcontroller = TextEditingController();
  late int myid;

  @override
  void initState() {
    super.initState();
    // _streamController = StreamController<List<MessageModel>>.broadcast();
    fetchData();

  }

  fetchData() async {
    String token = await Utility.getSharedPrefs("token");
    var apiSocket =
        "${websocketAPI}chat?authtoken=${token}&receiverId=${widget.rcid}";
    channel = IOWebSocketChannel.connect(apiSocket);
    channel.stream.listen((event) {
      var data = jsonDecode(event);
      MessageAll.add(MessageModel.fromJson(data));
      _streamController.add(MessageAll);
    });
    myid = await Utility.getSharedPrefs("userid");
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
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Column(
              children: [
                Expanded(
                  child: StreamBuilder(
                    stream: _streamController.stream,
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Text('Error: ${snapshot.error}');
                      } else if (snapshot.hasData) {
                        var messageList = snapshot.data as List<MessageModel>;
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: messageList.length,
                          itemBuilder: (context, index) {
                            bool curUser = false;
                            messageList[index].sender == myid ? curUser = true : curUser = false;
                            return ChatBubble(
                                message: messageList[index].message ?? "Null",
                                isCurrentUser: curUser);
                          },
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
                chat_message_input(controller: _textcontroller),
              ],
            ),
    );
  }
}
