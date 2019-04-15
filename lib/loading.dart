import 'package:flutter/material.dart';
import 'dart:async';
import 'utils/SpUtil.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LoadingPage extends StatefulWidget{
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<LoadingPage>{
  
  @override
  void initState(){
    super.initState();
    //在加载页面停顿3秒
    setString('username', 'hfhuaizhi');
    Future.delayed(Duration(seconds: 3),(){

      Navigator.of(context).pushReplacementNamed("app");
      Future<String> username =  getString('username');
      username.then((String tmp){
        print(tmp);
      });

    });

  }
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Center(
        child: Stack(
          children: <Widget>[
            //加载页面背景图
            Image.asset(
              'assets/images/loading.jpg'
            ),

            Center(
              child: Text(
                'Flutterkeshe2',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 36.0,
                  decoration: TextDecoration.none
                ),
              ),
            ),
          ],
        ),
      ),
    );
    
  }
  
}