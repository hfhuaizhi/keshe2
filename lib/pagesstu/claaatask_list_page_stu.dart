import 'package:flutter/material.dart';
import 'package:keshe2/conf/GlobalValue.dart';
import 'package:keshe2/model/ClassTask.dart';
import 'package:keshe2/model/student.dart';
import 'package:keshe2/pages/students_detail_page.dart';
import 'package:http/http.dart' as http;
import 'package:keshe2/conf/configure.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keshe2/model/course.dart';
import 'package:keshe2/model/doclasstask.dart';
import 'package:keshe2/utils/SpUtil.dart';
class ClassTaskListPageStu extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _ClassTaskListPageStuState();
  }
ClassTaskListPageStu();
}
class _ClassTaskListPageStuState extends State<ClassTaskListPageStu>{
  List<Doclasstask> listData = List<Doclasstask>();
  _ClassTaskListPageStuState();
  @override
  void initState() {
    super.initState();
    getClassTaskList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
           title: Text("作业列表"),
      ),
      body: ListView.separated(
        scrollDirection: Axis.vertical,
        //分隔线构建器
        separatorBuilder: (BuildContext contex, int index) => Divider(
          height: 1.0,
          color: Colors.grey,
        ),
        itemCount: listData.length,

        itemBuilder: (BuildContext contex, int index) {

          //新闻列表项数据
          Doclasstask item = listData[index];
          return GestureDetector(
            child: ListTile(
            title: Text(item.sname),
            subtitle: Text(item.state.toString()),
            leading: Text(item.clid.toString()),
            contentPadding: EdgeInsets.all(10.0),
            enabled: true,
          ),
          );
        },
      ),
    );
  }

  void getClassTaskList() async{
    String username = await getString(GlobalValue.USERNAME);
    var res = await http.get(Config.SERVER_GETDCLBYCLID+"?susername=${username}");
    if(res.body!=null){
      listData.clear();
      List<Doclasstask> list = new List();
      try{
        List tmpList = json.decode(res.body);
        tmpList.forEach((tmp){
          list.add(Doclasstask.fromJson(tmp));
        });
      }catch(e){
        print(e.toString());
      }
      setState(() {
        listData.clear();
        listData.addAll(list);
      });
    }
  }
}

