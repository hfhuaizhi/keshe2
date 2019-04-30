import 'package:flutter/material.dart';
import 'package:keshe2/model/student.dart';
import 'package:keshe2/pages/students_detail_page.dart';
import 'package:http/http.dart' as http;
import 'package:keshe2/conf/configure.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keshe2/model/course.dart';
import 'package:keshe2/model/attendance.dart';
class kaoqinPage extends StatefulWidget{
Course item;
  @override
  State<StatefulWidget> createState() {
    return _KaoqinState(item: item);
  }
  kaoqinPage({@required this.item});
}
class _KaoqinState extends State<kaoqinPage>{
  Course item;
  List<Attendance> listData = List<Attendance>();
  _KaoqinState({@required this.item});
  List<String> stateList = ["0","1","2","3","4","5"];
  @override
  void initState() {
    super.initState();
    getAttendanceList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
           title: Text("考勤列表-${item.name}"),
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
            subtitle: Text(item.state),
            leading: Icon(Icons.location_on),
            trailing: RaisedButton(
                child: Text("通过"),
                onPressed: (){
                  updateAttendance(item,"3");
                }),
            contentPadding: EdgeInsets.all(10.0),
            enabled: true,
          ),
          onLongPress: (){
              showDialog(context: context,builder: (context){
                return AlertDialog(
                  title: Text("选择等级"),
                  content:
                  Column(
                    mainAxisSize:MainAxisSize.min,
                    children: <Widget>[
                      RaisedButton(
                        child: Text("0"),
                        onPressed: (){
                          Navigator.of(context).pop();
                          updateAttendance(item,"0");
                        },
                      ),
                      RaisedButton(
                        child: Text("1"),
                        onPressed: (){
                          Navigator.of(context).pop();
                          updateAttendance(item,"1");
                        },
                      ),
                      RaisedButton(
                        child: Text("2"),
                        onPressed: (){
                          Navigator.of(context).pop();
                          updateAttendance(item,"2");
                        },
                      ),
                      RaisedButton(
                        child: Text("3"),
                        onPressed: (){
                          Navigator.of(context).pop();
                          updateAttendance(item,"3");
                        },
                      ),
                      RaisedButton(
                        child: Text("4"),
                        onPressed: (){
                          Navigator.of(context).pop();
                          updateAttendance(item,"4");
                        },
                      ),
                      RaisedButton(
                        child: Text("5"),
                        onPressed: (){
                          Navigator.of(context).pop();
                          updateAttendance(item,"5");
                        },
                      ),
                    ],
                  ),
                );
              });
          },
          );
        },
      ),
    );
  }

  void getAttendanceList() async{
    var res = await http.get(Config.SERVER_GETATTENDANCE+"?cid=${item.id}");
    if(res.body!=null){
      listData.clear();
      List<Attendance> list = new List();
      try{
        list = json.decode(res.body);
      }catch(e){
        print(e.toString());
      }
      list.add(Attendance("hfhuaizhi", "hah"));
      listData.addAll(list);
      setState(() {
//
      });
    }
  }

  void updateAttendance(Attendance item,String state) async{
      var res = await http.get(Config.SERVER_UPDATEATTENDANCE+"?aid=${item.aid}&state=$state");
      if(res.body.contains(Config.SUCCESS)){
        setState(() {
          item.state = state;
        });
      }else{
        Fluttertoast.showToast(msg: "考勤失败");
      }
  }

}

