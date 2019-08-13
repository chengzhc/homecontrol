import 'package:flutter/material.dart';
import 'package:homecontrol/page/LoginPage.dart';
import 'package:flutter/services.dart';

class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RegisterPageState();
  }
}

class RegisterPageState extends State<RegisterPage> {
  bool _isAgree = true;
  Widget title, tf_mobile, tf_passwd, btn_register, row_verifyCode, row_gotoLogin;
  final TextEditingController tf_mobileController = new TextEditingController(),
      tf_verifyCodeController = new TextEditingController(),
      tf_passwdController = new TextEditingController();
  Text txt_btnVerifyCode;

  Widget build(BuildContext context) {
    _initData();
    _initView();
    return Scaffold(
        backgroundColor: Color(0xFFFFFFFF),
        body: 
        Stack(
          children:<Widget>[
            Container(
              constraints: BoxConstraints.expand(
//                height: Theme.of(context).textTheme.display1.fontSize * 1.1 + 200.0,
              ),
              padding: const EdgeInsets.all(0.0),
              child:
              DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end:Alignment.centerRight,
                    colors: <Color>[
                      const Color(0xFFEEEEEE),
                      const Color(0xFFCCCCDD),
                    ],
                    stops: <double>[0.5, 1.0],
                  ),
                ),
              ),
            ),
            ListView(
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
                SizedBox(height: 80),
                btn_register,
              ],
            )])
    );
  }

  void _initData() {}

  void _initView() {
    title = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Expanded(
          child: Text("注册",
              textAlign: TextAlign.left,
              style: TextStyle(color: Colors.black45, fontSize: 35)),
        )
      ],
    );

    tf_mobile = Container(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: TextField(
                  controller: tf_mobileController,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.phone_android,
                        color: Colors.blueAccent,
                        size: 35.0,
                      ),

                      border: OutlineInputBorder(),
                      labelText: '手机',
                  ),
                  inputFormatters: <TextInputFormatter>[
                      WhitelistingTextInputFormatter.digitsOnly,//只输入数字
                      LengthLimitingTextInputFormatter(11)//限制长度
                  ],
            ))
          ],
        ));


    row_verifyCode = Container(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
              flex: 2,
              child: TextField(
                controller: tf_verifyCodeController,
                style: TextStyle(fontSize: 20),
                decoration: InputDecoration(
                  icon:  Icon(
                    Icons.verified_user,
                    color: Colors.blueAccent,
                    size: 35.0,
                  ),
                  border: OutlineInputBorder(),
                  labelText: '验证码',
                ),
                inputFormatters: <TextInputFormatter>[
                  WhitelistingTextInputFormatter.digitsOnly,//只输入数字
                  LengthLimitingTextInputFormatter(4)//限制长度
                ],
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
                child: Text("获取",
                    style: TextStyle(color: Colors.white, fontSize: 20)),
              ),
            ))
          ],
        ));

    tf_passwd = Container(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: TextField(
                  controller: tf_passwdController,
                  obscureText: true,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.lock,
                      color: Colors.blueAccent,
                      size: 35.0,
                    ),
                    border: OutlineInputBorder(),
                    labelText: '密码',
                  ),
            )),
          ],
        ));
    btn_register = Container(
        height: 50,
        child: Row(
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
        ));
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
            padding: EdgeInsets.symmetric(horizontal: 0, vertical: 0),
            onPressed: _showProtocol,
            child: Text(
              "《用户协议》",
              style: TextStyle(color: Colors.pinkAccent),
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
            "已有账号",
            style: TextStyle(fontSize: 18, color: Colors.blueAccent),
            textAlign: TextAlign.right,
          ),
        )
      ],
    );
  }

  @override
  void dispose() {
    // TODO: implement dispose
    tf_mobileController.dispose();
    tf_verifyCodeController.dispose();
    tf_passwdController.dispose();
    super.dispose();
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

  void _showProtocol() {
    print("showProtol");
  }
}
