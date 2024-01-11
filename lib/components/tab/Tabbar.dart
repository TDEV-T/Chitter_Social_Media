import 'package:flutter/material.dart';
class TabbarDashboard extends StatefulWidget {
  const TabbarDashboard({super.key});

  @override
  State<TabbarDashboard> createState() => _TabbarState();
}

class _TabbarState extends State<TabbarDashboard> with TickerProviderStateMixin {

  late final TabController _tabController;

  @override
  void initState(){
    super.initState();
    _tabController = TabController(length:3,vsync:this);
  }

  @override
  void dispose(){
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  TabBar(
      controller: _tabController,
      tabs: [
        Tab(icon: Icon(Icons.home)),
        Tab(icon: Icon(Icons.search_outlined)),
        Tab(icon: Icon(Icons.home)),
      ],
    );
  }
}
