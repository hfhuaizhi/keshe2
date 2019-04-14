import 'package:flutter/material.dart';
import 'dart:async';
import 'app.dart';
class LoadingPage extends StatefulWidget{
  @override
   _LoadingState createState() {
   return _LoadingState();
  }

}
class _LoadingState extends State<LoadingPage>{
  @override
  void initState() {
    super.initState();
    //在加载页面停顿3秒
    Future.delayed(Duration(seconds: 2),(){
      print('flutterkeshe 启动');
      Navigator.of(context).pushReplacementNamed("app");
    });
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Stack(
        children: <Widget>[
          Image.asset('assets/images/loading.jpg'),
          Center(
            child: Text('flutterkeshe',
              style: TextStyle(
                color: Colors.white,
                fontSize: 36.0,
                decoration: TextDecoration.none
              ),
            ),
          )
        ],
      ),
    );
  }

}