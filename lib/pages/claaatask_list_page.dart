import 'package:flutter/material.dart';
import 'package:keshe2/model/ClassTask.dart';
import 'package:keshe2/model/student.dart';
import 'package:keshe2/pages/students_detail_page.dart';
import 'package:http/http.dart' as http;
import 'package:keshe2/conf/configure.dart';
import 'dart:convert';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:keshe2/model/course.dart';
import 'package:keshe2/model/doclasstask.dart';
class ClassTaskListPage extends StatefulWidget{
ClassTask item;
  @override
  State<StatefulWidget> createState() {
    return _ClassTaskListState(item: item);
  }
  ClassTaskListPage(this.item);
}
class _ClassTaskListState extends State<ClassTaskListPage>{
  ClassTask item;
  List<Doclasstask> listData = List<Doclasstask>();
  _ClassTaskListState({@required this.item});
  List<String> stateList = ["0","1","2","3","4","5"];
  @override
  void initState() {
    super.initState();
    getClassTaskList();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
           title: Text("作业列表-${item.name}"),
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
          Doclasstask item = listData[index];
          return GestureDetector(
            child: ListTile(
            title: Text(item.sname),
            subtitle: Text(item.state.toString()),
            leading: Icon(Icons.fiber_new),
            trailing: Offstage(
              offstage: item.state>0?true:false,
              child:RaisedButton(
                  child: Text("通过"),
                  onPressed: (){
                    updateAttendance(item,"3");
                  }),
            ),
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

  void getClassTaskList() async{
    print(item.id.toString());
    var res = await http.get(Config.SERVER_SEARCHCLASSTASK+"?cid=${item.id}");
    if(res.body!=null){
      listData.clear();
      List<Doclasstask> list = new List();
      try{
        List tmpList = json.decode(res.body);
        tmpList.forEach((tmp){
          list.add(Doclasstask.fromJson(tmp));
        });
      }catch(e){
        print(e.toString());
      }
      setState(() {
        listData.clear();
        listData.addAll(list);
//
      });
    }
  }

  void updateAttendance(Doclasstask item,String state) async{
      var res = await http.get(Config.SERVER_UPDATECLASSTASK+"?dcid=${item.dcid}&state=$state");
      if(res.body.contains(Config.SUCCESS)){
        setState(() {
          item.state = int.parse(state);
        });
      }else{
        Fluttertoast.showToast(msg: "批改作业失败");
      }
  }

}

