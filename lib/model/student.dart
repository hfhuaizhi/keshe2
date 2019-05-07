class Student {
  int s_id;
  String s_username;
  String s_password;
  String s_realname;
  String s_class;
  Student({this.s_id,this.s_username,this.s_password,this.s_realname,this.s_class});
  factory Student.fromJson(Map<String, dynamic> json){
    return Student(
        s_id:json['s_id'],
        s_username:json['s_username'],
      s_password:json['s_password'],
      s_realname:json['s_realname'],
      s_class:json['s_class'],
    );
  }
}
//public int s_id;
//public String s_username;
//public String s_password;
//public String s_realname;
//public String s_class;