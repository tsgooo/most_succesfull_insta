import 'package:flutter/material.dart';
import 'package:story_view/story_view.dart';

class StoryViewPage extends StatefulWidget {
  const StoryViewPage({super.key});

  @override
  State<StoryViewPage> createState() => _StoryViewState();
}

class _StoryViewState extends State<StoryViewPage> {
  final _controller = StoryController();

  @override
  Widget build(BuildContext context) {
    return Material(
      child: StoryView(
        storyItems: [
          StoryItem.text(
            title: 'advbajdva',
            backgroundColor: Colors.black,
          ),
        ],
        controller: _controller,
        onComplete: () {
          Navigator.pop(context);
        },
        onVerticalSwipeComplete: (direction) {
          if (direction == Direction.down) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
