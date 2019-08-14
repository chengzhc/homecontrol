import 'package:flutter/material.dart';
import 'package:homecontrol/page/LoginPage.dart';
import 'package:homecontrol/MainPage.dart';
import 'package:flutter/services.dart';
import 'package:homecontrol/czlibrary/CzLibrary.dart';
import 'dart:io';
import 'dart:async';
import 'package:homecontrol/czlibrary/Cz_HTTP.dart';

import 'package:homecontrol/constant.dart';


class RegisterPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return RegisterPageState();
  }
}

class RegisterPageState extends State<RegisterPage> {
  static final int MAX_COUNT_DOWN=30;
  bool _isAgree = true;
  Widget title, tf_mobile, tf_passwd,tf_repasswd, btn_register, row_verifyCode, row_gotoLogin;
  final TextEditingController tf_mobileController = new TextEditingController(),
      tf_verifyCodeController = new TextEditingController(),
      tf_passwdController = new TextEditingController(),
      tf_repasswdController = new TextEditingController();
  Text txt_btnVerifyCode;

  String str_btnVerifyCode="获取";

  var httpClient = new HttpClient();

  int currentCountDown=0;
  Timer _countdownTimer;

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
                SizedBox(height: 20),
                tf_repasswd,
                SizedBox(height: 10),
                row_gotoLogin,
                SizedBox(height: 60),
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
                  icon:  Icon(
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
              ),
            ),
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
                child: Text("$str_btnVerifyCode",
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
                      Icons.lock_outline,
                      color: Colors.blueAccent,
                      size: 35.0,
                    ),
                    border: OutlineInputBorder(),
                    labelText: '密码',
                  ),
            )),
          ],
        ));
    tf_repasswd = Container(
        height: 50,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
                child: TextField(
                  controller: tf_repasswdController,
                  obscureText: true,
                  style: TextStyle(fontSize: 20),
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.lock,
                      color: Colors.blueAccent,
                      size: 35.0,
                    ),
                    border: OutlineInputBorder(),
                    labelText: '重复密码',
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

  bool _isCountDown(){
    return currentCountDown>0;
  }

  void startCountDown() async {
    currentCountDown=MAX_COUNT_DOWN;


      print("countDown=$currentCountDown");
      Timer.periodic(new Duration(seconds: 1), (timer)
      {
        setState(() {
          if (currentCountDown > 0) {
            str_btnVerifyCode = '${currentCountDown--}';
          } else {
            str_btnVerifyCode = '获取';
            timer.cancel();
            timer = null;
          }
        });
      });

  }

  void _getVerifyCode() async  {
    print("_getVerifyCode");

    if(_isCountDown()){
      CzLibrary.alert(context, "验证码发送中，请稍后再试");
      return;
    }

    startCountDown();

    var url = Constant.DOMAIN+"/module_data/monitor/get_verify_code?mobile="+tf_mobileController.text;
    Cz_HTTP.czRequest(url,"post",
          (var feedBackData) {
//            print("czPostSuccess: "+feedBackData["data"].toString())
            CzLibrary.saveUserData("verify_token", feedBackData["data"].toString());
            CzLibrary.alert(context, "验证码已通过短信发送，请注意查收");
            currentCountDown=0;
          },
          (var feedBackData){
            print("czPostFail: "+feedBackData["err_info"].toString());
            CzLibrary.alert(context,feedBackData["err_info"].toString());
            currentCountDown=0;
          },);
  }

  void _register() async {
    String mobile = tf_mobileController.text;
    String code=tf_verifyCodeController.text;
    String password = tf_passwdController.text;
    String repassword = tf_repasswdController.text;
    String verify_token= await CzLibrary.getUserData("verify_token");

    String url=Constant.DOMAIN+"/module_data/monitor/register?"
        +"mobile="+mobile
        +"&code="+code
        +"&password="+password
        +"&repassword="+repassword
        +"&verify_token="+verify_token;

    Cz_HTTP.czRequest(url, "post",
        (var feedBackData){
          CzLibrary.saveUserData("token", feedBackData["data"]);
          Navigator.of(context).pushReplacement(new PageRouteBuilder(pageBuilder:
              (BuildContext context, Animation<double> animation,
              Animation<double> secondaryAnimation) {
            return new MainPage("some attrs you like ");
          }));
        },
        (var feedBackData){
          CzLibrary.alert(context,feedBackData["err_info"].toString(),strConfirm:"确定");
        });
  }

  void _showProtocol() {
    print("showProtol");
  }
}
