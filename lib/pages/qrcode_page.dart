import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';
class QrCodePage extends StatelessWidget{
  String cid;
  QrCodePage(this.cid);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: Center(
          child: QrImage(
            data: "hf"+cid,
            size: 500,
          )
      ),
    );
  }

}