import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keshe2/conf/configure.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:fluttertoast/fluttertoast.dart';
VoidCallback callback;
class AddStudent extends StatefulWidget{
  AddStudent(VoidCallback onSuccess){
    callback = onSuccess;
  }
  @override
  State<StatefulWidget> createState() {
    return _AddStudentState();
  }

}

class _AddStudentState extends State<AddStudent>{
  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  TextEditingController _realNameController = new TextEditingController();
  TextEditingController _clazzController = new TextEditingController();
  GlobalKey _formKey= new GlobalKey<FormState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 66.0, horizontal: 24.0),
        child: Form(
          key: _formKey, //设置globalKey，用于后面获取FormState
          autovalidate: true, //开启自动校验
          child: Column(
            children: <Widget>[
              TextFormField(
                  autofocus: true,
                  controller: _unameController,
                  decoration: InputDecoration(
                      labelText: "用户名",
                      hintText: "用户名",
                      icon: Icon(Icons.person)
                  ),
                  // 校验用户名
                  validator: (v) {
                    if(v.trim().length<6||v.trim().length>15){
                      return "用户名长度应大于6并且小于15";
                    }else{
                      return null;
                    }
                  }

              ),
              TextFormField(
                  controller: _pwdController,
                  decoration: InputDecoration(
                      labelText: "密码",
                      hintText: "密码",
                      icon: Icon(Icons.lock)
                  ),
                  obscureText: true,
                  //校验密码
                  validator: (v) {
                    return v
                        .trim()
                        .length > 5 ? null : "密码不能少于6位";

                  }
              ),
              TextFormField(
                  decoration: InputDecoration(
                      labelText: "确认密码",
                      hintText: "确认密码",
                      icon: Icon(Icons.lock)
                  ),
                  obscureText: true,
                  //校验密码
                  validator: (v) {
                    return v
                        .trim()
                        .contains(_pwdController.text)  ? null : "两次密码不一样!";

                  }
              ),
              TextFormField(
                  controller: _realNameController,
                  decoration: InputDecoration(
                      labelText: "真实姓名",
                      hintText: "真实姓名",
                      icon: Icon(Icons.pregnant_woman)
                  ),
                  validator: (v) {
                    return v
                        .trim()
                        .length > 1 ? null : "不能为空哦";

                  }
              ),
              TextFormField(
                  controller: _realNameController,
                  decoration: InputDecoration(
                      labelText: "班级",
                      hintText: "班级",
                      icon: Icon(Icons.class_)
                  ),
                  validator: (v) {
                    return v
                        .trim()
                        .length > 1 ? null : "不能为空哦";

                  }
              ),
              // 登录按钮
              Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: Row(
                  children: <Widget>[
                    Expanded(child: RaisedButton(onPressed: (){
                      if((_formKey.currentState as FormState).validate()){
                        _doRegist();
                        //验证通过提交数据
                      }else{
                        Fluttertoast.showToast(msg: "填写内容还有不规范的哦");
                      }
                    },
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      child: Text("确认注册"),
                      padding: EdgeInsets.all(15.0),
                    ))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  void _doRegist() async{
    String username = _unameController.text;
    String password = _pwdController.text;
    String realname = _realNameController.text;
    String clazz = _clazzController.text;
    var res = await http.get(Config.SERVER_REGIST+"?username=$username&password=$password&realname=$realname&class=$clazz");
    String body = res.body;
    body = "fail";
    if(body!=null&&body.contains(Config.SUCCESS)){
      showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text('注册成功'),
            actions: <Widget>[
              new FlatButton(
                child: new Text('确定'),
                onPressed: () {
                  callback();
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      ).then((val) {
        print(val);
      });
    }else{
      showDialog<Null>(
        context: context,
        barrierDismissible: false,
        builder: (BuildContext context) {
          return new AlertDialog(
            title: new Text('注册失败'),
            actions: <Widget>[
              new FlatButton(
                child: new Text("确认"),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      ).then((val) {
        print(val);
      });
    }
    //Navigator.pushNamed(context, "regist");
  }
}


