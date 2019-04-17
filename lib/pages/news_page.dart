import 'package:flutter/material.dart';
import '../model/news.dart';
import '../services/news.dart';
import 'news_detail_page.dart';
import 'package:http/http.dart' as http;
import 'package:keshe2/conf/configure.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keshe2/model/student.dart';

//新闻页面
class NewsPage extends StatefulWidget {
  @override
  NewsPageState createState() => NewsPageState();
}

class NewsPageState extends State<NewsPage> {
  List<Student> listData = List<Student>();

  //获取新闻列表数据
  void getStudentList() async {
    var data = await http.get(Config.SERVER_GETSTUDENT);
    if(data.body!=null){
      List<Student> list = json.decode(data.body);
      listData.addAll(list);
      setState(() {

      });
    }else{
      Fluttertoast.showToast(msg: "获取学生列表失败");
    }
  }

  @override
  void initState() {
    getStudentList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //带分隔线的List
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
          Student item = listData[index];

          return ListTile(
            title: Text(item.name),
            subtitle: Text(item.clazz),
            leading: Icon(Icons.fiber_new),
            trailing: Icon(Icons.arrow_forward),
            contentPadding: EdgeInsets.all(10.0),
            enabled: true,
            //跳转至新闻详情页面
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  //  builder: (context) => NewsDetailPage(item: item)),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
