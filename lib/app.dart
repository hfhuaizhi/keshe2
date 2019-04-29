import 'package:flutter/material.dart';
import 'pages/about_us_page.dart';
import 'pages/home_page.dart';
import 'pages/students_page.dart';
import 'pages/course_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'pages/search_page.dart';
import 'pages/students_add.dart';
class App extends StatefulWidget {
  @override
  AppState createState() => AppState();
}

class AppState extends State<App> {
  //当前选择页面索引
  var _currentIndex = 0;
  var titles = ["这是首页","这是首页2","学生管理","关于"];

  HomePage homePage;

  CoursePage coursePage;

  StudentPage studentPage;

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
        if(coursePage == null){
          coursePage = CoursePage();
        }
        return coursePage;

      case 2:
        if(studentPage == null){
          studentPage = StudentPage();
        }
        return studentPage;
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
        title: Text(titles[_currentIndex]),
        leading: Icon(Icons.home),
        actions: <Widget>[
          //右侧内边距
          Padding(
            padding: EdgeInsets.only(right: 20.0),
            child: GestureDetector(
              onTap: () {
                onSearchPress();
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
                '课堂管理',
              ),
              icon: Icon(Icons.apps),
            ),
            BottomNavigationBarItem(
              title: Text(
                '学生管理',
              ),
              icon: Icon(Icons.supervisor_account),
            ),
            BottomNavigationBarItem(
              title: Text(
                '关于我们',
              ),
              icon: Icon(Icons.insert_comment),
            ),
          ]
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
              onAddPress();
          },
          child: new Icon(Icons.add)
          ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void onSearchPress(){

    switch(_currentIndex){
      case 0:

        break;
      case 1:
        break;
      case 2:
        Fluttertoast.showToast(msg: "当前页面$_currentIndex");
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return SearchPage();
        }));
        break;
      case 3:
        break;
    }
  }
  void onAddPress() {
    switch(_currentIndex){
      case 0:

        break;
      case 1:
        break;
      case 2:
        Navigator.push(context, MaterialPageRoute(builder: (context){
          return AddStudent();
        }));
        break;
      case 3:
        break;
    }
  }
}
