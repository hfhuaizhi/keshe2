import 'package:flutter/material.dart';
import 'package:keshe2/model/ClassTask.dart';
import 'package:keshe2/model/student.dart';
import 'package:keshe2/pages/students_detail_page.dart';
import 'package:http/http.dart' as http;
import 'package:keshe2/conf/configure.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';

class SearchPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _SearchState();
  }
}
class _SearchState extends State<SearchPage>{
  List<Student> listData = List<Student>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
           title: TextField(
             autofocus: true,
             onChanged: (v){
               if(v.isNotEmpty){
                 _SearchStudentList(v);
                 //print(v);
               }
             },
           ),
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
                    },)
                ),
              );
            },
          );
        },
      ),
    );
  }
  void _SearchStudentList(String v) async{
    var res = await http.get(Config.SERVER_SEARCHSTU+"?stu=$v");
    if(res.body!=null){
      listData.clear();
      List<Student> list = new List();
      try{
        list = json.decode(res.body);
      }catch(e){
        print(e.toString());
      }
      listData.addAll(list);
      setState(() {

      });
    }

  }
}

