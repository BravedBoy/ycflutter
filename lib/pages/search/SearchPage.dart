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
import 'package:ycflutter/pages/search/HotFriendPage.dart';
import 'package:ycflutter/pages/search/SearchListPage.dart';
import 'package:ycflutter/res/YcColors.dart';
import 'package:ycflutter/utils/LogUtils.dart';


/*
 * <pre>
 *     @author yangchong
 *     blog  : https://github.com/yangchong211
 *     time  : 2018/11/18
 *     desc  : 搜索页面
 *     revise:
 * </pre>
 */
class SearchPage extends  StatefulWidget{

  String search;
  SearchPage(searchStr){
    this.search = searchStr;
  }

  @override
  State<StatefulWidget> createState() {
    return new SearchState(search);
  }

}

class SearchState extends State<SearchPage> {

  TextEditingController searchController = new TextEditingController();
  SearchListPage searchListPage;
  String search ;

  SearchState(String search){
    this.search = search;
  }

  @override
  Widget build(BuildContext context) {
    TextField searchField = initSearchText();
    bool a = searchController.text==null||searchController.text.isEmpty;
    return new Scaffold(
      appBar: new AppBar(
        title: searchField,
        actions: <Widget>[
          new IconButton(
              icon: new Icon(Icons.search),
              onPressed: () {
                changeContent();
              }),
          new IconButton(
              icon: new Icon(Icons.close),
              onPressed: () {
                setState(() {
                  searchController.clear();
                });
              }),
        ],
      ),
      body: (a)?
      new Center(
        //热门事件
        child : new HotFriendPage(),
      ):searchListPage,
    );
  }

  @override
  void initState() {
    super.initState();
    searchController = new TextEditingController(text: search);
    changeContent();
  }

  //改变内容
  void changeContent() {
    setState(() {
      //获取搜索的内容
      var text = searchController.text;
      searchListPage = new SearchListPage(new ValueKey(text));
    });
  }

  TextField initSearchText() {
    TextField searchText = new TextField(
      autofocus: true,
      cursorColor: YcColors.colorRed,
      //最大长度，设置此项会让TextField右下角有一个输入数量的统计字符串
      maxLength: 10,
      //输入文本的样式
      style: TextStyle(fontSize: 16.0, color: YcColors.colorWhite),
      decoration: new InputDecoration(
        border: InputBorder.none,
        fillColor: YcColors.colorWhite,
        hintText: '逗比，请输入搜索关键词',
      ),
      controller: searchController,
      //内容改变的回调
      /*onChanged: (text) {
        LogUtils.showPrint('change $text');
      },*/
      //内容提交(按回车)的回调
      /*onSubmitted: (text) {
        LogUtils.showPrint('submit $text');
      },*/
    );
    return searchText;
  }

}