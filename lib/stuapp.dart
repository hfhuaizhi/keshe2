import 'package:flutter/material.dart';
import 'pages/about_us_page.dart';
import 'pages/home_page.dart';
import 'pages/students_page.dart';
import 'pages/course_page.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'pages/search_page.dart';
import 'pages/students_add.dart';
import 'pagesstu/stuwork_page.dart';
import 'pagesstu/student_self_page.dart';
class StuApp extends StatefulWidget {
  @override
  StuAppState createState() => StuAppState();
}

class StuAppState extends State<StuApp> {
  //当前选择页面索引
  var _currentIndex = 0;
  var titles = ["功能","我的","关于"];
  var cansearch = [false,false,false];
  var iconList = [Icon(Icons.change_history),
  Icon(Icons.person),
  Icon(Icons.insert_comment)];
  StuwordPage wordPage;


  StudentsSelfPage studentPage;

  AboutUsPage aboutUsPage;

  //根据当前索引返回不同的页面
  currentPage(){
    switch(_currentIndex){
      case 0:
        if(wordPage == null){
          wordPage = StuwordPage();
        }
        return wordPage;
      case 1:
        if(studentPage == null){
          studentPage = StudentsSelfPage();
        }
        return studentPage;

      case 2:
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
        leading: iconList[_currentIndex],
        actions: <Widget>[
          //右侧内边距
          Offstage(
            offstage: !cansearch[_currentIndex],
            child: Padding(
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
                titles[0],
              ),
              icon: iconList[0],
            ),
            BottomNavigationBarItem(
              title: Text(
                titles[1],
              ),
              icon: iconList[1],
            ),
            BottomNavigationBarItem(
              title: Text(
                titles[2],
              ),
              icon: iconList[2],
            ),
          ]
      ),
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
}
