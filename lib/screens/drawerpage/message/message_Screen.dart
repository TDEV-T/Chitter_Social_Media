import 'package:chitter/utils/constants.dart';
import 'package:chitter/utils/utils.dart';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/io.dart';
class message_Screen extends StatefulWidget {
  const message_Screen({super.key});

  @override
  State<message_Screen> createState() => _message_ScreenState();
}





class _message_ScreenState extends State<message_Screen> {
  late String token;
  late IOWebSocketChannel channel;

  @override
  void initState() {
    super.initState();
    fetchData();

  }

  fetchData() async {
    token = await Utility.getSharedPrefs("token");
    var apiSocket = "${websocketAPI}chatAll?authtoken${token}";
    print(apiSocket);
    channel = IOWebSocketChannel.connect(apiSocket);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat App'),
      ),
      body: StreamBuilder(
        stream: channel.stream,
        builder: (context, snapshot) {
          Utility().logger.i(snapshot.data);
          return snapshot.data != null && snapshot.data.length > 0 ?
           ListView.builder(
            itemCount: snapshot.data.length,
            itemBuilder: (context, index) {
              final chat = snapshot.data[index];
              return ListTile(
                title: Text(chat['username']),
                subtitle: Text(chat['message']),
              );
            },
          ) :  Container();
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
