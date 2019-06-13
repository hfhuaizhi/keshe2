import 'package:flutter/material.dart';
import 'package:keshe2/conf/GlobalValue.dart';
import 'package:keshe2/model/ClassTask.dart';
import '../model/news.dart';
import '../services/news.dart';
import 'package:http/http.dart' as http;
import 'package:keshe2/conf/configure.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keshe2/model/student.dart';
import 'package:keshe2/model/course.dart';
import 'package:keshe2/utils/SpUtil.dart';

//新闻页面
class PageClasstaskStu extends StatefulWidget {
  Course cItem;
  PageClasstaskStu(this.cItem);
  @override
  PageClasstaskStuState createState() => PageClasstaskStuState(cItem);
}

class PageClasstaskStuState extends State<PageClasstaskStu> {
  Course cItem;
  List<ClassTask> listData = List<ClassTask>();
  TextEditingController _nameCon = new TextEditingController();
  TextEditingController _timeCon = new TextEditingController();

  PageClasstaskStuState(this.cItem);
  //获取新闻列表数据
  void getClassTaskList() async {
    var data = await http.get(Config.SERVER_SEARCHCLASSTASK+"?cid=${cItem.id}");
    if(data.body!=null){
      List<ClassTask> list = new List();
      try{
        List tmpList = json.decode(data.body);
        tmpList.forEach((tmp){
          list.add(ClassTask.fromJson(tmp));
        });
      }catch(e){
        print(e.toString());
      }
      setState(() {
        listData.clear();
        listData.addAll(list);
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
        title: Text("作业-${cItem.name}"),
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
            child:ListTile(
              title: Text(item.name),
              subtitle: Text(item.content),
              leading: Text(item.id.toString()),
              trailing: Icon(Icons.arrow_forward),
              contentPadding: EdgeInsets.all(10.0),
              enabled: true,
              //跳转至新闻详情页面
              onTap: () {
                showDialog(context: context,builder: (context){
                  return AlertDialog(
                    title: Text("交作业"),
                    content: Text("作业id：${item.id}"),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("取消"),
                        onPressed: (){Navigator.of(context).pop();},
                      ),
                      FlatButton(
                        child: Text("确定"),
                        onPressed: (){
                          jiaozuoye(item.id.toString());
                        },
                      ),
                    ],
                  );
                });
              },
            ) ,
          );
        },
      ),
    );
  }
  void jiaozuoye(String id) async{
    String username = await getString(GlobalValue.USERNAME);
    var res = await http.get(Config.SERVER_DOMYCLASSTASK+"?clid=$id&username=$username");
    if(res.body.isNotEmpty&&res.body.contains(Config.SUCCESS)){
      Fluttertoast.showToast(msg: "作业提交成功");
    }else{
      Fluttertoast.showToast(msg: "作业提交失败");
    }
  }
  void addClassTask(String name, String content) async {
    var res = await http.get(Config.SERVER_ADDCLASSTASK+"?name=$name&content=$content&cid=${cItem.id}");
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


