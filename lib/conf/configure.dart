class Config{

  static const String IP = '10.167.138.24';
  static const String PORT = '8080';
  static const String APPNAME = '/keshe';
  static const String SERVER_ADDRESS = "http://"+IP+":"+PORT+APPNAME;
  //static const String SERVER_ADDRESS = "http://www.baidu.com";
  static const String SERVER_LOGIN = SERVER_ADDRESS+"/login";
  static const String SERVER_STULOGIN = SERVER_ADDRESS+"/stulogin";
  static const String SERVER_REGIST = SERVER_ADDRESS+"/regist";

  static const String SERVER_GETSTUDENT = SERVER_ADDRESS+"/getstu";
  static const String SERVER_SEARCHSTU = SERVER_ADDRESS+"/searchstu";
  static const String SERVER_UPDATESTU = SERVER_ADDRESS+"/updatestu";
  static const String SERVER_ADDSTU = SERVER_ADDRESS+"/addstu";
  static const String SERVER_DELETESTU = SERVER_ADDRESS+"/deletestu";
  static const String SERVER_GETSTUBYUSERNAME = SERVER_ADDRESS+"/getstubyusername";

  static const String SERVER_UPDATECLASSTASK = SERVER_ADDRESS+"/updateclasstask";
  static const String SERVER_ADDCLASSTASK = SERVER_ADDRESS+"/addclasstask";
  static const String SERVER_DELETECLASSTASK = SERVER_ADDRESS+"/deleteclasstask";
  static const String SERVER_SEARCHCLASSTASK = SERVER_ADDRESS+ "/searchclasstask";

  static const String SERVER_DOMYCLASSTASK = SERVER_ADDRESS+"/domyclasstask";
  static const String SERVER_DELETEMYCLASSTASK = SERVER_ADDRESS+"/deletemyclasstask";
  static const String SERVER_UPDATEMYCLASSTASK = SERVER_ADDRESS+"/updatemyclasstask";
  static const String SERVER_GETDCLBYCLID = SERVER_ADDRESS+"/getdclbyclid";
  static const String SERVER_GETCOURSEBYSTU = SERVER_ADDRESS+"/getcoursebystu";

  static const String SERVER_ADDCOURSE = SERVER_ADDRESS+"/addcourse";
  static const String SERVER_DELETECOURSE = SERVER_ADDRESS+"/deletecourse";
  static const String SERVER_SEARCHCOURSE = SERVER_ADDRESS+"/searchcourse";
  static const String SERVER_UPDATECOURSE = SERVER_ADDRESS+"/updatecourse";
  static const String SERVER_GETCOURSEBYTUSERNAME = SERVER_ADDRESS+"/getcoursebyusername";

  static const String SERVER_ADDATTENDANCE = SERVER_ADDRESS+"/addattendance";
  static const String SERVER_UPDATEATTENDANCE = SERVER_ADDRESS+"/updateattendance";
  static const String SERVER_GETATTENDANCE = SERVER_ADDRESS+"/getattendance";

  static const String SERVER_ADDCOMMENT = SERVER_ADDRESS+"/addcomment";
  static const String SERVER_DELETECOMMENT = SERVER_ADDRESS+"/deletecomment";

  //------------------

  static const String SUCCESS = "success";
  static const String ERROR = "error";


}