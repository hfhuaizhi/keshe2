import 'package:flutter/material.dart';
import 'home_banner.dart';
import '../services/product.dart';
import '../model/product.dart';
import 'home_product_page.dart';


class HomePage extends StatefulWidget{
  @override
  HomePageState createState() => HomePageState();
}

class HomePageState extends State<HomePage>{

  ProductListModal listData = ProductListModal([]);

  void getProductList() async{
    var data = await getProductResult();
    ProductListModal list = ProductListModal.fromJson(data);

    setState(() {
      listData.data.addAll(list.data);
    });

  }

  @override
  void initState(){
    getProductList();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: <Widget>[
          BannerWidget(),
          Column(
            children: <Widget>[
              Text("培训管理\系统"),
              Text("功能\n"
                "1.实现培训机构有效地管理学生的考勤情况\n"
                "2.以及学生作业提交情况\n"
                "3.平时表现情况,方便老师与家长之间的信息沟通\n"
                "4.可以通过信息统计,把学生在培训课上的表现情况进行有效分析,为其努力方向提供有意义的参考")
            ],
          )
        ],
      ),
    );
  }

}