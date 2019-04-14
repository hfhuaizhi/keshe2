import 'package:flutter/material.dart';
import 'dart:async';
import 'home_banner.dart';
import '../services/product.dart';
import '../model/product.dart';
class HomePage extends StatefulWidget{
  @override
  _HomePageState createState() {
    return _HomePageState();
  }

}
class _HomePageState extends State<HomePage>{
  ProductListModel listData = ProductListModel([]);
  //当前选择页面索引
  @override
  void initState() {
    super.initState();
    getProductList();
  }
  void getProductList()  async{
    var data = await getProductResult();
    ProductListModel list = ProductListModel.fromJson(data);
    setState(() {
      listData.data.addAll(list.data);
    });
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          BannerWidget(),
          RaisedButton(
            child: Text('获取产品数据'),
            onPressed: (){
              getProductResult();
            },
          )
        ],
      ),
    );
  }

}