import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:keshe2/conf/GlobalValue.dart';
import 'package:keshe2/conf/configure.dart';
import 'dart:convert';
import 'package:keshe2/model/course.dart';
import 'package:keshe2/pages/courses_detail_page.dart';
import 'package:keshe2/pagesstu/page_classtask_stu.dart';
import 'package:keshe2/utils/SpUtil.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PageCourseStu extends StatefulWidget{
  PageCourseStu(){}
  @override
  State<StatefulWidget> createState() {
    return PageCourseStuState();
  }
}

class PageCourseStuState extends State<PageCourseStu>{
  List<Course> listData = List<Course>();

  //获取新闻列表数据
  void getCourseList() async {
    String username = await getString(GlobalValue.USERNAME);
    var data = await http.get(Config.SERVER_GETCOURSEBYSTU+"?username=$username");
    List<Course> list = new List();
    if(data.body!=null){
      List tmpList;
      try{
        tmpList = json.decode(data.body);
        print(data.body);
        tmpList.forEach((tmp){
          list.add(Course.fromJson(tmp));
        });
      }catch(e){
        print(e.toString());
      }
      setState(() {
        listData.clear();
        listData.addAll(list);
      });
    }else{
      Fluttertoast.showToast(msg: "获取课程列表失败");
    }
  }

  @override
  void initState() {
    getCourseList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //带分隔线的List
      appBar: AppBar(
        title: Text("签过到的课程"),
      ),
      body: ListView.separated(
        //排列方向 垂直和水平
        scrollDirection: Axis.vertical,
        //分隔线构建器
        separatorBuilder: (BuildContext contex, int index) => Divider(
          height: 1.0,
          color: Colors.grey,
        ),
        itemCount: listData.length,
        //列表项构建器
        itemBuilder: (BuildContext contex, int index) {

          //新闻列表项数据
          Course item = listData[index];

          return ListTile(
            title: Text(item.name),
            subtitle: Text(item.time),
            leading: Icon(Icons.golf_course),
            trailing: Icon(Icons.arrow_forward),
            contentPadding: EdgeInsets.all(10.0),
            enabled: true,
            //跳转至新闻详情页面
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  //  builder: (context) => NewsDetailPage(item: item)),
                    builder: (context) => PageClasstaskStu(item)
                ),
              );
            },
          );
        },
      ),
    );
  }
}