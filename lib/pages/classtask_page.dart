import 'package:flutter/material.dart';
import 'package:keshe2/model/ClassTask.dart';
import '../model/news.dart';
import '../services/news.dart';
import 'students_detail_page.dart';
import 'package:http/http.dart' as http;
import 'package:keshe2/conf/configure.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keshe2/model/student.dart';
import 'package:keshe2/model/course.dart';
import 'claaatask_list_page.dart';
//新闻页面
class ClassTaskPage extends StatefulWidget {
  Course cItem;
  ClassTaskPage(this.cItem);
  @override
  ClassTaskPageState createState() => ClassTaskPageState(cItem);
}

class ClassTaskPageState extends State<ClassTaskPage> {
  Course cItem;
  List<ClassTask> listData = List<ClassTask>();
  TextEditingController _nameCon = new TextEditingController();
  TextEditingController _timeCon = new TextEditingController();

  ClassTaskPageState(this.cItem);
  //获取新闻列表数据
  void getClassTaskList() async {
    var data = await http.get(Config.SERVER_SEARCHCOURSE+"?id=${cItem.id}");
    if(data.body!=null){
      List<ClassTask> list = new List();
      try{
        list = json.decode(data.body);
      }catch(e){
        print(e.toString());
      }


      list.add(new ClassTask("tmptask","tmpclass"));

      listData.addAll(list);
      setState(() {

      });
    }else{
      Fluttertoast.showToast(msg: "获取作业列表失败");
    }
  }

  @override
  void initState() {
    getClassTaskList();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //带分隔线的List
      appBar: AppBar(
        title: Text("${cItem.name}的作业"),
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
          ClassTask item = listData[index];

          return GestureDetector(
            onLongPress: (){
              showDialog(context: context,builder: (context){
                return AlertDialog(
                  title: Text("确定删除吗？"),
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
                        deleteClassTask(item.id);
                        Navigator.of(context).pop();
                      },
                    ),
                  ],
                );
              });
            },
            child:ListTile(
              title: Text(item.name),
              subtitle: Text(item.content),
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
                      builder: (context) => ClassTaskListPage(item)
                  ),
                );
              },
            ) ,
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
                  addClassTask(name,time);
                },
              ),
            ],
          );
        });
      }
      ),
    );
  }

  void addClassTask(String name, String content) async {
    ClassTask tmp = ClassTask(name , content);
    var res = await http.get(Config.SERVER_ADDCLASSTASK+"?name=$name&content=$content");
    if(res.body!=null){
      if(res.body.contains(Config.SUCCESS)){
        setState(() {
          getClassTaskList();
        });
      }else{
        Fluttertoast.showToast(msg: "出错");
      }
    }
  }
  void deleteClassTask(int id) async{
    var res = await http.get(Config.SERVER_DELETECLASSTASK+"?id=$id");
    if(res.body.contains(Config.SUCCESS)){
      setState(() {
        getClassTaskList();
      });
    }else{
      Fluttertoast.showToast(msg: "出错");
    }
  }
}

