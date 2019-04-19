import 'package:flutter/material.dart';
import 'pages/about_us_page.dart';
import 'pages/home_page.dart';
import 'pages/students_page.dart';
import 'pages/product_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'pages/search_page.dart';
class App extends StatefulWidget {
  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  //当前选择页面索引
  var _currentIndex = 0;

  HomePage homePage;

  ProductPage productPage;

  NewsPage newsPage;

  AboutUsPage aboutUsPage;

  //根据当前索引返回不同的页面
  currentPage(){
    switch(_currentIndex){
      case 0:
        if(homePage == null){
          homePage = HomePage();
        }
        return homePage;
      case 1:
        if(productPage == null){
          productPage = ProductPage();
        }
        return productPage;

      case 2:
        if(newsPage == null){
          newsPage = NewsPage();
        }
        return newsPage;
      case 3:
        if(aboutUsPage == null){
          aboutUsPage = AboutUsPage();
        }
        return aboutUsPage;

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutterkeshe'),
        leading: Icon(Icons.home),
        actions: <Widget>[
          //右侧内边距
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                Fluttertoast.showToast(msg: "当前页面$_currentIndex");
                Navigator.push(context, MaterialPageRoute(builder: (context){
                  return SearchPage();
                }));
              },
              child: Icon(
                Icons.search,
              ),
            ),
          ),
        ],
      ),

      body: currentPage(),

      //底部导航栏
      bottomNavigationBar: BottomNavigationBar(
          //通过fixedColor设置选中item 的颜色
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: ((index) {
            setState(() {
              _currentIndex = index;
            });
          }),
          //底部导航栏
          items: [
            BottomNavigationBarItem(
              title: Text(
                '首页',
              ),
              icon: Icon(Icons.home),
            ),
            BottomNavigationBarItem(
              title: Text(
                '学生管理',
              ),
              icon: Icon(Icons.apps),
            ),
            BottomNavigationBarItem(
              title: Text(
                '学生管理',
              ),
              icon: Icon(Icons.fiber_new),
            ),
            BottomNavigationBarItem(
              title: Text(
                '关于我们',
              ),
              icon: Icon(Icons.insert_comment),
            ),
          ]),
    );
  }
}
