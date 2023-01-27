import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ShopPage extends StatelessWidget {
  ShopPage({super.key});

  bool onScrolled = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // appBar: PreferredSize(
      //   preferredSize: const Size.fromHeight(35),
      //   child: AppBar(
      //     title: Container(
      //       color: Colors.transparent,
      //       child: Padding(
      //         padding: const EdgeInsets.all(8.0),
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.spaceBetween,
      //           children: [
      //             const Text('Shop',
      //                 style: TextStyle(fontWeight: FontWeight.bold)),
      //             Row(
      //               children: const [
      //                 Icon(Icons.book_online),
      //                 SizedBox(width: 10),
      //                 Icon(Icons.menu),
      //               ],
      //             )
      //           ],
      //         ),
      //       ),
      //     ),
      //   ),
      // ),
      
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 200,
            floating: false,
            pinned: true,
            leading: Padding(
              padding: const EdgeInsets.only(top: 10, left: 8),
              child: onScrolled
                  ? const Text('')
                  : const Text(
                      'Shop',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
            ),
            actions: const [
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.calendar_month_outlined),
              ),
              Padding(
                padding: EdgeInsets.all(8.0),
                child: Icon(Icons.menu),
              ),
            ],
            flexibleSpace: const FlexibleSpaceBar(
              title: Text('csakc'),
            ),
          ),
          SliverGrid.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
            ),
            itemCount: 100,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.all(2.0),
                child: Container(
                  color: Colors.grey,
                ),
              );
            },
          ),
        ],
      ),
      // body: Column(
      //   children: [
      //     const SizedBox(height: 5),
      //     ClipRRect(
      //       borderRadius: BorderRadius.circular(8),
      //       child: Container(
      //         color: Colors.grey,
      //         height: 35,
      //         child: Padding(
      //           padding: const EdgeInsets.all(8.0),
      //           child: Row(
      //             children: const [
      //               Icon(Icons.search),
      //               SizedBox(width: 15),
      //               Text('Search shops'),
      //             ],
      //           ),
      //         ),
      //       ),
      //     ),
      //     const SizedBox(height: 5),
      //     ClipRRect(
      //       borderRadius: BorderRadius.circular(8),
      //       child: Container(
      //         color: Colors.grey,
      //         height: 30,
      //         child: Row(
      //           mainAxisAlignment: MainAxisAlignment.center,
      //           children: const [
      //             Text(
      //               'Videos',
      //               style: TextStyle(fontWeight: FontWeight.bold),
      //             ),
      //           ],
      //         ),
      //       ),
      //     ),
      //     GridView.builder(
      //       gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
      //         crossAxisCount: 2,
      //       ),
      //       itemBuilder: (context, index) {
      //         return Padding(
      //           padding: const EdgeInsets.all(2),
      //           child: Container(color: Colors.grey),
      //         );
      //       },
      //     ),
      //   ],
      // ),
    );
  }
}
