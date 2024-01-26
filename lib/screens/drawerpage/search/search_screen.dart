import 'package:chitter/components/feeds/card_feeds.dart';
import 'package:chitter/components/searchs/search_user.dart';
import 'package:chitter/controller/SearchController.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/get_core.dart';

class search_Screen extends StatefulWidget {
  const search_Screen({super.key});

  @override
  State<search_Screen> createState() => _search_Screen();
}

class _search_Screen extends State<search_Screen> {
  final SearchGetxController searchController = Get.put(SearchGetxController());
  final search = TextEditingController();
  var refreshKey = GlobalKey<RefreshIndicatorState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
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
                      search.text = "";
                    },
                  ),
                  hintText: 'Search...',
                  border: InputBorder.none),
              onSubmitted: (String value) async {
                await searchController.searchFunction(value);
              },
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        key: refreshKey,
        onRefresh: () async {},
        child: Obx(() => Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  child: const Text("User Found : "),
                ),
                Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount:
                        searchController.searchResult.value.userFind?.length ??
                            0,
                    itemBuilder: (BuildContext context, int index) {
                      return searchController
                              .searchResult.value.userFind!.isNotEmpty
                          ? search_Header(
                              usrData: searchController
                                  .searchResult.value.userFind![index])
                          : Container();
                    },
                  ),
                ),
                const Divider(),
                Container(
                  margin: const EdgeInsets.all(10),
                  child: const Text("Post Found : "),
                ),
                Container(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount:
                        searchController.searchResult.value.postFind?.length ??
                            0,
                    itemBuilder: (BuildContext context, int index) {
                      return searchController
                              .searchResult.value.postFind!.isNotEmpty
                          ? CardFeed(
                              pml: searchController
                                  .searchResult.value.postFind![index],
                              refreshKey: refreshKey)
                          : Container();
                    },
                  ),
                )
              ],
            )),
      ),
    );
  }
}
