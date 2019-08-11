import 'package:flutter/material.dart';

class MinePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return new Page();
  }
}

class Page extends State<MinePage> {
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
    return new AppBar(title: const Text('我的'));
  }

  Widget header(BuildContext context) {
    return new Image.network(
      'http://a.hiphotos.baidu.com/image/pic/item/4610b912c8fcc3cebba8b8e09c45d688d53f20fc.jpg',

    );
  }
}
