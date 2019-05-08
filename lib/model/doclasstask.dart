class Doclasstask{
int dcid;
int clid;
String sname;
int state;
Doclasstask(this.sname,this.state);
Doclasstask.fromJson(Map json){
  dcid = json['dc_id'];
  clid = json['cl_id'];
  sname = json['s_username'];
  state = json['state'];
}
//public int dc_id;
//  public int cl_id;
//public String s_username;
//public int state;
}