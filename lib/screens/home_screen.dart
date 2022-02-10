import 'package:dnagkung/states/user_provider.dart';
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Text("양촌읍", style: Theme.of(context).appBarTheme.titleTextStyle),
        actions: [
          IconButton(
            onPressed: () {
              context.read<UserProvider>().setUserAuth(false);
            },
            icon: Icon(CupertinoIcons.search),
          ),
          IconButton(
            onPressed: () {
              context.read<UserProvider>().setUserAuth(false);
            },
            icon: Icon(CupertinoIcons.text_justify),
          ),
          IconButton(
            onPressed: () {
              context.read<UserProvider>().setUserAuth(false);
            },
            icon: Icon(CupertinoIcons.nosign),
          ),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _bottomSelectedIndex,
        type: BottomNavigationBarType.fixed,
        items: [
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('assets/imgs/home_1.png')),
              label: 'HOME'),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('assets/imgs/user_3.png')),
              label: 'FEED'),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('assets/imgs/user_3.png')),
              label: 'FEED'),
          BottomNavigationBarItem(
              icon: ImageIcon(AssetImage('assets/imgs/user_3.png')),
              label: 'FEED'),
        ],
        onTap: (index) {
          setState(() {
            _bottomSelectedIndex = index;
          });
        },
      ),
    );
  }
}
