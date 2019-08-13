import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:homecontrol/MainPage.dart';

class SplashPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _SplashPageState();
  }
}

class _SplashPageState extends State<SplashPage> {
  @override
  Widget build(BuildContext context) {
    return new Image.asset(
      "images/home_control.jpg",
      fit: BoxFit.cover,);
  }

  @override
  void initState() {
    super.initState();
    countDown();
  }

// 倒计时
  void countDown() {
    var _duration = new Duration(seconds: 3);
    new Future.delayed(_duration, go2HomePage);
  }

  void go2HomePage() {
    print("go2HomePage");
    Navigator.of(context).pushReplacement(new PageRouteBuilder(pageBuilder:
        (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
      return new MainPage("some attrs you like ");
    }));
  }
}
