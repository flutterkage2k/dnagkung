import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text('토토토마켓'),
        ExtendedImage.asset('assets/imgs/carrot_intro.png'),
        Text('우리 동네 중고 직거래 토토토마켓'),
        Text('직거래 마켓'),
        TextButton(
          onPressed: () {},
          child: Text('시작'),
        )
      ],
    );
  }
}
