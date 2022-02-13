import 'package:dnagkung/constants/common_size.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class ItemsPage extends StatelessWidget {
  const ItemsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        Size size = MediaQuery.of(context).size;
        final imgSize = size.width / 4;
        return FutureBuilder(
            future: Future.delayed(Duration(seconds: 2)),
            builder: (context, snapshot) {
              return AnimatedSwitcher(
                duration: Duration(milliseconds: 300),
                child: (snapshot.connectionState != ConnectionState.done)
                    ? _shimmerListView(imgSize)
                    : _listView(imgSize),
              );
            });
        // return _listView(imgSize);
      },
    );
  }

  ListView _listView(double imgSize) {
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
          //비율에 맞도록 변경해보자.
          height: imgSize,
          child: Row(
            children: [
              SizedBox(
                  height: imgSize,
                  width: imgSize,
                  child: ExtendedImage.network(
                    'https://picsum.photos/100',
                    shape: BoxShape.rectangle, //rectangle 로 해야 꼭지점 부분만 없어짐
                    borderRadius: BorderRadius.circular(12),
                  )),
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

  Widget _shimmerListView(double imgSize) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.red[100]!,
      enabled: true,
      child: ListView.separated(
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
            //비율에 맞도록 변경해보자.
            height: imgSize,
            child: Row(
              children: [
                Container(
                  height: imgSize,
                  width: imgSize,
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                SizedBox(
                  width: common_sm_padding,
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        height: 14,
                        width: 150,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Container(
                        height: 16,
                        width: 180,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      SizedBox(
                        height: 4,
                      ),
                      Container(
                        height: 14,
                        width: 100,
                        decoration: BoxDecoration(
                          shape: BoxShape.rectangle,
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(3),
                        ),
                      ),
                      Expanded(
                        child: Container(),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            height: 14,
                            width: 80,
                            decoration: BoxDecoration(
                              shape: BoxShape.rectangle,
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(3),
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
      ),
    );
  }
}
