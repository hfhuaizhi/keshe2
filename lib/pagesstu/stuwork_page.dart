import 'package:flutter/material.dart';
import 'package:barcode_scan/barcode_scan.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:http/http.dart' as http;
import 'package:keshe2/conf/configure.dart';
import 'package:keshe2/conf/GlobalValue.dart';
import 'package:keshe2/model/course.dart';
import 'package:keshe2/pages/about_contact_page.dart';
import 'package:keshe2/pages/about_us_page.dart';
import 'package:keshe2/pages/kaoqin_page.dart';
import 'package:keshe2/pagesstu/page_course_stu.dart';
import 'package:keshe2/utils/SpUtil.dart';
class StuwordPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return _StuwordPageState();
  }
}
class _StuwordPageState extends State<StuwordPage>{
  String barcode = "";
  TextEditingController _idCon = new TextEditingController();
  @override
  initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 60),
            ),
            Container(
              width: 100,
              height: 100,
              child: FloatingActionButton(
                heroTag: "btn1",
                child: Text("签到"),
                onPressed: scan,
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 60),
            ),
            Container(
              width: 100,
              height: 100,
              child: GestureDetector(
                child: FloatingActionButton(
                  heroTag: "btn2",
                  child: Text("交作业"),
                ),
                onTap: (){
                  Navigator.push(context,MaterialPageRoute(builder: (context) => PageCourseStu()));
                },
              ),
            ),
          ],
        ));
  }

  Future scan() async {
    try {
      String barcode = await BarcodeScanner.scan();
      print("res is ++++++++++"+barcode);
      if(barcode.isNotEmpty&&barcode.startsWith("hf")){
        String id = barcode.replaceAll("hf", "");
        checkIn(id);
      }else{
        Fluttertoast.showToast(msg: "课程二维码解析失败");
      }
      setState(() => this.barcode = barcode);
    } on PlatformException catch (e) {
      if (e.code == BarcodeScanner.CameraAccessDenied) {
        setState(() {
          this.barcode = 'The user did not grant the camera permission!';
        });
      } else {
        setState(() => this.barcode = 'Unknown error: $e');
      }
    } on FormatException{
      setState(() => this.barcode = 'null (User returned using the "back"-button before scanning anything. Result)');
    } catch (e) {
      setState(() => this.barcode = 'Unknown error: $e');
    }
  }

  void checkIn(String id) async{
    String username = await getString(GlobalValue.USERNAME);
    var res =await http.get(Config.SERVER_ADDATTENDANCE+"?cid=$id&username=$username");
    if(res.body.isNotEmpty&&res.body.contains(Config.SUCCESS)){
      Fluttertoast.showToast(msg: "签到成功");
    }else{
      Fluttertoast.showToast(msg: "签到失败");

    }

  }

}
