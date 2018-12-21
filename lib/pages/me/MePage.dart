//import 'package:flutter/widgets.dart';
//import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ycflutter/pages/detail/ArticleDetailPage.dart';
import 'package:ycflutter/pages/me/AboutMePage.dart';
import 'package:ycflutter/pages/me/MeCollectPage.dart';
import 'package:ycflutter/pages/me/LoginPage.dart';
import 'package:ycflutter/res/YcColors.dart';
import 'package:ycflutter/utils/UserUtils.dart';
import 'package:ycflutter/weight/ItemLine.dart';


/*
 * <pre>
 *     @author yangchong
 *     blog  : https://github.com/yangchong211
 *     time  : 2018/9/12
 *     desc  : 我的页面
 *     revise:
 * </pre>
 */
class MePage extends  StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new MeState();
  }
}


class MeState extends State<MePage> {

  String userName;
  String logo;

  @override
  Widget build(BuildContext context) {
    Widget image = initImage();
    Widget listLogin = initLoginWidget();
    var itemLine1 = new ItemLine();
    Widget listAbout = initAboutWidget();
    var itemLine2 = new ItemLine();
    Widget listLogout = initLogoutWidget();
    var itemLine3 = new ItemLine();
    Widget listCollect = initCollectWidget();
    var itemLine4 = new ItemLine();
    Widget listGit = initGitWidget();
    Widget listBlog = initBlogWidget();
    Widget listSetting = initSettingWidget();
    //将上面创建的view添加到布局中
    return new ListView(
      padding: const EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
      children: <Widget>[
        image,
        listLogin,
        itemLine1,
        listAbout,
        itemLine2,
        listLogout,
        itemLine3,
        listCollect,
        itemLine4,
        listGit,
        listBlog,
        listSetting,
      ],
    );
  }

  @override
  void initState() {
    super.initState();
    getName();
  }

  Widget initImage() {
    logo = 'lib/image/ic_launcher_round.png';
    Widget image = new Image.asset(
      logo,
      width: 60.0,
      height: 60.0,
    );
    Row row = new Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Expanded(
            child: new Row(
              children: <Widget>[
                new Text('状态:  '),
                new Text(
                  userName,
                  style: new TextStyle(color: YcColors.colorRed),
                ),
              ],
            )),
      ],
    );
    Column column = new Column(
      children: <Widget>[
        new Padding(
          padding: EdgeInsets.all(10.0),
          child: image,
        ),
        new Padding(
          padding: EdgeInsets.fromLTRB(10.0, 5.0, 10.0, 5.0),
          child: row,
        ),
      ],
    );
    Card card = new Card(
      elevation: 2.0,
      child: new InkWell(
        child: column,
      ),
    );
    return card;
  }

  //登陆
  Widget initLoginWidget() {
    Widget layout = new ListTile(
        leading: const Icon(Icons.label_important),
        title: const Text('开始登陆'),
        trailing:  Icon(Icons.arrow_forward, color: YcColors.colorPrimary),
        onTap: () {
          Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
            return new LoginPage();
          }));
        });
    return layout;
  }

  //关于我们
  Widget initAboutWidget() {
    Widget layout = new ListTile(
        leading: const Icon(Icons.info),
        title: const Text('关于更多信息'),
        trailing:  Icon(Icons.arrow_forward, color: YcColors.colorPrimary),
        onTap: () {
          Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
            return new AboutMePage();
          }));
        });
    return layout;
  }

  //推出登陆
  Widget initLogoutWidget() {
    Widget layout = new ListTile(
        leading: const Icon(Icons.account_balance_wallet),
        title: const Text('退出登录'),
        trailing:  Icon(Icons.arrow_forward, color: YcColors.colorPrimary),
        onTap: () async {
          startLogout();
        });
    return layout;
  }

  Widget initCollectWidget() {
    Widget layout = new ListTile(
        leading: const Icon(Icons.collections),
        title: const Text('我的收藏'),
        trailing:  Icon(Icons.arrow_forward, color: YcColors.colorPrimary),
        onTap: () async {
          UserUtils.isLogin().then((isLogin) {
            if (!isLogin) {
              //没有登陆
              print('没有登陆');
            } else {
              //已经登陆
              Navigator.of(context).push(new MaterialPageRoute(builder: (context) {
                return new CollectPage();
              }));
            }
          });
        });
    return layout;
  }


  Widget initGitWidget() {
    Widget layout = new ListTile(
        leading: const Icon(Icons.crop_original),
        title: const Text('我的GitHub'),
        trailing:  Icon(Icons.arrow_forward, color: YcColors.colorPrimary),
        onTap: () async {
          Navigator
              .of(context)
              .push(new MaterialPageRoute(builder: (context) {
            return new ArticleDetailPage(
              title: '潇湘剑雨',
              url: 'https://github.com/yangchong211',
            );
          }));
        });
    return layout;
  }

  // 处使化我的博客条目控件
  Widget initBlogWidget() {
    Widget layout = new ListTile(
        leading: const Icon(Icons.ac_unit),
        title: const Text('我的Blog总结'),
        trailing:  Icon(Icons.arrow_forward, color: YcColors.colorPrimary),
        onTap: () {
          Navigator
              .of(context)
              .push(new MaterialPageRoute(builder: (context) {
            return new ArticleDetailPage(
              title: '博客大汇总',
              url: 'https://github.com/yangchong211',
            );
          }));
        });
    return layout;
  }

  // 设置中心
  Widget initSettingWidget() {
    Widget layout = new ListTile(
        leading: const Icon(Icons.settings),
        title: const Text('设置中心'),
        trailing:  Icon(Icons.arrow_forward, color: YcColors.colorPrimary),
        onTap: () {
          //设置中心
        });
    return layout;
  }

  //开始推出登陆
  void startLogout() {
    UserUtils.clearLoginInfo();
    setState(() {
      userName = "未登陆状态";
    });
  }

  void getName() {
    UserUtils.isLogin().then((isLogin) {
      if (!isLogin) {
        //没有登陆
        print('没有登陆');
        userName = "未登陆状态";
        logo = 'lib/image/ic_launcher_round.png';
      } else {
        //已经登陆
        UserUtils.getUserName().then((username) {
          setState(() {
            logo = 'lib/image/ic_person.jpg';
            userName = "已登陆状态" + username;
            print('name:' + userName.toString());
          });
        });
      }
    });
  }


}