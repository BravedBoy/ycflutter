

import 'package:flutter/material.dart';

class ListLoadMore extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return new ListLoadMoreState();
  }
}

class ListLoadMoreState extends State<ListLoadMore>{

  List list = new List();
  ScrollController scrollController = ScrollController();
  int page = 1; //加载的页数
  bool isLoading = false; //是否正在加载数据

  @override
  void initState() {
    super.initState();
    getData();
    scrollController.addListener(() {
      if (scrollController.position.pixels == scrollController.position.maxScrollExtent) {
        print('滑动到了最底部');
        getMore();
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    scrollController.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("list页面上拉加载更多"),
      ),
      body: ListView.builder(
        itemBuilder: renderRow,
        itemCount: list.length + 1,
        controller: scrollController,
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Widget renderRow(BuildContext context, int index) {
    if (index < list.length) {
      return ListTile(
        title: Text(list[index]),
      );
    }
    return getMoreWidget();
  }

  Widget getMoreWidget() {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(10.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            new Text('加载中...',
              style: TextStyle(fontSize: 16.0),
            ),
            new CircularProgressIndicator(
              strokeWidth: 1.0,
            )
          ],
        ),
      ),
    );
  }


  Future getData() async {
    await Future.delayed(Duration(seconds: 2), () {
      setState(() {
        list = List.generate(15, (i) => '哈喽,我是小杨逗比 $i');
      });
    });
  }

  Future getMore() async {
    if (!isLoading) {
      setState(() {
        isLoading = true;
      });
      await Future.delayed(Duration(seconds: 1), () {
        print('加载更多');
        setState(() {
          list.addAll(List.generate(10, (i) => '第$page次上拉数据小杨逗比 $i'));
          page++;
          isLoading = false;
        });
      });
    }
  }

}

