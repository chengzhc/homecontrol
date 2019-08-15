import 'package:flutter/material.dart';
import 'package:homecontrol/czlibrary/CzLibrary.dart';

class ProtocolPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return ProtocolPageState();
  }
}

class ProtocolPageState extends State<ProtocolPage>{
  String str_protocol;

   Widget build(BuildContext context){
     _initData();
     _initView();

     return Scaffold(
         backgroundColor: Color(0xFFFFFFFF),
         appBar:  AppBar(
           title: const Text('用户协议'),
//           actions: <Widget>[
//             FlatButton(onPressed: (){CzLibrary.alert(context, "ACT1");},child: Text("ACT1"),),
//             FlatButton(onPressed: (){CzLibrary.alert(context, "ACT2");},child: Text("ACT2"),),
//           ],
         ),
         body: Stack(
           children: <Widget>[
              Text("${str_protocol}")
           ],
         )
     );
   }

   void _initData(){

   }

  void _initView(){
  }

  @override
  void initState(){
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      _showProtocol();
    });
  }

  void _showProtocol(){
     setState((){
       str_protocol="用户协议 \n\r"
            +"条款一：\n\r"
           + "条款二：\n\r"
          +"2019/08/15" ;
     });
  }

}
