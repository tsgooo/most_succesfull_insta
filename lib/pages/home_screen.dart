import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:tagramm/components/post_card.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SvgPicture.asset(
              'lib/images/ic_instagram.svg',
              height: 35,
              color: Colors.white,
            ),
            // Row(
            //   children: [
            //     GestureDetector(
            //       onTap: () {},
            //       child: const Icon(
            //         Icons.add,
            //         color: Colors.white,
            //       ),
            //     ),
            //     const Padding(
            //       padding: EdgeInsets.all(8.0),
            //       child: Icon(
            //         Icons.favorite_outlined,
            //         color: Colors.white,
            //       ),
            //     ),
            //     const Icon(
            //       Icons.share,
            //       color: Colors.white,
            //     ),
            //   ],
            // ),
          ],
        ),
      ),
      body: StreamBuilder(
          stream: FirebaseFirestore.instance.collection('posts').snapshots(),
          builder: (context,
              AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.data!.docs.isEmpty) {
              return const Center(
                child: Text(
                  'Wow such empty, be the first to post',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              );
            }

            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) => PostCard(
                snap: snapshot.data!.docs[index].data(),
              ),
            );
          }),
    );
  }
}
