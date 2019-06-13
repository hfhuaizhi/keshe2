import 'package:flutter/material.dart';
import 'package:keshe2/model/student.dart';
import 'package:keshe2/pages/students_detail_page.dart';
import 'package:http/http.dart' as http;
import 'package:keshe2/conf/configure.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keshe2/model/course.dart';
import 'package:keshe2/model/attendance.dart';
import 'package:keshe2/utils/SpUtil.dart';
import 'package:keshe2/conf/GlobalValue.dart';
class kaoqinStuPage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() {
    return _kaoqinStuPageState();
  }
  kaoqinStuPage();
}
class _kaoqinStuPageState extends State<kaoqinStuPage>{
  List<Attendance> listData = List<Attendance>();
  _kaoqinStuPageState();
  @override
  void initState() {
    super.initState();
    getAttendanceList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("我的考勤"),
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
          Attendance item = listData[index];

          return GestureDetector(
            child: ListTile(
              title: Text(item.sname),
              subtitle: Text(item.state.toString()),
              leading: Icon(Icons.location_on),
              contentPadding: EdgeInsets.all(10.0),
              enabled: true,
            ),
          );
        },
      ),
    );
  }

  void getAttendanceList() async{
    String username = await getString(GlobalValue.USERNAME);
    var res = await http.get(Config.SERVER_GETATTENDANCE+"?susername=${username}");
    if(res.body!=null){
      listData.clear();
      List<Attendance> list = new List();
      try{
        List tmpList= json.decode(res.body);
        tmpList.forEach((tmp){
          list.add(Attendance.fromJson(tmp));
        });
      }catch(e){
        print(e.toString());
      }
      setState(() {
        listData.clear();
        listData.addAll(list);
      });
    }
  }

}

