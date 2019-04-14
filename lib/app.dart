import 'package:flutter/material.dart';
import 'dart:async';
import 'pages/about_us_page.dart';
import 'pages/home_page.dart';
import 'pages/news_page.dart';
import 'pages/product_pager.dart';
class App extends StatefulWidget{
  @override
  _AppState createState() {
    return _AppState();
  }

}
class _AppState extends State<App>{
  //当前选择页面索引
  var _currentIndex = 0;
  HomePage homePage;
  ProductPage productPage;
  NewsPage newsPage;
  AboutUsPage aboutUsPage;

  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("flutterkeshe"),
        leading: Icon(Icons.home),
        actions: <Widget>[
          Padding(
            padding: EdgeInsets.only(right: 20),
            child: GestureDetector(onTap: (){},
              child: Icon(Icons.search),
            ),
          ),
        ],
      ),
      body: currentPage(),
      bottomNavigationBar: BottomNavigationBar(
        //通过fixcolor设置选中item颜色
          type: BottomNavigationBarType.fixed,
          currentIndex:  _currentIndex,
          onTap: (index){
            setState(() {
              _currentIndex = index;
            });
          },
          items: [
            BottomNavigationBarItem(
              title: Text('首页',style: TextStyle(
                color: _currentIndex==0?Colors.redAccent:Color(0xffaaaaaa)
              ),),
              icon: Icon(Icons.home)
            ),
            BottomNavigationBarItem(
                title: Text('产品'),
                icon: Icon(Icons.home)
            ),
            BottomNavigationBarItem(
                title: Text('新闻'),
                icon: Icon(Icons.home)
            ),
            BottomNavigationBarItem(
                title: Text('关于'),
                icon: Icon(Icons.home)
            )
          ],

      ),
    );
  }
  currentPage() {
    switch (_currentIndex){
      case 0:
        if(homePage==null){
          homePage = new HomePage();
        }
        return homePage;
        break;
      case 1:
        if(productPage==null){
          productPage = new ProductPage();
        }
        return productPage;
        break;
      case 2:
        if(newsPage==null){
          newsPage = new NewsPage();
        }
        return newsPage;
        break;
      case 3:
        if(aboutUsPage==null){
          aboutUsPage = new AboutUsPage();
        }
        return aboutUsPage;
        break;
    }
  }



}