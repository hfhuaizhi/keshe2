import 'package:flutter/material.dart';
import 'package:keshe2/model/course.dart';
import '../model/news.dart';
import '../model/student.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:keshe2/conf/configure.dart';
import 'dart:convert';
import 'kaoqin_page.dart';
import 'classtask_page.dart';

class CoursesDetailPage extends StatefulWidget{
  Course item;
  CoursesDetailPage(this.item);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _CoursesDetailPageState(item);
  }

}
class _CoursesDetailPageState extends State<CoursesDetailPage> with SingleTickerProviderStateMixin{
  Course item;
  bool canEdit = false;
  TextEditingController _nameCon = new TextEditingController();
  TextEditingController _timeCon = new TextEditingController();
  Widget divider1=Divider(color: Colors.blue,);
  Widget divider2=Divider(color: Colors.green);
  _CoursesDetailPageState(this.item);
  @override
  void initState() {
    super.initState();
    _nameCon.text = item.name;
    _timeCon.text = item.time;
    getCourseById();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("课程信息详情"),
      ),
      body:  Padding(
          padding: EdgeInsets.all(16.0),
          child:Column(
            children: <Widget>[
                TextField(
                  autofocus: canEdit,
                  enabled: canEdit,
                  controller: _nameCon,
                  decoration: InputDecoration(
                      labelText: "课程名",
                      hintText: "课程名",
                      icon: Icon(Icons.assignment)
                  ),

                ),
              TextField(
                enabled: canEdit,
                controller: _timeCon,
                decoration: InputDecoration(
                    labelText: "时间",
                    hintText: "时间",
                    icon: Icon(Icons.access_time)
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 40),
              ),
              !canEdit?Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    child: Text("修改信息"),
                    onPressed: (){
                      setState(() {
                        canEdit = true;
                      });
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20,right: 20),
                  ),
                  RaisedButton(
                    child: Text("删除这个课程"),
                    color: Colors.red,
                    textColor: Colors.white,
                    onPressed: (){
                      showDialog(
                          context: context,
                          builder: (context){
                            return AlertDialog(
                              title: Text("确定删除吗"),
                              content: Text("删了可就没了哦"),
                              actions: <Widget>[
                                FlatButton(
                                  child: Text("取消"),
                                  onPressed: (){Navigator.of(context).pop();},
                                ),
                                FlatButton(
                                  child: Text("确定"),
                                  onPressed: (){
                                    Navigator.of(context).pop();
                                    deleteCourse();
                                  },
                                ),
                              ],
                            );
                          }
                      );
                    },
                  )
                ],
              ):Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  RaisedButton(
                    child: Text("取消修改"),
                    onPressed: (){
                      setState(() {
                        canEdit = false;
                      });
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: 20,right: 20),
                  ),
                  RaisedButton(
                    child: Text("确认修改"),
                    onPressed: (){
                      updateCourse();
                    },
                  )
                ],
              ),
                Padding(padding: EdgeInsets.only(top: 50),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    RaisedButton(
                      child: Text("查看考勤"),
                      onPressed: (){
                        showKaoqin();
                      },
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 30,right: 30),
                    ),
                    RaisedButton(
                      child: Text("查看作业"),
                      onPressed: (){
                        showZuoye();
                      },
                    )
                  ],
                )

            ],
          )
      ),
    );
  }
  @override
  void dispose() {
    super.dispose();
  }
  void updateCourse() async{
    String name = _nameCon.text;
    String time = _timeCon.text;
    if(name.isEmpty||time.isEmpty){
      Fluttertoast.showToast(msg: "输入不能为空");
      return;
    }
    var res = await http.get(Config.SERVER_UPDATECOURSE+"?id=${item.id}&name=$name&time=$time");
    if(res.body.contains(Config.SUCCESS)){
      setState(() {
        canEdit = false;
      });
    }else{
      Fluttertoast.showToast(msg: "修改失败");
    }

  }

  void deleteCourse() async{
    var res = await http.get(Config.SERVER_DELETECOURSE+"?id=${item.id}");
    if(res.body.contains(Config.SUCCESS)){
      Navigator.of(context).pop();
    }else{
      Fluttertoast.showToast(msg: "删除失败");
    }
  }

  void getCourseById() async{
    var res = await http.get(Config.SERVER_SEARCHCOURSE+"?id=${item.id}");
    if(res.body!=null){
      item = json.decode(res.body);
      setState(() {

      });
    }
  }

  void initView() {}

  void showKaoqin() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return kaoqinPage(item: item);
    }));
  }

  void showZuoye() {
    Navigator.of(context).push(MaterialPageRoute(builder: (context){
      return ClassTaskPage(item);
    }));
  }
}

