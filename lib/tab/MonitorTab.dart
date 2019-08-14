import 'package:flutter/material.dart';
import 'package:homecontrol/czlibrary/CzLibrary.dart';
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
    String token= await CzLibrary.getUserData("token");
    if (token=="null") {
      CzLibrary.alert(context,"您尚未登陆", title:"提示",
          strConfirm: "去登陆页",
          confirmCallBack: (){
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
          },
        strCancel: "不想登录",
        cancelCallBack: null
      );
//      showDialog(
//          context: context,
//          builder: (_) => new AlertDialog(
//              title: new Text("提示"),
//              content: new Text("您尚未登陆"),
//              actions:<Widget>[
//                new FlatButton(child:new Text("不想登陆"), onPressed: (){
//                  Navigator.of(context).pop();
//
//                },),
//                new FlatButton(child:new Text("去登陆页"), onPressed: (){
//                  Navigator.of(context).pop();
//                  Navigator.of(context).pushReplacement(
//                    //=========
//                      new PageRouteBuilder(
//                          pageBuilder: (BuildContext context,
//                              Animation<double> animation,
//                              Animation<double> secondaryAnimation) {
//                            //页面名，加传值，需页面dart的构造函数支持
//                            return new LoginPage();
//                          })
//                    //==========
//                  );
//                },)
//              ]
//
//          ));

    }
    else{
      String token=await CzLibrary.getUserData("token");
      print("MonitorTab/token:"+token);
    }


  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      _getRoomList();
    });
  }
}
