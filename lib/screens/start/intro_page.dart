import 'package:dnagkung/utils/logger.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';

class IntroPage extends StatelessWidget {
  const IntroPage({Key? key}) : super(key: key);

  void onButtonClick() {
    logger.d('on text button  clicked!!');
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      Size size = MediaQuery.of(context).size;
      final imgSize = size.width - 32;
      final sizeOfPosImg = imgSize * 0.1;

      return SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Text(
                '토마토마켓',
                style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
              // stack意味はlayを重ねって使うことができる。
              SizedBox(
                width: imgSize,
                height: imgSize,
                child: Stack(
                  children: [
                    ExtendedImage.asset('assets/imgs/carrot_intro.png'),
                    Positioned(
                        width: sizeOfPosImg,
                        left: imgSize * 0.45,
                        top: imgSize * 0.45,
                        height: sizeOfPosImg,
                        child: ExtendedImage.asset(
                            'assets/imgs/carrot_intro_pos.png')),
                  ],
                ),
              ),
              Text(
                '우리 동네 중고 직거래 토토토마켓',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Text(
                '직거래 마켓',
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  TextButton(
                    onPressed: onButtonClick,
                    style: TextButton.styleFrom(backgroundColor: Colors.blue),
                    child: Text(
                      '시작',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );
    });
  }
}
