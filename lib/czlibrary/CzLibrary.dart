import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CzLibrary{

  static Future<bool> saveUserData(String key,String value) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString(key,value);
  }

  /**
   * String token= await CzLibrary.getUserData("token");
      if (token=="null") {/*no data*/}else{/*have data*/}
   */
  static Future<String> getUserData(String key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return  prefs.getString(key).toString();
  }

  static Future<bool> removeUserData(String key) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.remove(key);
  }

  /**
   * 最简写法(只有确定键，无点击功能)
   * CzLibrary.alert(context, "验证码发送中，请稍后再试");
   *
   * 复杂写法
   * CzLibrary.alert(context,"您尚未登陆", title:"提示",
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
   */

  static void alert(var context,String content,{String title,String strConfirm,var confirmCallBack,String strCancel,cancelCallBack}){
    showDialog(
        context: context,
        builder: (_) => new AlertDialog(
            title: new Text(title==null?"":title),
            content:Text(content),
            actions: <Widget>[
              new FlatButton(
                child: new Text(strCancel==null?"":strCancel),
                onPressed: () {
                  Navigator.of(context).pop();
                  if(cancelCallBack!=null){
                    cancelCallBack();
                  }
                },
              ),
              new FlatButton(
                child: new Text(strConfirm==null?"确定":strConfirm),
                onPressed: () {
                  Navigator.of(context).pop();
                  if(confirmCallBack!=null){
                    confirmCallBack();
                  }
                },
              ),
            ]));
  }
}