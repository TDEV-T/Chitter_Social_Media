import 'package:chitter/components/feeds/card_feeds.dart';
import 'package:flutter/material.dart';

class Feed_Screen extends StatefulWidget {
  const Feed_Screen({super.key});

  @override
  State<Feed_Screen> createState() => _Feed_ScreenState();
}

class _Feed_ScreenState extends State<Feed_Screen> {
  @override
  Widget build(BuildContext context) {
    return _listView();
  }

  Widget _listView() {
    return ListView.builder(itemCount: 12, itemBuilder: (context, index) {
      return Padding(padding: const EdgeInsets.all(0),
      child: CardFeed()
      );
    });
  }
}
