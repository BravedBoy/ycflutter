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


import 'package:flutter/material.dart';
import 'package:ycflutter/dialog/BaseDialog.dart';
import 'package:ycflutter/res/TextStyles.dart';
import 'package:ycflutter/res/YcColors.dart';
import 'package:ycflutter/test/TestPage.dart';


/*
 * <pre>
 *     @author yangchong
 *     blog  : https://github.com/yangchong211
 *     time  : 2019/3/12
 *     desc  : 设置中心
 *     revise:
 * </pre>
 */
class SettingPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return new SettingState();
  }
}

class SettingState extends State<SettingPage> {
  @override
  Widget build(BuildContext context) {
    Widget night = initNightWidget();
    Widget pwd = initPwdWidget();
    Widget safe = initSafetyWidget();
    Widget cache = initCacheWidget();

    return new Scaffold(
      appBar: new AppBar(
        title: new Text("设置中心"),
      ),
      body: new ListView(
        //padding: EdgeInsets.zero,
        padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
        children: <Widget>[
          night,
          new Divider(),
          pwd,
          new Divider(),
          safe,
          new Divider(),
          cache,
          new Divider(),
          new ListTile(
              title: const Text('测试页面'),
              trailing:  Icon(Icons.arrow_forward, color: YcColors.colorPrimary),
              onTap: () {
                Navigator.of(context).push(new MaterialPageRoute(builder: (context){
                  return new TestPage();
                }));
              }
          ),
          new Divider(),
        ],
      ),
    );
  }


  Widget initNightWidget() {
    var listTile = new ListTile(
      title: new Text('退出登录'),
      onTap: (){
        showAlertDialog(context,'退出登录');
      },
      trailing: new Icon(Icons.arrow_forward, color: YcColors.colorIndigo10),
    );
    return listTile;
  }


  Widget initPwdWidget() {
    var listTile = new ListTile(
      title: Text("修改密码"),
      onTap: (){
        showAlertDialog(context,'修改密码');
      },
      trailing: new Icon(Icons.arrow_forward,color: YcColors.colorIndigo10,),
    );
    return listTile;
  }

  Widget initSafetyWidget() {
    var listTile = new ListTile(
      title: Text("安全设置"),
      onTap: (){
        showAlertDialog(context,'安全设置');
      },
      trailing: new Icon(Icons.arrow_forward,color: YcColors.colorIndigo10,),
    );
    return listTile;
  }

  Widget initCacheWidget() {
    var listTile = new ListTile(
      title: Text("清除缓存"),
      onTap: (){
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (BuildContext context) {
              return BaseDialog(
                hiddenTitle: true,
                height: 120.0,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: const Text("请选择是否需要App中所有的清除缓存",
                      style: TextStyles.textDark16, textAlign: TextAlign.center),
                ),
                onPressed: (){

                },
              );
            }
        );
      },
      trailing: new Icon(Icons.arrow_forward,color: YcColors.colorIndigo10,),
    );
    return listTile;
  }


  ///展示弹窗
  void showAlertDialog(BuildContext context , String title) {
    showDialog<Null>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text(title),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: <Widget>[
                new Text('请选择是否需要'+title,style: new TextStyle(
                    color: YcColors.colorRed,fontSize: 16),),
              ],
            ),
          ),
          actions: <Widget>[
            new FlatButton(
              child: new Text('取消'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text('确定'),
              onPressed: () {
                Navigator.of(context).pop();
                switch(title){
                  case '退出登录':

                    break;
                  case '修改密码':

                    break;
                  case '安全设置':

                    break;
                  case '清除缓存':

                    break;
                }
              },
            ),
          ],
        );
      },
    );
  }

}



