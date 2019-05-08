class ClassTask{
int id;
String name;
String content;
int cid;
ClassTask(this.name,this.content);
ClassTask.fromJson(Map json){
  id=json['ct_id'];
  name=json['ct_name'];
  content=json['ct_content'];
  cid=json['c_id'];
}
//public int ct_id;
//public String ct_name;
//public String ct_content;
//public int c_id;
}