import 'package:flutter/material.dart';
import 'about_contact_page.dart';


class AboutUsPage extends StatefulWidget{
  @override
  AboutUsPageState createState() => AboutUsPageState();
}

class AboutUsPageState extends State<AboutUsPage>{


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Image.asset(
              'assets/images/company.jpg',
              fit: BoxFit.cover,
            ),
            ListTile(
              leading: Icon(Icons.message),
              title: Text('项目介绍'),
              onTap: (){
                showDialog(context: context,builder: (context){
                  return AlertDialog(
                    title: Text("项目介绍"),
                    content: Text("该项目为皇甫淮智的本科毕设，具有如下功能：\n 教师端：\n 1.学生管理 \n 2.课堂管理 \n 3.作业管理 \n 4.考勤管理\n"
                        "学生端:\n 1.签到\n 2.交作业\n 3.个人信息修改"
                        ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("确定"),
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  );
                });
              },
            ),
            Divider(
              height: 10.0,
              color: Colors.grey,
            ),
            ListTile(
              leading: Icon(Icons.info),
              title: Text('项目优势'),
              onTap: (){
                showDialog(context: context,builder: (context){
                  return AlertDialog(
                    title: Text("项目优势"),
                    content: Text("该项目具有如下优势：\n 客户端: \n1.客户端采用Flutter框架开发，可同时运行在Android和ios设备上，且界面显示完全一致\n"
                        "2.客户端动画简洁优雅，耳目一新\n"
                        "服务端:\n1.服务端采用ssm框架，开发迅速"
                    ),
                    actions: <Widget>[
                      FlatButton(
                        child: Text("确定"),
                        onPressed: (){
                          Navigator.of(context).pop();
                        },
                      )
                    ],
                  );
                });
              },
            ),
            Divider(
              height: 10.0,
              color: Colors.grey,
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text('联系作者'),
              onTap: (){
                Navigator.push(context,MaterialPageRoute(builder: (context) => AboutContactPage()));
              },
            ),
            Divider(
              height: 10.0,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

}