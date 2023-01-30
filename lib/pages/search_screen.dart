import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:tagramm/pages/profile_screen.dart';
import 'package:tagramm/utilities/colors.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController searchController = TextEditingController();
  bool isShowUser = false;

  @override
  void dispose() {
    super.dispose();
    searchController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        appBar: isShowUser
            ? AppBar(
                backgroundColor: Colors.black,
                leading: IconButton(
                  onPressed: () {
                    setState(() {
                      isShowUser = false;
                    });
                  },
                  icon: const Icon(
                    Icons.arrow_back,
                  ),
                ),
                title: TextFormField(
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  controller: searchController,
                  onTap: () {
                    setState(() {
                      isShowUser = true;
                    });
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search user here',
                    hintStyle: TextStyle(
                      color: secondaryColor,
                    ),
                  ),
                  onFieldSubmitted: (String _) {
                    setState(() {
                      isShowUser = true;
                    });
                  },
                ),
              )
            : AppBar(
                backgroundColor: Colors.black,
                title: TextFormField(
                  style: const TextStyle(
                    color: Colors.white,
                  ),
                  controller: searchController,
                  onTap: () {
                    setState(() {
                      isShowUser = true;
                    });
                  },
                  decoration: const InputDecoration(
                    border: InputBorder.none,
                    hintText: 'Search user here',
                    hintStyle: TextStyle(
                      color: secondaryColor,
                    ),
                  ),
                  onFieldSubmitted: (String _) {
                    setState(() {
                      isShowUser = true;
                    });
                  },
                ),
              ),
        body: isShowUser
            ? FutureBuilder(
                future:
                    //  FirebaseFirestore.instance.collection('users').doc().data().toString().contains('usename') ?
                    FirebaseFirestore.instance
                        .collection('users')
                        .where('username',
                            isGreaterThanOrEqualTo: searchController.text)
                        .get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return ListView.builder(
                    itemCount: (snapshot.data! as dynamic).docs.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => ProfileScreen(
                                uid: (snapshot.data! as dynamic).docs[index]
                                    ['uid'],
                              ),
                            ),
                          );
                        },
                        child: ListTile(
                          leading: CircleAvatar(
                            backgroundImage: NetworkImage(
                              (snapshot.data! as dynamic).docs[index]
                                  ['photoUrl'],
                            ),
                          ),
                          title: Text(
                            (snapshot.data! as dynamic).docs[index]['username'],
                            style: const TextStyle(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              )
            : FutureBuilder(
                future: FirebaseFirestore.instance.collection('posts').get(),
                builder: (context, snapshot) {
                  if (!snapshot.hasData) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  return StaggeredGridView.countBuilder(
                    crossAxisCount: 3,
                    itemCount: (snapshot.data! as dynamic).docs.length,
                    itemBuilder: (context, index) => Image.network(
                      (snapshot.data! as dynamic).docs[index]['postUrl'],
                    ),
                    staggeredTileBuilder: (index) => StaggeredTile.count(
                      (index & 7 == 0) ? 2 : 1,
                      (index & 7 == 0) ? 2 : 1,
                    ),
                    mainAxisSpacing: 8,
                    crossAxisSpacing: 8,
                  );
                },
              )
        // : const Center(
        //     child: Text('There is no post at the moment'),
        //   ),
        );
  }
}
