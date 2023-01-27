import 'package:flutter/material.dart';
import 'package:tagramm/components/story_view.dart';

class StoryCircle extends StatelessWidget {
  const StoryCircle({
    super.key,
    required this.name,
  });

  final String name;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const StoryViewPage(),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            Container(
              height: 50,
              width: 50,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
              ),
            ),
            const SizedBox(height: 10),
            Text(name),
          ],
        ),
      ),
    );
  }
}
