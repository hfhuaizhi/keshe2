import 'package:http/http.dart' as http;
import 'dart:convert';
import '../conf/config.dart';

getProductResult([int page = 0]) async{
  String url = Config.IP+":"+Config.PORT+"/?action=getProducts&page=$page";
  print(url);
  var res = await http.get(url);
  var json = jsonDecode(res.body);
  print(json);
  return json['items'] as List;
}