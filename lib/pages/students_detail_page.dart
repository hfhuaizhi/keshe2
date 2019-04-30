import 'package:flutter/material.dart';
import 'package:keshe2/model/ClassTask.dart';
import '../model/news.dart';
import '../model/student.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:keshe2/conf/configure.dart';

class StudentsDetailPage extends StatefulWidget{
  Student item;
  StudentsDetailPage(this.item);
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _StudentsDetailPageState(item);
  }

}
class _StudentsDetailPageState extends State<StudentsDetailPage>{
  final Student item;
  bool canEdit = false;
  TextEditingController _usernameCon = new TextEditingController();
  TextEditingController _passwordCon = new TextEditingController();
  TextEditingController _realnameCon = new TextEditingController();
  TextEditingController _clazzCon = new TextEditingController();
  _StudentsDetailPageState(this.item);
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _usernameCon.text = item.username;
    _passwordCon.text = item.password;
    _realnameCon.text = item.realname;
    _clazzCon.text = item.clazz;
  }
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        title: Text("学生信息详情"),
      ),
      body:  Padding(
          padding: EdgeInsets.all(16.0),
          child:Column(
            children: <Widget>[
                TextField(
                  autofocus: canEdit,
                  controller: _usernameCon,
                  decoration: InputDecoration(
                      labelText: "用户名",
                      hintText: "用户名",
                      icon: Icon(Icons.pregnant_woman)
                  ),

                ),
              TextField(
                autofocus: canEdit,
                enabled: canEdit,
                controller: _passwordCon,
                decoration: InputDecoration(
                    labelText: "密码",
                    hintText: "密码",
                    icon: Icon(Icons.lock)
                ),
              ),
              TextField(
                enabled: canEdit,
                controller: _realnameCon,
                decoration: InputDecoration(
                    labelText: "真实姓名",
                    hintText: "真实姓名",
                    icon: Icon(Icons.person)
                ),
              ),
              TextField(
                enabled: canEdit,
                controller: _clazzCon,
                decoration: InputDecoration(
                    labelText: "班级",
                    hintText: "班级",
                    icon: Icon(Icons.class_)
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 40),
              ),
              !canEdit?
              RaisedButton(
                child: Text("修改信息"),
                onPressed: (){
                  setState(() {
                    canEdit = true;
                  });
                },
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
                      updateStudent();
                    },
                  )
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 20),
              ),
              RaisedButton(
                child: Text("删除这个学生"),
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
                              deleteStu();
                            },
                          ),
                        ],
                      );
                    }
                  );
                },
              )
            ],
          )
      ),
    );;
  }

  void updateStudent() async{
    String username = _usernameCon.text;
    String password = _passwordCon.text;
    String realname = _realnameCon.text;
    String clazz = _clazzCon.text;
    if(username.isEmpty||password.isEmpty||realname.isEmpty||clazz.isEmpty){
      Fluttertoast.showToast(msg: "输入不能为空");
      return;
    }
    var res = await http.get(Config.SERVER_UPDATESTU+"?id=${item.id}&username=$username&password=$password&realname=$realname&class=$clazz");
    if(res.body.contains(Config.SUCCESS)){
      setState(() {
        canEdit = false;
      });
    }else{
      Fluttertoast.showToast(msg: "修改失败");
    }

  }

  void deleteStu() async{
    var res = await http.get(Config.SERVER_DELETESTU+"?id=${item.id}");
    if(res.body.contains(Config.SUCCESS)){
      Navigator.of(context).pop();
    }else{
      Fluttertoast.showToast(msg: "删除失败");
    }
  }

}