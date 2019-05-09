import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'conf/configure.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'utils/SpUtil.dart';
import 'conf/GlobalValue.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Login extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  TextEditingController _unameController = new TextEditingController();
  TextEditingController _pwdController = new TextEditingController();
  GlobalKey _formKey = new GlobalKey<FormState>();

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
                      icon: Icon(Icons.person)),
                  // 校验用户名
                  validator: (v) {
                    if (v.trim().length < 6 || v.trim().length > 15) {
                      return "用户名长度应大于6并且小于15";
                    } else {
                      return null;
                    }
                  }),
              TextFormField(
                  controller: _pwdController,
                  decoration: InputDecoration(
                      labelText: "密码",
                      hintText: "您的登录密码",
                      icon: Icon(Icons.lock)),
                  obscureText: true,
                  //校验密码
                  validator: (v) {
                    return v.trim().length > 5 ? null : "密码不能少于6位";
                  }),
              // 登录按钮
              Padding(
                padding: const EdgeInsets.only(top: 28.0),
                child: Row(
                  children: <Widget>[
                    Expanded(
                      child: RaisedButton(
                        padding: EdgeInsets.all(15.0),
                        child: Text("教师登录"),
                        color: Theme.of(context).primaryColor,
                        textColor: Colors.white,
                        onPressed: () {
                          if ((_formKey.currentState as FormState).validate()) {
                            String username = _unameController.text;
                            String password = _pwdController.text;
                            _doLogin(username, password);
                            //验证通过提交数据
                          } else {
                            Fluttertoast.showToast(msg: "填写内容还有不规范的哦");
                          }
                        },
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(10),
                    ),
                    Expanded(
                        child: RaisedButton(
                      onPressed: () {
                        if ((_formKey.currentState as FormState).validate()) {
                          String username = _unameController.text;
                          String password = _pwdController.text;
                          _doStudentLogin(username, password);
                          //验证通过提交数据
                        } else {
                          Fluttertoast.showToast(msg: "填写内容还有不规范的哦");
                        }
                      },
                      textColor: Colors.white,
                      color: Theme.of(context).primaryColor,
                      child: Text("学生登录"),
                      padding: EdgeInsets.all(15.0),
                    ))
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 30),
              ),
              RaisedButton(
                onPressed: () {
                  _doRegist();
                },
                textColor: Colors.white,
                color: Theme.of(context).primaryColor,
                child: Text("教师注册"),
                padding: EdgeInsets.all(15.0),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _doLogin(String username, String password) async {
    Fluttertoast.showToast(msg: "dologin");
    var res = await http.get(Config.SERVER_LOGIN +
        "?username=" +
        username +
        "&password=" +
        password);
    String body = res.body;
   // Navigator.pushNamed(context, "app");
    //return;
    if (body.isNotEmpty && body.contains("success")) {
      Fluttertoast.showToast(msg: "登录成功" + body);
      Navigator.pushReplacementNamed(context, "app");
      setString(GlobalValue.USERNAME, username);
      setString(GlobalValue.USERTAG, GlobalValue.TEACHERTAG);
    } else {
      Fluttertoast.showToast(msg: "登录失败" + body);
      //todo 暂行进入主界面
    }
    //Navigator.of(context).pop();
  }

  void _doRegist() {
    Navigator.pushNamed(context, "regist");
  }

  void _doStudentLogin(String username, String password) async {
    var res = await http
        .get(Config.SERVER_STULOGIN + "?username=$username&password=$password");
    if (res.body.contains("success")) {
      setString(GlobalValue.USERNAME, username);
      setString(GlobalValue.USERTAG, GlobalValue.STUTAG);
      Navigator.pushReplacementNamed(context, "stuapp");

    } else {
      Fluttertoast.showToast(msg: "学生登录失败");
    }
    //Navigator.pop(context);
  }
}
//嗯，这个的话，
