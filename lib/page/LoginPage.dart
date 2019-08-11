import 'package:flutter/material.dart';
import 'package:homecontrol/page/RegisterPage.dart';

class LoginPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return LoginPageState();
  }
}

class LoginPageState extends State<LoginPage> {
  bool _isAgree = true;
  Widget title, tf_mobile, tf_passwd, btn_login,row_gotoLogin;
  TextEditingController tf_mobileController,
      tf_verifyCodeController,
      tf_passwdController;
  Text txt_btnVerifyCode;

  Widget build(BuildContext context) {
    _initData();
    _initView();
    return Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        body: Form(
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 22.0, vertical: 100.0),
              children: <Widget>[
                title,
                SizedBox(height: 60),
                tf_mobile,
                SizedBox(height: 20),
                tf_passwd,
                SizedBox(height: 10),
                row_gotoLogin,
                SizedBox(height: 40),
                SizedBox(height: 60),//row_verifyCode,
                SizedBox(height: 20),
                btn_login,
              ],
            )));
  }

  void _initData() {}

  void _initView() {
    title = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Text("登录",
              textAlign: TextAlign.left,
              style: TextStyle(color: Colors.black54, fontSize: 35)),
        )
      ],
    );
    tf_mobileController = new TextEditingController();
    tf_mobile = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
            child: TextField(
              controller: tf_mobileController,
              obscureText: false,
              style: TextStyle(fontSize: 20,),
              decoration: InputDecoration(
//                contentPadding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                border: OutlineInputBorder(),
                labelText: '手机',
              ),
            ))
      ],
    );



    tf_passwdController = new TextEditingController();
    tf_passwd = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
            child: TextField(
              controller: tf_passwdController,
              obscureText: true,
              style: TextStyle(fontSize: 20),
              decoration: InputDecoration(
                border: OutlineInputBorder(),
                labelText: '密码',
              ),
            )),
      ],
    );
    btn_login = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
            child: RaisedButton(
              color: Colors.blueAccent,
              onPressed: () {
                _login();
              },
              textColor: Colors.white,
              padding: const EdgeInsets.all(0.0),
              child: Container(
                padding: const EdgeInsets.all(10.0),
                child: const Text('登        录', style: TextStyle(fontSize: 20)),
              ),
            ))
      ],
    );
    row_gotoLogin = Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: <Widget>[

        FlatButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(new PageRouteBuilder(
                pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) {
                  return new RegisterPage();
                }));
          },
          child: Text(
            "我要注册",
            style: TextStyle(fontSize: 20, color: Colors.blueAccent),
            textAlign: TextAlign.right,
          ),
        )
      ],
    );
  }



  void _login() {
    String mobile = tf_mobileController.text;
    String passwd = tf_passwdController.text;

    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
            content:
            new Text("登陆\nmobile=" + mobile + "\npasswd=" + passwd),
            actions: <Widget>[
              new FlatButton(
                child: new Text("确定"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ]));
  }


}
