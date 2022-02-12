import 'package:dnagkung/screens/home/items_page.dart';
import 'package:dnagkung/states/user_provider.dart';
import 'package:dnagkung/utils/logger.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _bottomSelectedIndex = 0;

  List<BottomNavigationBarItem> btmNavItems = [
    BottomNavigationBarItem(
        icon: ImageIcon(AssetImage('assets/imgs/home_1.png')), label: 'HOME'),
    BottomNavigationBarItem(
        icon: ImageIcon(AssetImage('assets/imgs/user_3.png')), label: 'FEED'),
    BottomNavigationBarItem(
        icon: ImageIcon(AssetImage('assets/imgs/user_3.png')), label: 'FEED'),
    BottomNavigationBarItem(
        icon: ImageIcon(AssetImage('assets/imgs/user_3.png')), label: 'FEED'),
  ];

  final List<Widget> _screens = [
    ItemsPage(),
    Container(
      color: Colors.black,
    ),
    Container(
      color: Colors.blueAccent,
    ),
    Container(
      color: Colors.greenAccent,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _bottomSelectedIndex,
        children: _screens,
      ),
      appBar: AppBar(
        centerTitle: false,
        title: Text("양촌읍", style: Theme.of(context).appBarTheme.titleTextStyle),
        actions: [
          IconButton(
            onPressed: () {},
            icon: Icon(CupertinoIcons.search),
          ),
          IconButton(
            onPressed: () {
              // context.read<UserProvider>().setUserAuth(false);
            },
            icon: Icon(CupertinoIcons.text_justify),
          ),
          IconButton(
            onPressed: () {
              FirebaseAuth.instance.signOut();
            },
            icon: Icon(CupertinoIcons.nosign),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomSelectedIndex,
        type: BottomNavigationBarType.fixed,
        items: btmNavItems,
        onTap: _onBtmItemClick,
      ),
    );
  }

  void _onBtmItemClick(int index) {
    logger.d(index);
    setState(() {
      _bottomSelectedIndex = index;
    });
  }
}
