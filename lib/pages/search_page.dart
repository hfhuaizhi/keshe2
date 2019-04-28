import 'package:flutter/material.dart';
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
                 _SeatchStudentList(v);
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
            title: Text(item.realname),
            subtitle: Text(item.clazz),
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
                    builder: (context) => StudentsDetailPage(item: item)
                ),
              );
            },
          );
        },
      ),
    );
  }
  void _SeatchStudentList(String v) async{
    var res = await http.get(Config.SERVER_SEARCHSTU+"?stu=$v");
    if(res.body!=null){
      listData.clear();
      List<Student> list = new List();
      try{
        list = json.decode(res.body);
      }catch(e){
        print(e.toString());
      }
      list.add(Student("hahahha", "hah"));
      listData.addAll(list);
      setState(() {

      });
    }

  }
}

