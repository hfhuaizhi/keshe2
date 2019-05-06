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
    var res = await http.get(Config.SERVER_UPDATESTU+"?id=${item.id}&username=$username&password=$password&realname=$realname&clazz=$clazz");
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
/*
* 嗯，其实呢，上网还是比较重要的，可能会亏一点或是什么的，其实都没什么太大问题，
* 之前主卧是有交过网费，现在又搬来的主卧之前有说过网费已和上家结清，
* 虽然我们也无法确认是否他们真的结清，不过至少他所在的卧室之前是有交过网费的，他继续用网其实也无可厚非
* 5.1又搬来的两个人他们所在的卧室是一直都没办过网的，他俩的网费，想要精确一点的话可以这么算
* 先算出正常情况下网费8个人平分需要多少钱，再算出每个人每天需要多少钱，再看现在距离到期还有几天
* 他俩需要交的钱就是：每人每天的钱*剩余天数*2
* 至于我们几个怎么分，说真的，我不要，你们几个分吧，我只想晚上回来睡觉前可以上个网玩会儿手机~
* 嗯，之前新搬来那两个人的网费是我算的，其实是有一些问题，一会儿我把红包还回去，麻烦你们再重新讨论一下，
* 嗯，费用不要算上我，谢谢啦
* */