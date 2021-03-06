import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:keshe2/conf/GlobalValue.dart';
import 'package:keshe2/conf/configure.dart';
import 'dart:convert';
import 'package:keshe2/model/course.dart';
import 'courses_detail_page.dart';
import 'package:keshe2/utils/SpUtil.dart';

class CoursePage extends StatefulWidget{
  @override
  CoursePageState createState() => CoursePageState();
}

class CoursePageState extends State<CoursePage>{
  TextEditingController _nameCon = new TextEditingController();
  TextEditingController _timeCon = new TextEditingController();
  List<Course> listData = List<Course>();

  //获取新闻列表数据
  void getCourseList() async {
    String username = await getString(GlobalValue.USERNAME);
    var data = await http.get(Config.SERVER_GETCOURSEBYTUSERNAME+"?username=$username");
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
                    builder: (context) => CoursesDetailPage(item:item,onUpdate: (){
                      getCourseList();
                    },)
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: (){
            showDialog(context: context,builder: (context){
              return AlertDialog(
                title: Text("新增课程"),
                content:Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    TextField(
                      controller: _nameCon,
                      decoration: InputDecoration(
                        labelText: "课程名称",
                        hintText: "课程名称",
                      ),
                    ),
                    TextField(
                      controller: _timeCon,
                      decoration: InputDecoration(
                        labelText: "课程时间",
                        hintText: "课程时间",
                      ),
                    )
                  ],),
                actions: <Widget>[
                  FlatButton(
                    child: Text("取消"),
                    onPressed: (){
                      Navigator.of(context).pop();
                    },
                  ),
                  FlatButton(
                    child: Text("确定"),
                    onPressed: (){
                      String name = _nameCon.text;
                      String time = _timeCon.text;
                      if(name.isEmpty||time.isEmpty){
                        Fluttertoast.showToast(msg: "不能为空");
                        return;
                      }
                      Navigator.of(context).pop();
                      addCourse(name,time);
                    },
                  ),
                ],
              );
            });
      }),
    );
  }

  void addCourse(String name, String time) async{
    String username = await getString(GlobalValue.USERNAME);
    var res = await http.get(Config.SERVER_ADDCOURSE+"?name=$name&time=$time&username=$username");
    if(res.body!=null){
      if(res.body.contains(Config.SUCCESS)){
        setState(() {
          getCourseList();
        });
      }else{
        Fluttertoast.showToast(msg: "出错");
      }
    }
  }

}