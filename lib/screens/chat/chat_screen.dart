import 'dart:async';
import 'dart:convert';

import 'package:chitter/components/chat/chat_bubble.dart';
import 'package:chitter/components/chat/chat_message_input.dart';
import 'package:chitter/models/MessageModel.dart';
import 'package:chitter/utils/constants.dart';
import 'package:chitter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class chat_Screen extends StatefulWidget {
  const chat_Screen({Key? key, required this.rcid}) : super(key: key);

  final int rcid;
  @override
  State<chat_Screen> createState() => _chat_ScreenState();
}

class _chat_ScreenState extends State<chat_Screen> {
  late WebSocketChannel channel;
  List<MessageModel> MessageAll = [];
  late bool isLoading = true;
  final StreamController<List<MessageModel>> _streamController =
      StreamController<List<MessageModel>>();

  final TextEditingController _textcontroller = TextEditingController();
  late int myid;

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  fetchData() async {
    String token = await Utility.getSharedPrefs("token");
    var apiSocket = Uri.parse(
        "${websocketAPI}chat?authtoken=${token}&receiverId=${widget.rcid}");
    Utility().logger.f(apiSocket);
    channel = IOWebSocketChannel.connect(apiSocket);
    await channel.ready;
    channel.stream.listen((event) {
      var data = jsonDecode(event);
      setState(() {
        Utility().logger.i("Data coming !");
        MessageAll.add(MessageModel.fromJson(data));
        _streamController.add(MessageAll);
      });
    });
    myid = await Utility.getSharedPrefs("userid");
    setState(() {
      isLoading = false;
    });
  }

  void sendMessage(String message) {
    channel.sink.add(message);
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
                      if (snapshot.hasData) {
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: MessageAll.length,
                          itemBuilder: (context, index) {
                            bool curUser = false;
                            MessageAll[index].sender == myid
                                ? curUser = true
                                : curUser = false;
                            Utility()
                                .logger
                                .i("${MessageAll[index].sender} + ${myid}");
                            return ChatBubble(
                                message: MessageAll[index].message ?? "Null",
                                isCurrentUser: curUser);
                          },
                        );
                      } else {
                        return Container();
                      }
                    },
                  ),
                ),
                chat_message_input(
                  controller: _textcontroller,
                  onSubmit: () async {
                    sendMessage(_textcontroller.text);
                    _textcontroller.text = "";
                  },
                ),
              ],
            ),
    );
  }
}
