import 'package:chitter/utils/utils.dart';
import 'package:flutter/material.dart';

class search_Screen extends StatelessWidget {
   search_Screen({Key? key}) : super(key: key);



  final search = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: Container(
        width: double.infinity,
        height: 40,
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(5)),
        child: Center(
          child: TextField(
            controller: search,
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    search.text  = "";
                  },
                ),
                hintText: 'Search...',
                border: InputBorder.none),
            onSubmitted: (String value) async{
              var resp = await RestAPI().
            },
          ),
        ),
      )),
    );
  }
}
