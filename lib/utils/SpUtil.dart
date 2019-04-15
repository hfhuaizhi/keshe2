import 'package:shared_preferences/shared_preferences.dart';

Future setString(String key,String val) async {
  SharedPreferences preferences = await SharedPreferences.getInstance();
  preferences.setString(key, val);
}
Future<String> getString(String key) async{
    SharedPreferences preferences = await SharedPreferences.getInstance();
    var account = preferences.get(key);
    return account;
}