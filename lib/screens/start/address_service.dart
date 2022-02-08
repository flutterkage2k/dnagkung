import 'package:dio/dio.dart';
import 'package:dnagkung/constants/keys.dart';
import 'package:dnagkung/data/address_model.dart';
import 'package:dnagkung/data/address_model2.dart';
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

// api site : https://www.vworld.kr/

  Future<AddressModel> searchAddressByStr(String text) async {
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

    AddressModel addressModel =
        AddressModel.fromJson(responese.data["response"]);
    logger.d(addressModel);
    return addressModel;
  }

  Future<List<AddressModel2>> findAddressByCoordinate(
      {required double logX, required double latY}) async {
    final List<Map<String, dynamic>> formDatas = <Map<String, dynamic>>[];

    formDatas.add({
      'key': VWORLD_KEY,
      'service': 'address',
      'request': 'getAddress',
      'type': 'PARCEL',
      'point': '$logX,$latY',
    });
    formDatas.add({
      'key': VWORLD_KEY,
      'service': 'address',
      'request': 'getAddress',
      'type': 'PARCEL',
      'point': '${logX - 0.01},$latY',
    });
    formDatas.add({
      'key': VWORLD_KEY,
      'service': 'address',
      'request': 'getAddress',
      'type': 'PARCEL',
      'point': '${logX + 0.01},$latY',
    });
    formDatas.add({
      'key': VWORLD_KEY,
      'service': 'address',
      'request': 'getAddress',
      'type': 'PARCEL',
      'point': '$logX,${latY - 0.01}',
    });
    formDatas.add({
      'key': VWORLD_KEY,
      'service': 'address',
      'request': 'getAddress',
      'type': 'PARCEL',
      'point': '$logX,${latY + 0.01}',
    });

    List<AddressModel2> addresses = [];

    for (Map<String, dynamic> formData in formDatas) {
      final response = await Dio()
          .get('http://api.vworld.kr/req/address', queryParameters: formData)
          .catchError((e) {
        logger.e(e.message);
      });

      AddressModel2 addressModel =
          AddressModel2.fromJson(response.data["response"]);

      if (response.data['response']['status'] == 'OK')
        addresses.add(addressModel);
    }
    logger.d(addresses);

    return addresses;
  }
}
