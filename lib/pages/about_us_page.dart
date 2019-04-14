import 'package:flutter/material.dart';
import 'dart:async';
class AboutUsPage extends StatefulWidget{
  @override
  _AboutUsPageState createState() {
    return _AboutUsPageState();
  }

}
class _AboutUsPageState extends State<AboutUsPage>{
  //当前选择页面索引
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text("aboutus")
    );
  }

}