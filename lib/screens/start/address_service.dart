import 'package:dio/dio.dart';
import 'package:dnagkung/constants/keys.dart';
import 'package:dnagkung/utils/logger.dart';

class AddressService {
  // 方法は２つあります。
  // その１
  // void dioTest() async {
  //   try {
  //     var response = await Dio().get('https://randomuser.me/api/');
  //     logger.d(response);
  //   } catch (e) {
  //     logger.e(e);
  //   }
  // }

  // その２
  // void dioTest() async {
  //   var response =
  //       await Dio().get('https://randomuser.me/api/').catchError((e) {
  //     logger.e(e.error);
  //   });
  //   logger.d(response);
  // }

  void searchAddressByStr(String text) async {
    final formData = {
      'key': VWORLD_KEY,
      'request': 'search',
      'type': 'ADDRESS',
      'category': 'ROAD',
      'query': text,
      'size': 30,
    };

    final responese = await Dio()
        .get('http://api.vworld.kr/req/search', queryParameters: formData)
        .catchError((e) {
      logger.e(e.mssage);
    });
    logger.d(responese);
  }
}
