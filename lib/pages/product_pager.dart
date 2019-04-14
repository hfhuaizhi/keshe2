import 'package:flutter/material.dart';
import 'dart:async';
class ProductPage extends StatefulWidget{
  @override
  _ProductPageState createState() {
    return _ProductPageState();
  }

}
class _ProductPageState extends State<ProductPage>{
  //当前选择页面索引
  @override
  void initState() {
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text("product")
    );
  }

}