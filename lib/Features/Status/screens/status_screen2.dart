import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';
import 'package:whisper/Common/Utils/loader.dart';
import 'package:whisper/Models/statusModel.dart';

class StatusScreen2 extends StatefulWidget {
  static const String routeName = "/status-screen2";
  final Status status;
  const StatusScreen2({super.key, required this.status});

  @override
  State<StatusScreen2> createState() => _StatusScreen2State();
}

class _StatusScreen2State extends State<StatusScreen2> {
  StoryController storyController = StoryController();
  List<StoryItem> storyItems = [];

  void initStoryPageItems() {
    for (int i = 0; i < widget.status.photoUrl.length; i++) {
      storyItems.add(
        StoryItem.pageImage(
          url: widget.status.photoUrl[i],
          controller: storyController,
        ),
      );
    }
  }

  @override
  void initState() {
    super.initState();
    initStoryPageItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: storyItems.isEmpty
          ? const Loader()
          : StoryView(
              storyItems: storyItems,
              controller: storyController,
              onVerticalSwipeComplete: (p0) {
                if (p0 == Direction.down) {
                  Navigator.pop(context);
                }
              },
            ),
    );
  }
}
