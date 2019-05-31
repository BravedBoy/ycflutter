/*
Copyright 2017 yangchong211（github.com/yangchong211）

Licensed under the Apache License, Version 2.0 (the "License");
you may not use this file except in compliance with the License.
You may obtain a copy of the License at

http://www.apache.org/licenses/LICENSE-2.0

Unless required by applicable law or agreed to in writing, software
distributed under the License is distributed on an "AS IS" BASIS,
WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
See the License for the specific language governing permissions and
limitations under the License.
*/



import 'dart:convert';
import 'package:ycflutter/api/AndroidApi.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ycflutter/utils/ToastUtils.dart';

/*
 * <pre>
 *     @author yangchong
 *     blog  : https://github.com/yangchong211
 *     time  : 2018/9/12
 *     desc  : 网络请求工具类
 *     revise:
 * </pre>
 */
class HttpUtils{

  static const String GET = "get";
  static const String POST = "post";

  //get请求
  static void get(String url, Function callback, {Map<String, String> params,
        Map<String, String> headers, Function errorCallback}) async {
    if (!url.startsWith("http")) {
      url = AndroidApi.BaseUrl + url;
    }

    //做非空判断
    if (params != null && params.isNotEmpty) {
      StringBuffer sb = new StringBuffer("?");
      params.forEach((key, value) {
        sb.write("$key" + "=" + "$value" + "&");
      });
      String paramStr = sb.toString();
      paramStr = paramStr.substring(0, paramStr.length - 1);
      url += paramStr;
      ToastUtils.showPrint(url);
    }
    await startRequest(url, callback, method: GET, headers: headers,
        errorCallback: errorCallback);
  }


  //post请求
  static void post(String url, Function callback, {Map<String, String> params,
    Map<String, String> headers, Function errorCallback}) async {
    if (!url.startsWith("http")) {
      url = AndroidApi.BaseUrl + url;
    }
    await startRequest(url, callback, method: POST,
        headers: headers, params: params, errorCallback: errorCallback);
  }


  //开始网络请求
  static Future startRequest(String url, Function callback, {String method,
    Map<String, String> headers, Map<String, String> params,
        Function errorCallback}) async {
    String errorMsg;
    int errorCode;
    var data;
    try {
      Map<String, String> headerMap = headers == null ? new Map() : headers;
      Map<String, String> paramMap = params == null ? new Map() : params;
      //添加cookie
      //关于cookie，token详细介绍看我这篇博客：https://github.com/yangchong211/YCBlogs/blob/master/android/%E7%BD%91%E7%BB%9C%E7%9B%B8%E5%85%B3/06.Cookie%E3%80%81Session%E3%80%81Token%E7%AC%94%E8%AE%B0%E6%95%B4%E7%90%86.md
      SharedPreferences sp = await SharedPreferences.getInstance();
      String cookie = sp.get("cookie");
      if(cookie==null || cookie.length==0){
      }else{
        headerMap['Cookie'] = cookie;
      }
      http.Response res;
      if (POST == method) {
        ToastUtils.showPrint("POST:URL="+url);
        ToastUtils.showPrint("POST:BODY="+paramMap.toString());
        res = await http.post(url, headers: headerMap, body: paramMap);
      } else {
        ToastUtils.showPrint("GET:URL="+url);
        res = await http.get(url, headers: headerMap);
      }

      if (res.statusCode != 200) {
        errorMsg = "网络请求错误,状态码:" + res.statusCode.toString();
        handError(errorCallback, errorMsg);
        return;
      }

      //以下部分可以根据自己业务需求封装,这里是errorCode>=0则为请求成功,data里的是数据部分
      //记得Map中的泛型为dynamic
      Map<String, dynamic> map = json.decode(res.body);

      errorCode = map['errorCode'];
      errorMsg = map['errorMsg'];
      data = map['data'];

      if(url.contains(AndroidApi.LOGIN)){
        SharedPreferences sp = await SharedPreferences.getInstance();
        sp.setString("cookie", res.headers['set-cookie']);
      }
      //callback返回data,数据类型为dynamic
      //errorCallback中为了方便我直接返回了String类型的errorMsg
      if (callback != null) {
        if (errorCode >= 0) {
          callback(data);
        } else {
          handError(errorCallback, errorMsg);
        }
      }
    } catch (exception) {
      handError(errorCallback, exception.toString());
    }
  }

  static void handError(Function errorCallback,String errorMsg){
    if (errorCallback != null) {
      errorCallback(errorMsg);
    }
    ToastUtils.showPrint("errorMsg :"+errorMsg);
  }

}



