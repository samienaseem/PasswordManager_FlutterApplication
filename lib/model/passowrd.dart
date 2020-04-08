class PasswordManger{
   int _id;
   String _title;
  String _email;
  String _password;

  PasswordManger(this._title, this._email, this._password);

  PasswordManger.WithId(this._id,this._title,this._email,this._password);

  Map<String, dynamic> tomap(){
    var map=new Map<String,dynamic>();
    map["title"]=_title;
    map["email"]=_email;
    map["password"]=_password;

    if(_id!=null){
      map['id']=_id;
    }
    return map;
  }

  PasswordManger.FromObject(dynamic o){

    this._id=o['id'];
    this._title=o['title'];
    this._email=o['email'];
    this._password=o['password'];

  }

   String get password => _password;

   set password(String value) {
     _password = value;
   }

   String get email => _email;

   set email(String value) {
     _email = value;
   }

   int get id => _id;

   set id(int value) {
     _id = value;
   }

   String get title => _title;

   set title(String value) {
     _title = value;
   }





}