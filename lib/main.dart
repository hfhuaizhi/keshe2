import 'package:flutter/material.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';
import 'loading.dart';
import 'app.dart';
import 'login.dart';
import 'regist.dart';
import 'stuapp.dart';

void main() => runApp(MaterialApp(
  debugShowCheckedModeBanner: false,
  title: 'Flutter企业站实战',
  //自定义主题
  theme: mDefaultTheme,
  //添加路由
  routes: <String,WidgetBuilder>{
    "app": (BuildContext context) => App(),
    "stuapp":(BuildContext context) => StuApp(),
    "login": (BuildContext context) => Login(),
    "regist": (BuildContext context) => Regist(),
  },
  //指定加载页面
  home: LoadingPage(),

));

//自定义主题
final ThemeData mDefaultTheme = ThemeData(
  primaryColor: Colors.redAccent,
);
