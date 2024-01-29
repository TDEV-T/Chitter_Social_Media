import 'package:chitter/screens/feeds/feed_screen.dart';
import 'package:flutter/material.dart';

class homepage__Screen extends StatefulWidget {
  const homepage__Screen({super.key});

  @override
  State<homepage__Screen> createState() => _homepage__ScreenState();
}

class _homepage__ScreenState extends State<homepage__Screen> {
  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 2,
      child: Scaffold(
        body: Column(
          children: [
            TabBar(
              tabs: [
                Tab(icon: Icon(Icons.home)),
                Tab(icon: Icon(Icons.people)),
              ],
            ),
            Expanded(
              child: TabBarView(
                children: [
                  Feed_Screen(typefeed: "public"),
                  Feed_Screen(typefeed: "follower"),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
