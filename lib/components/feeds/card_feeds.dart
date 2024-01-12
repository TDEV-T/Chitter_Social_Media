import 'package:chitter/components/feeds/card_feed_footer.dart';
import 'package:chitter/components/feeds/card_feed_header.dart';
import 'package:flutter/material.dart';
import 'card_feed_content.dart';

class CardFeed extends StatelessWidget {
  const CardFeed({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(10),
      child: Column(
        children: [
          CardFeedHeader(username: "pathrapol", fullname: "pathrapol pitak", imgSrc: "https://gweb-research-imagen.web.app/compositional/An%20oil%20painting%20of%20a%20British%20Shorthair%20cat%20wearing%20a%20cowboy%20hat%20and%20red%20shirt%20skateboarding%20on%20a%20beach./1_.jpeg"),
          CardFeedContent(text: "test", imgSrc: ""),
          CardFeedFooter()
        ],
      ),
    );
  }
}
