import 'package:flutter/material.dart';

class FindPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return new Page();
  }
}

class Page extends State<FindPage> {
  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  Widget layout(BuildContext context) {
    return new Scaffold(
      appBar: buildAppBar(context),
      body: new ListView(
        children: <Widget>[
          header(context),
          header(context),
          header(context),
          header(context),
          header(context),
        ],
      ),
    );
  }

  Widget buildAppBar(BuildContext context) {
    return new AppBar(title: const Text('设备管理'));
  }

  Widget header(BuildContext context) {
    return new Image.network(
      'http://e.hiphotos.baidu.com/image/pic/item/4610b912c8fcc3cef70d70409845d688d53f20f7.jpg',

    );
  }
}
