import 'dart:convert';
import 'dart:io';


class Cz_HTTP {

  /**
   *  var url = Constant.DOMAIN+"/module_data/monitor/get_verify_code?mobile="+tf_mobileController.text;
      Cz_HTTP.czRequest(url,
        "post",
        (var feedBackData)=>{
        print("czPostSuccess: "+feedBackData["data"].toString())
        },
        (var feedBackData)=>{
        print("czPostFail: "+feedBackData["err_info"].toString())
        },
      );
   */
  static void czRequest (String url,String method,var successCallBack,var failCallBack) async {
    var httpClient = new HttpClient();
    try {
      var request;
      if (method.toLowerCase()=="post") {
        request = await httpClient.postUrl(Uri.parse(url));
      }else{
        request = await httpClient.getUrl(Uri.parse(url));
      }

      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        var json = await response.transform(utf8.decoder).join();
        print(json);
        var data = jsonDecode(json);
        if(data['success']=="1"){
          successCallBack(data);
        }else{
          failCallBack(data);
        }

      } else {
        var data;
        data["success"]="0";
        data["err_info"]="请求失败，CODE="+response.statusCode.toString();
        failCallBack(data);
      }
    } catch (exception) {
      var data=json.decode('{"success":"0","err_info":"连接异常:,'+exception.toString()+'"}');
      failCallBack(data);
    }
  }

  /**
   *  var url = Constant.DOMAIN+"/module_data/monitor/get_verify_code?mobile="+tf_mobileController.text;
      Cz_HTTP.czRequest(url,
      "post",
      (var feedBackData)=>{
      print("czPostSuccess: "+feedBackData.toString());
      },
      (var code,var info)=>{
      print("czPostFail: code="+code.toString()+", info="+info.toString());
      },
      );
   */
  static void request (String url,String method,var successCallBack,var failCallBack) async {
    var httpClient = new HttpClient();
    try {
      var request = await httpClient.postUrl(Uri.parse(url));
      var response = await request.close();
      if (response.statusCode == HttpStatus.ok) {
        var json = await response.transform(utf8.decoder).join();
        print(json);
        var data = jsonDecode(json);
        successCallBack(data);
      } else {
        failCallBack(response.statusCode,"");
      }
    } catch (exception) {
      var data=json.decode('{"success":"0","err_info":"连接异常:,'+exception.toString()+'"}');
      failCallBack(-1,"连接异常:"+exception.toString());
    }
  }

}