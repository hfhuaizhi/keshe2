class Attendance{
int aid;
int cid;
int sid;
String sname;
int state;
Attendance.fromJson(Map json){
  aid = json['a_id'];
  cid = json['c_id'];
  sid = json['s_id'];
  sname = json['s_name'];
  state = json['state'];
}
//public int a_id;
//public int c_id;
//public int s_id;
//public String s_name;
//public int state;
}