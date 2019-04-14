import 'package:flutter/material.dart';
import 'dart:async';
class NewsPage extends StatefulWidget{
  @override
  _NewsPageState createState() {
    return _NewsPageState();
  }

}
class _NewsPageState extends State<NewsPage>{
  //当前选择页面索引
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text("news")
    );
  }

}