import 'package:dnagkung/constants/common_size.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ItemsPage extends StatelessWidget {
  const ItemsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      padding: EdgeInsets.all(common_padding),
      separatorBuilder: (context, index) {
        return Divider(
          height: common_padding * 2 + 1,
          thickness: 1,
          color: Colors.grey[200],
          indent: common_sm_padding,
          endIndent: common_sm_padding,
        );
      },
      itemBuilder: (context, index) {
        return SizedBox(
          height: 100,
          child: Row(
            children: [
              ExtendedImage.network('https://picsum.photos/100'),
              SizedBox(
                width: common_sm_padding,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'work',
                      style: Theme.of(context).textTheme.subtitle1,
                    ),
                    Text(
                      '53days before',
                      style: Theme.of(context).textTheme.subtitle2,
                    ),
                    Text('5000 won'),
                    Expanded(child: Container()),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          height: 15,
                          //FittedBox기능은 원하는 사이즈로 줄여준다. 즉, 위에 SizedBox의 height 사이즈에 맞게
                          child: FittedBox(
                            child: Row(
                              children: [
                                Icon(
                                  CupertinoIcons.chat_bubble_2,
                                  color: Colors.grey,
                                ),
                                Text(
                                  '23',
                                  style: TextStyle(color: Colors.grey),
                                ),
                                Icon(
                                  CupertinoIcons.heart,
                                  color: Colors.grey,
                                ),
                                Text(
                                  '30',
                                  style: TextStyle(color: Colors.grey),
                                )
                              ],
                            ),
                          ),
                        ),
                      ],
                    )
                  ],
                ),
              ),
            ],
          ),
        );
      },
      itemCount: 10,
    );
  }
}
