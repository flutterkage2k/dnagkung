import 'package:dnagkung/screens/start/address_page.dart';
import 'package:dnagkung/screens/start/auth_page.dart';
import 'package:dnagkung/screens/start/intro_page.dart';
import 'package:flutter/material.dart';

class StartScreen extends StatelessWidget {
  StartScreen({Key? key}) : super(key: key);

  final PageController _pageController = PageController();
  //viewportFraction = 다음페이지를 조금 보이게 만들어준다.

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: PageView(
          // physics: NeverScrollableScrollPhysics(),
          //physics: NeverScrollableScrollPhysics(), 손가락으로 스와이프는 막는다.
          controller: _pageController,
          children: [
            IntroPage(_pageController),
            AddressPage(),
            AuthPage(),
          ]),
    );
  }
}
