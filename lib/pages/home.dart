import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:tagramm/pages/add_post_screen.dart';
import 'package:tagramm/pages/home_screen.dart';
import 'package:tagramm/pages/profile_screen.dart';
import 'package:tagramm/pages/search_screen.dart';
import 'package:tagramm/pages/shop_screen.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {

  int _selectedIndex = 0;

  void _navigateBottomBar(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final List<Widget> _pages = [
    const HomePage(),
    const SearchScreen(),
    const AddImage(),
    const AddVideo(),
    ProfileScreen(uid: FirebaseAuth.instance.currentUser!.uid),
    // VideoScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        // backgroundColor: Colors.black,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.white,
        onTap: _navigateBottomBar,
        type: BottomNavigationBarType.shifting,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(
              Icons.home_outlined,
            ),
            label: 'home',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.search,
              ),
              label: 'search'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.add_circle_outline,
              ),
              label: 'reels'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.favorite_outline,
              ),
              label: 'shop'),
          BottomNavigationBarItem(
              icon: Icon(
                Icons.circle,
              ),
              label: 'profile'),
        ],
      ),
    );
  }
}
