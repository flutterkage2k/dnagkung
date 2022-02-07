import 'package:dnagkung/constants/common_size.dart';
import 'package:dnagkung/screens/start/address_service.dart';
import 'package:dnagkung/utils/logger.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AddressPage extends StatelessWidget {
  AddressPage({Key? key}) : super(key: key);

  TextEditingController _addressController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      minimum: EdgeInsets.only(left: common_padding, right: common_padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          TextFormField(
            controller: _addressController,
            decoration: InputDecoration(
              prefixIcon: Icon(
                Icons.search,
                color: Colors.grey,
              ),
              hintText: "도로명으로 검색",
              hintStyle: TextStyle(color: Theme.of(context).hintColor),
              border: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.grey),
              ),
              prefixIconConstraints:
                  BoxConstraints(minWidth: 24, minHeight: 24),
            ),
          ),
          TextButton.icon(
            onPressed: () {
              final text = _addressController.text;
              if (text.isNotEmpty) {
                AddressService().searchAddressByStr(text);
              }
            },
            icon: Icon(
              CupertinoIcons.compass,
              color: Colors.white,
              size: 20,
            ),
            label: Text(
              '현재 위치 찾기',
              style: Theme.of(context).textTheme.button,
            ),
            style: TextButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                minimumSize: Size(10, 47)),
          ),
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: common_padding),
              itemCount: 10,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text('address $index'),
                  subtitle: Text('subtitle $index'),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
