import 'package:flutter/material.dart';
import 'package:story_view/story_controller.dart';
import 'package:story_view/story_view.dart';

// ignore: must_be_immutable
class StoryPageView extends StatelessWidget {

  String url;

  StoryPageView(String statusPhoto) {
    this.url = statusPhoto;
  }

  @override
  Widget build(BuildContext context) {
    final controller = StoryController();
    final List<StoryItem> storyItems = [
      StoryItem.pageImage(NetworkImage(
          url)),
      /*
      StoryItem.text("Hi", Colors.red),
      StoryItem.pageGif(
          "https://media3.giphy.com/media/SKGo6OYe24EBG/giphy.gif?cid=ecf05e47u6tpquko1q13h8om770p6dwwvd3q2udwlmtg3mtt&rid=giphy.gif",
          imageFit: BoxFit.contain),
          */
    ];
    return Material(
      child: StoryView(
        storyItems,
        controller: controller,
        inline: false,
        repeat: true,
      ),
    );
  }
}
