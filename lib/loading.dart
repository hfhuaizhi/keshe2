import 'package:flutter/material.dart';
import 'dart:async';
import 'utils/SpUtil.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'conf/GlobalValue.dart';

class LoadingPage extends StatefulWidget{
  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<LoadingPage>{
  
  @override
  void initState(){
    super.initState();
    //在加载页面停顿3秒
    Future.delayed(Duration(seconds: 3),(){
      Future<String> username =  getString(GlobalValue.USERNAME);
      username.then((String tmp){
        if(tmp!=null&&tmp.length>1){
          Future<String> tag =  getString(GlobalValue.USERTAG);
          tag.then((tagstr){
            if(tagstr==GlobalValue.USERTAG){
            _gotoMainPager(context);
          }else{
             _gotoStuPager(context);
            }
          });
        }else{
          _godoLogin(context);
        }
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

  void _gotoStuPager(BuildContext context) {
    Navigator.of(context).pushReplacementNamed("stuapp");
  }
  
}

void _godoLogin(BuildContext context) {
  Navigator.pushReplacementNamed(context, "login");
}

void _gotoMainPager(BuildContext context) {
  Navigator.of(context).pushReplacementNamed("app");

}