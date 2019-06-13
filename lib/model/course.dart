class Course{
int id;
String name;
String time;
Course(){
  id=0;
  name="test";
  time="test";
}
Course.fromJson(Map json){
  id = json['c_id'];
  name = json['c_name'];
  time = json['c_time'];
}
}
//public int c_id;
//public String c_name;
//public String c_time;