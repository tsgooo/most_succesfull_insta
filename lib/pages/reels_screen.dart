import 'package:flutter/material.dart';

class ReelsPage extends StatelessWidget {
  const ReelsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView.builder(
        scrollDirection: Axis.vertical,
        itemCount: 10,
        itemBuilder: ((context, index) {
          return Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Container(
                height: MediaQuery.of(context).size.height / 2,
                alignment: const Alignment(1, 1),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: const [
                          Icon(Icons.favorite_outline),
                          SizedBox(height: 10),
                          Text('1.2M'),
                        ],
                      ),
                      Column(
                        children: const [
                          Icon(Icons.chat_bubble_outline),
                          SizedBox(height: 10),
                          Text('1.2M'),
                        ],
                      ),
                      Column(
                        children: const [
                          Icon(Icons.send),
                          SizedBox(height: 10),
                          Text('1.2M'),
                        ],
                      ),
                      const Icon(Icons.more_vert),
                      Container(
                        height: 30,
                        width: 30,
                        decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                color: Colors.black54,
                alignment: const Alignment(-1, 1),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: MediaQuery.of(context).size.width / 2.7,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(2.0),
                          child: Row(
                            children: const [
                              Icon(Icons.camera_alt_outlined, size: 15),
                              Text(
                                ' Use as template',
                                style: TextStyle(fontSize: 12, fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Row(
                        children: [
                          Container(
                            height: 30,
                            width: 30,
                            decoration: BoxDecoration(
                              color: Colors.black,
                              borderRadius: BorderRadius.circular(30),
                            ),
                          ),
                          const SizedBox(width: 10),
                          const Text(
                            'Nre ni bnaa',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.all(10.0),
                            padding: const EdgeInsets.all(2.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(7),
                              border: Border.all(color: Colors.black),
                            ),
                            child: const Text('Follow'),
                          ),
                        ],
                      ),
                      Row(
                        children: const [
                          Text(
                            'Remix with ',
                            style: TextStyle(fontSize: 12),
                          ),
                          Text(
                            'bas ner',
                            style: TextStyle(
                                fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      RichText(
                        text: const TextSpan(
                          children: [
                            TextSpan(text: 'dondog, dulmaa '),
                            TextSpan(text: 'avjbebvo'),
                          ],
                        ),
                      ),
                      Row(
                        children: const [
                          Icon(Icons.music_video, size: 15.0),
                          SizedBox(width: 5),
                          Text(
                            'duunii ner ym shig bgan',
                            style: TextStyle(fontSize: 12),
                          ),
                          Text(
                            ' · Original audio',
                            style: TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
