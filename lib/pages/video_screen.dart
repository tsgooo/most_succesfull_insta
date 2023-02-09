import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tagramm/components/video_player_item.dart';
import 'package:tagramm/methods/video_controller.dart';

class VideoScreen extends StatelessWidget {
  VideoScreen({super.key});

  final VideoController videoController = VideoController();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: Obx(
        () {
          return PageView.builder(
            itemCount: videoController.videoList.length,
            controller: PageController(initialPage: 0, viewportFraction: 1),
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              final data = videoController.videoList[index];
              return Stack(
                children: [
                  VideoPlayerItem(
                    videoUrl: data.videoUrl,
                  ),
                  Column(
                    children: [
                      const SizedBox(height: 100),
                      Expanded(
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Expanded(
                              child: Container(
                                padding: const EdgeInsets.only(left: 20),
                                child: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    Row(
                                      children: [
                                        CircleAvatar(
                                          radius: 18,
                                          backgroundImage:
                                              NetworkImage(data.profilePhoto),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          data.username,
                                          style: const TextStyle(
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Container(
                                          height: size.height / 30,
                                          width: size.width / 5,
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            border: Border.all(
                                              color: Colors.white,
                                            ),
                                          ),
                                          child: const Center(
                                            child: Padding(
                                              padding: EdgeInsets.all(5.0),
                                              child: Text(
                                                'Follow',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Text(
                                      data.caption,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Container(
                              width: size.width / 7,
                              height: size.height / 3,
                              margin: EdgeInsets.only(
                                top: size.height / 5,
                              ),
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceEvenly,
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    child: Column(
                                      children: [
                                        const Icon(
                                          Icons.favorite_outline,
                                          size: 24,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          data.likes.length.toString(),
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Column(
                                      children: [
                                        const Icon(
                                          Icons.chat_bubble_outline,
                                          size: 24,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          data.commentCount.toString(),
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: Column(
                                      children: [
                                        const Icon(
                                          Icons.share_outlined,
                                          size: 24,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          data.shareCount.toString(),
                                          style: const TextStyle(fontSize: 12),
                                        ),
                                      ],
                                    ),
                                  ),
                                  InkWell(
                                    onTap: () {},
                                    child: const Column(
                                      children: [
                                        Icon(
                                          Icons.more_vert,
                                          size: 24,
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    height: size.height / 25,
                                    width: size.width / 12,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      color: Colors.deepPurple,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
