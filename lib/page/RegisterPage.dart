import 'package:flutter/material.dart';
import 'package:homecontrol/page/LoginPage.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RegisterPageState();
  }
}

class RegisterPageState extends State<RegisterPage> {
  bool _isAgree = true;
  Widget title, tf_mobile, tf_passwd, btn_login, row_verifyCode, row_gotoLogin;
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
            row_verifyCode,
            SizedBox(height: 20),
            tf_passwd,
            SizedBox(height: 10),
            row_gotoLogin,
            SizedBox(height: 40),
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
          child: Text("注册",
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
          style: TextStyle(fontSize: 20),
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: '手机',
          ),
        ))
      ],
    );

    tf_verifyCodeController = new TextEditingController();
    row_verifyCode = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: TextField(
            controller: tf_verifyCodeController,
            obscureText: false,
            style: TextStyle(fontSize: 20),
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              labelText: '验证码',
            ),
          ),
        ),
        SizedBox(width: 16),
        Expanded(
            child: Container(
          height: 60,
          child: RaisedButton(
            color: Colors.blueAccent,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(5))),
            onPressed: _getVerifyCode,
            child: Text("验证码",
                style: TextStyle(color: Colors.white, fontSize: 20)),
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
            _register();
          },
          textColor: Colors.white,
          padding: const EdgeInsets.all(0.0),
          child: Container(
            padding: const EdgeInsets.all(10.0),
            child: const Text('注        册', style: TextStyle(fontSize: 20)),
          ),
        ))
      ],
    );
    row_gotoLogin = Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(mainAxisAlignment: MainAxisAlignment.start, children: <Widget>[
          Checkbox(
            value: _isAgree,
            onChanged: (bool newValue) {
              setState(() {
                _isAgree = newValue;
                _clickCheckBox();
              });
            },
          ),
          Text("我已同意"),
          FlatButton(
            padding:EdgeInsets.symmetric(horizontal:0, vertical: 0),
            onPressed: _showProtocol,
            child: Text(
              "《用户协议》",
            style: TextStyle(
                color:Colors.pinkAccent
            ),
            ),
          )

        ]),
        FlatButton(
          onPressed: () {
            Navigator.of(context).pushReplacement(new PageRouteBuilder(
                pageBuilder: (BuildContext context, Animation<double> animation,
                    Animation<double> secondaryAnimation) {
              return new LoginPage();
            }));
          },
          child: Text(
            "直接登录",
            style: TextStyle(fontSize: 20, color: Colors.blueAccent),
            textAlign: TextAlign.right,
          ),
        )
      ],
    );
  }

  void _clickCheckBox() {
    print("_clickCheckBox");
  }

  void _getVerifyCode() {
    print("_getVerifyCode");
  }

  void _register() {
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

  void _showProtocol(){
    print("showProtol");
  }
}
