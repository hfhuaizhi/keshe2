import 'package:flutter/material.dart';
import '../model/news.dart';
import '../model/student.dart';



class StudentsDetailPage extends StatelessWidget{
  final Student item;

  StudentsDetailPage({Key key,@required this.item}) : super(key:key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(item.realname),
      ),
      body:  Padding(
        padding: EdgeInsets.all(16.0),
        child: Text(item.clazz),
      ),
    );

  }

}