import 'package:flutter/material.dart';
import 'package:homecontrol/SplashPage.dart';
import 'package:homecontrol/MainPage.dart';

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashPage(), //启动MainPage
    );
  }
}
