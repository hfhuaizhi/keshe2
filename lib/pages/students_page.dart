import 'package:flutter/material.dart';
import '../model/news.dart';
import '../services/news.dart';
import 'students_detail_page.dart';
import 'package:http/http.dart' as http;
import 'package:keshe2/conf/configure.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keshe2/model/student.dart';
import 'students_add.dart';

//新闻页面
class StudentPage extends StatefulWidget {
  @override
  StudentPageState createState() => StudentPageState();
}

class StudentPageState extends State<StudentPage> {
  List<Student> listData = List<Student>();

  //获取新闻列表数据
  void getStudentList() async {
    var data = await http.get(Config.SERVER_GETSTUDENT);
    if(data.body!=null){
      List<Student> list = new List();
      try{
        List tmpList = json.decode(data.body);
        tmpList.forEach((tmp){
          list.add(Student.fromJson(tmp));
        });
      }catch(e){
        print(e.toString());
      }
      print(list.toString());
      if(list!=null){
        listData.clear();
        listData.addAll(list);
      }
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
            title: Text(item.s_realname),
            subtitle: Text(item.s_class),
            leading: Icon(Icons.accessibility_new),
            trailing: Icon(Icons.arrow_forward),
            contentPadding: EdgeInsets.all(10.0),
            enabled: true,
            //跳转至新闻详情页面
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  //  builder: (context) => NewsDetailPage(item: item)),
                    builder: (context) => StudentsDetailPage(item:item,onUpdate: (){
                      getStudentList();
                    },)
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.push(context, MaterialPageRoute(builder: (context){
            return AddStudent((){
              setState(() {
                print("onsuccess");
                getStudentList();
              });
            });
          }));
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
