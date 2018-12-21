

import 'package:flutter/material.dart';
import 'package:ycflutter/api/AndroidApi.dart';
import 'package:ycflutter/api/HttpUtils.dart';
import 'package:ycflutter/pages/detail/ArticleDetailPage.dart';
import 'package:ycflutter/pages/me/LoginPage.dart';
import 'package:ycflutter/res/YcColors.dart';
import 'package:ycflutter/utils/StringUtils.dart';
import 'package:ycflutter/utils/UserUtils.dart';

/*
 * <pre>
 *     @author yangchong
 *     blog  : https://github.com/yangchong211
 *     time  : 2018/9/12
 *     desc  : 新闻item条目控件
 *     revise:
 * </pre>
 */
class ArticleItem extends StatefulWidget{

  //条目的数据data
  var itemData;
  //是否来自搜索列表
  bool isSearch;
  //搜索数据需要用到id
  var id ;

  //构造方法
  ArticleItem(itemData){
    this.itemData = itemData;
    this.isSearch =false;
  }

  //命名构造函数,搜索列表的item和普通的item有些不一样
  ArticleItem.isFromSearch(var itemData, String id) {
    this.itemData = itemData;
    this.isSearch = true;
    this.id = id;
  }

  @override
  State<StatefulWidget> createState() {
    return new ArticleView();
  }
}

class ArticleView  extends State<ArticleItem> {
  @override
  Widget build(BuildContext context) {
    //是否收藏
    bool isCollect = widget.itemData["collect"];

    Row row1 = initRowView1(isCollect);
    Row content = initRowContent();
    Row row2 = initRowView2();
    Column column = initColumn(row1,content,row2);
    return new Card(
      elevation: 4.0,
      child: new InkWell(
        child: column,
        onTap: () {
          //条目点击事件
          onItemClick(widget.itemData);
        },
      ),
    );
  }

  Row initRowView1(bool isCollect) {
    String author = widget.itemData['author'];
    Row row = new Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        new Expanded(
            child: new Row(
              children: <Widget>[
                new Text('作者:  '),
                new Text(
                  author,
                  style: new TextStyle(color: YcColors.colorRed),
                ),
              ],
            )),
        new GestureDetector(
          child: new Icon(
            isCollect ? Icons.favorite : Icons.favorite_border,
            color: isCollect ? YcColors.colorRed : null,
          ),
          onTap: () {
            //收藏点击事件
            onCollectClick(widget.itemData);
          },
        ),
        //分割间距
        new Padding(
          padding: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
        ),
        new GestureDetector(
          child: new Icon(
            Icons.share , color: YcColors.colorPrimary ,
          ),
          onTap: () {
            //分享点击事件
            onShareClick(widget.itemData);
          },
        ),
      ],
    );
    return row;
  }

  Row initRowContent() {
    Row content = new Row(
      children: <Widget>[
        new Expanded(
          child: new Text.rich(
            widget.isSearch
                ? StringUtils.getTextSpan(widget.itemData['title'], widget.id)
                : new TextSpan(text: widget.itemData['title']),
            softWrap: true,
            style: new TextStyle(fontSize: 16.0, color: YcColors.colorPrimary),
            textAlign: TextAlign.left,
          ),
        )
      ],
    );
    return content;
  }

  Row initRowView2() {
    var date = widget.itemData['niceDate'];
    String time = '发布时间：'+date;
    var chapterName = widget.itemData['chapterName'];
    var superChapterName = widget.itemData['superChapterName'];
    String author = superChapterName + "/" + chapterName;
    Row row = new Row(
      children: <Widget>[
        new Text('分类：'),
        new Expanded(
          child: new Text(
            widget.isSearch ? '' : author,
            softWrap: true,
            style: new TextStyle(color: YcColors.colorIndigo10),
            textAlign: TextAlign.left,
            maxLines: 1,
          ),
        ),
        new Text(time)
      ],
    );
    return row;
  }

  Column initColumn(Row row1, Row content, Row row2) {
    Column column = new Column(
      children: <Widget>[
        new Padding(
          padding: EdgeInsets.all(10.0),
          child: row1,
        ),
        new Padding(
          padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
          child: content,
        ),
        new Padding(
          padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 10.0),
          child: row2,
        ),
      ],
    );
    return column;
  }

  //条目点击事件
  //更多查看：https://github.com/yangchong211/YCBlogs
  void onItemClick(itemData) async {
    await Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new ArticleDetailPage(
        title: itemData['title'],
        url: itemData['link'],
      );
    }));
  }

  //收藏点击事件
  //更多查看：https://github.com/yangchong211/YCBlogs
  void onCollectClick(itemData) {
    UserUtils.isLogin().then((isLogin) {
      if (!isLogin) {
        startLogin();
      } else {
        collectItem(itemData);
      }
    });
  }

  //开始登陆，跳转登陆的页面
  void startLogin() {
    Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
      return new LoginPage();
    }));
  }

  //收藏或者取消收藏
  void collectItem(itemData) {
    String url;
    if (itemData['collect']) {
      url = AndroidApi.UN_COLLECT_ORIGIN;
    } else {
      url = AndroidApi.COLLECT;
    }
    url += '${itemData["id"]}/json';
    HttpUtils.post(url, (data) {
      setState(() {
        itemData['collect'] = !itemData['collect'];
      });
    });
  }

  //开始分享
  void onShareClick(itemData) {

  }
}
