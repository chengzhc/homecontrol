import 'package:flutter/material.dart';
import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:homecontrol/page/LoginPage.dart';




class HomePage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState

    return new Page();
  }
}

class Page extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return layout(context);
  }

  Widget layout(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(title: const Text('监控管理')),
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

  Widget header(BuildContext context) {
    return new Image.network(
      'http://i2.yeyou.itc.cn/2014/huoying/hd_20140925/hyimage06.jpg',

    );
  }

  _getRoomList() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String token=prefs.getString("token");
    if (token==null) {
      showDialog(
          context: context,
          builder: (_) => new AlertDialog(
              title: new Text("提示"),
              content: new Text("您尚未登陆"),
              actions:<Widget>[
                new FlatButton(child:new Text("不想登陆"), onPressed: (){
                  Navigator.of(context).pop();

                },),
                new FlatButton(child:new Text("去登陆页"), onPressed: (){
                  Navigator.of(context).pop();
                  Navigator.of(context).pushReplacement(
                    //=========
                      new PageRouteBuilder(
                          pageBuilder: (BuildContext context,
                              Animation<double> animation,
                              Animation<double> secondaryAnimation) {
                            //页面名，加传值，需页面dart的构造函数支持
                            return new LoginPage();
                          })
                    //==========
                  );
                },)
              ]

          ));

    }
    var url = 'http://home.chengzhen1971.top:82/module_data/monitor/room_list?';
    var httpClient = new HttpClient();

    String result;
//    try {
//      var request = await httpClient.getUrl(Uri.parse(url));
//      var response = await request.close();
//      if (response.statusCode == HttpStatus.OK) {
//        var json = await response.transform(utf8.decoder).join();
//        var data = jsonDecode(json);
//        result = data['origin'];
//      } else {
//        result =
//        'Error getting IP address:\nHttp status ${response.statusCode}';
//      }
//    } catch (exception) {
//      result = 'Failed getting IP address';
//    }
//
//    // If the widget was removed from the tree while the message was in flight,
//    // we want to discard the reply rather than calling setState to update our
//    // non-existent appearance.
//    if (!mounted) return;
//
//    setState(() {
//      _ipAddress = result;
//    });
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      _getRoomList();
    });
  }
}
