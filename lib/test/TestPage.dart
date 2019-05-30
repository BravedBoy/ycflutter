

import 'package:flutter/material.dart';
import 'package:ycflutter/res/YcColors.dart';
import 'package:ycflutter/test/ListLoadMore.dart';
import 'package:ycflutter/test/ListMore.dart';
import 'package:ycflutter/test/ListRefreshMore.dart';
import 'package:ycflutter/test/TestList.dart';

class TestPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new TestPageState();
  }

}

class TestPageState extends State<TestPage>{
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text('测试的案例代码'),
      ),
      body: new ListView(
        padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
        children: <Widget>[
          new ListTile(
              title: const Text('list页面'),
              trailing:  Icon(Icons.arrow_forward, color: YcColors.colorPrimary),
              onTap: () {
                Navigator.of(context).push(new MaterialPageRoute(builder: (context){
                  return new TestList();
                }));
              }
          ),
          new Divider(),
          new ListTile(
            title: const Text("list页面上拉加载更多"),
            trailing:  Icon(Icons.arrow_forward, color: YcColors.colorPrimary),
            onTap: (){
              Navigator.of(context).push(new MaterialPageRoute(builder: (context){
                return new ListLoadMore();
              }));
            },
          ),
          new Divider(),
          new ListTile(
            title: new Text("list页面下拉刷新全部数据"),
            trailing:  Icon(Icons.arrow_forward, color: YcColors.colorPrimary),
            onTap: (){
              Navigator.of(context).push(new MaterialPageRoute(builder: (context){
                return new ListRefreshMore();
              }));
            },
          ),
          new Divider(),
          new ListTile(
            title: new Text("list页面上拉加载下拉刷新"),
            trailing:  Icon(Icons.arrow_forward, color: YcColors.colorPrimary),
            onTap: (){
              Navigator.of(context).push(new MaterialPageRoute(builder: (context){
                return new ListMore();
              }));
            },
          ),
          new Divider(),
        ],
      ),
    );
  }

}

