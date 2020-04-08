import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passwordmanager/model/passowrd.dart';
import 'package:passwordmanager/DbHelper/dbhelper.dart';
import 'package:passwordmanager/DbHelper/dbshelper.dart';
import 'package:rflutter_alert/rflutter_alert.dart';
import 'package:shared_preferences/shared_preferences.dart';


final List<String> choices=const <String>[
  "Save & Back",
  "Delete",
  "Back"
];
const menusave="Save & Back";
const menudelete="Delete";
const menuback="Back";

DbsHelper helper=DbsHelper();

class PasswordDetails extends StatefulWidget{
  final PasswordManger pms;
  PasswordDetails(this.pms);
  @override
  State<StatefulWidget> createState()=> ShowDetails(pms);

}

class ShowDetails extends State{
  String getPassword;
  bool passwordVar;


  PasswordManger pm;
  ShowDetails(this.pm);
  final key = new GlobalKey<ScaffoldState>();
  TextEditingController title=TextEditingController();
  TextEditingController username=TextEditingController();
  TextEditingController password=TextEditingController();
  TextEditingController passwordController=TextEditingController();
  @override
  Widget build(BuildContext context) {

    debugPrint("hello widget");
    debugPrint(passwordVar.toString());

    title.text=pm.title;
    username.text=pm.email;
    password.text=pm.password;

    //debugPrint(pm.email);
    //debugPrint(pm.password);
      return Scaffold(
        appBar: AppBar(
          title: Text(pm.title),
          actions: <Widget>[
            PopupMenuButton<String>(
              onSelected: select,
              itemBuilder: (BuildContext context){
                return choices.map((String value){
                  return PopupMenuItem(
                    value: value,
                    child: Text(value),
                  );
                }).toList();
              },
            )
          ],
        ),
        body: ListView(
          children: <Widget>[
              Padding(
                padding: EdgeInsets.only(
                  top: 30.0,
                  left: 15.0,
                  right: 15.0,
                  bottom: 20.0
                ),
                child: Container(
                  child:Column(
                    children: <Widget>[
                      Padding(
                        padding: EdgeInsets.only(
                          bottom: 15.0
                        ),
                          child:TextFormField(
                            onChanged: (value)=>this.updateTitle(value),
                            controller: title,
                            autofocus: true,
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(20.0),
                          labelText: "Title",labelStyle: TextStyle(
                            color: Colors.black,fontWeight: FontWeight.w800, letterSpacing: 3,
                          fontSize: 18.0,

                        ),
                          hintText: "Ex: Gmail, facebook",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0)
                          )
                        ),
                      )),
                      Padding(
                          padding: EdgeInsets.only(
                              bottom: 15.0
                          ),
                          child:TextFormField(
                            onChanged: (value)=>this.updateEmail(value),
                            controller: username,
                            decoration: InputDecoration(
                                contentPadding: EdgeInsets.all(20.0),
                                labelText: "Username",
                                labelStyle: TextStyle(
                              color: Colors.black,fontWeight: FontWeight.w800, letterSpacing: 3,
                              fontSize: 18.0,

                            ),
                                hintText: "Ex: @gmail.com, example123",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0)
                                )
                            ),
                          )),
                      Padding(
                          padding: EdgeInsets.only(
                              bottom: 15.0
                          ),
                          child:TextFormField(
                            onChanged: (value)=>this.updatePassword(value),
                            controller: password,
                            obscureText: passwordVar? true:false,
                            decoration: InputDecoration(
                              suffixIcon: IconButton(
                                icon: Icon(passwordVar? Icons.visibility_off : Icons.visibility),                    //PASSWORD TEXT FIELD
                                onPressed: (){
                                  setState(() {
                                    ChangeState();

                                  });
                                  //ChangeState();


                                },
                              ),
                                contentPadding: EdgeInsets.all(20.0),
                                labelText: "Password",labelStyle: TextStyle(
                              color: Colors.black,fontWeight: FontWeight.w800, letterSpacing: 3,
                              fontSize: 18.0,

                            ),
                                hintText: "Your Password",
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(15.0)
                                )
                            ),
                          )),

                    ],
                  ),
                ),
              )
          ],

        ),
        floatingActionButton: Builder(
          builder: (BuildContext context){

            return FloatingActionButton(
          child: Icon(Icons.save),
          onPressed: (){
            save();

          },
          tooltip: "Save",
        );}),
      );
  }

  /*void saveandback() {
    PasswordManger p=new PasswordManger(title.text, username.text, password.text);
    helper.insertEntry(p);
    Navigator.pop(context,true);

  }*/


  void select(String value)async {
    int result;
    switch(value){
      case menusave:
        save();
        break;

      case menudelete:
        break;

      case menuback:
        Navigator.pop(context,true);
        break;
    }
  }

  void save() {
    //pm.title=title.text;
    //pm.email=username.text;
    //pm.password=password.text;
    if(pm.id!=null){
      helper.Updatepassword(pm);
      //ShowAlertBox(context, "Enter passowrd to save changes");
    }
    else{
      helper.insertEntry(pm);
    }
    Navigator.pop(context,true);
  }

  @override
  void initState() {
    debugPrint("init");
    passwordVar=true;
    getPrefrencedata();

  }

  void updateTitle(String value) {
    pm.title=value;
  }
  void updateEmail(String value) {
    pm.email=value;
  }
  void updatePassword(String value) {
    pm.password=value;
  }

  void ShowAlertBox(BuildContext context,String msg) {
    bool flag=true;
    final _formKey = GlobalKey<FormState>();
    var alertStyle = AlertStyle(
      animationType: AnimationType.fromBottom,
      isCloseButton: true,
      isOverlayTapDismiss: false,
      descStyle: TextStyle(fontWeight: FontWeight.bold),
      animationDuration: Duration(milliseconds: 400),
      alertBorder: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10.0),
        side: BorderSide(
          color: Colors.grey,
        ),
      ),
      titleStyle: TextStyle(
        color: Colors.black,
      ),
    );

    Alert(
        context: context,
        style: alertStyle,
        title: msg,
        content: Form(
          key: _formKey,
          child: Column(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.only(bottom: 0.0,top: 12.0),
                  child:TextFormField(
                    controller: passwordController,
                    validator: (value){
                      if(value.isEmpty){
                        return "please enter your password";
                      }
                      else {
                         //getPrefrencedata();
                        // debugPrint(getPassword+"111222");
                         if(getPassword==passwordController.text){
                           flag=false;
                           return null;

                         }
                         else{
                         //  debugPrint(getPassword+"111");
                           return "Password is incorrect";
                         }
                         /*else{
                           passwordVar=true;
                           debugPrint(passwordVar.toString()+"21121212");
                         }*/

                      }
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      labelText: "Password",
                    ),
                  )),


            ],
          ),
        ),
        buttons: [
          DialogButton(
            color: Colors.black,
            child: Text("Cancel",style: TextStyle(
              color: Colors.white,
              fontSize: 18.0,
              fontWeight: FontWeight.w700,
              letterSpacing: 2.0
            ),),
            onPressed: (){
              Navigator.pop(context);
            },
          ),
          DialogButton(
            child: Text("ok",style: TextStyle(
                color: Colors.white,
                fontSize: 18.0,
                letterSpacing: 2.0,
                fontWeight: FontWeight.w700
            ),),
            onPressed: () {
              if(_formKey.currentState.validate()){
              //  passwordVar=!passwordVar;
                //ChangeState();
              Navigator.pop(context);


              }
            },
          ),
        ]
    ).show();







  }

  Future<void> getPrefrencedata() async{
   final sh=await SharedPreferences.getInstance();
   getPassword=await sh.getString('passwordApp');
   debugPrint(getPassword);


  }

  void ChangeState()async {
    if(pm.id!=null && passwordVar){
      passwordController.text="";

      //passwordVar=!passwordVar;

      /* if(passwordController.text==getPassword){
         passwordVar=!passwordVar;
         debugPrint(passwordVar.toString());
       }*/
      /* else{*/

         final _formKey = GlobalKey<FormState>();
         var alertStyle = AlertStyle(
           animationType: AnimationType.fromBottom,
           isCloseButton: true,
           isOverlayTapDismiss: false,
           descStyle: TextStyle(fontWeight: FontWeight.bold),
           animationDuration: Duration(milliseconds: 400),
           alertBorder: RoundedRectangleBorder(
             borderRadius: BorderRadius.circular(10.0),
             side: BorderSide(
               color: Colors.grey,
             ),
           ),
           titleStyle: TextStyle(
             color: Colors.black,
           ),
         );

         await Alert(
             context: context,
             style: alertStyle,
             title: "Enter password",
             content: Form(
               key: _formKey,
               child: Column(
                 children: <Widget>[
                   Padding(
                       padding: EdgeInsets.only(bottom: 0.0,top: 12.0),
                       child:TextFormField(
                         controller: passwordController,
                         validator: (value){
                           if(value.isEmpty){
                             return "please enter your password";
                           }
                           else {
                             //getPrefrencedata();
                             // debugPrint(getPassword+"111222");
                             if(getPassword==passwordController.text){
                               //flag=false;
                               setState(() {
                                 passwordVar=false;
                               });

                               debugPrint(passwordVar.toString());
                               build(context);
                               return null;

                             }
                             else{
                               //  debugPrint(getPassword+"111");
                               return "Password is incorrect";
                             }
                             /*else{
                           passwordVar=true;
                           debugPrint(passwordVar.toString()+"21121212");
                         }*/

                           }
                         },
                         decoration: InputDecoration(
                           border: OutlineInputBorder(
                             borderRadius: BorderRadius.circular(10.0),
                           ),
                           labelText: "Password",
                         ),
                       )),


                 ],
               ),
             ),
             buttons: [
               DialogButton(
                 color: Colors.black,
                 child: Text("Cancel",style: TextStyle(
                     color: Colors.white,
                     fontSize: 18.0,
                     fontWeight: FontWeight.w700,
                     letterSpacing: 2.0
                 ),),
                 onPressed: (){
                   Navigator.pop(context);
                 },
               ),
               DialogButton(
                 child: Text("ok",style: TextStyle(
                     color: Colors.white,
                     fontSize: 18.0,
                     letterSpacing: 2.0,
                     fontWeight: FontWeight.w700
                 ),),
                 onPressed: () {
                   if(_formKey.currentState.validate()){


                     //  passwordVar=!passwordVar;
                     //ChangeState();

                     Navigator.pop(context);



                   }
                 },
               ),
             ]
         ).show();


        // ShowAlertBox(context,"Enter Password");
      // }

    }
    else{
      passwordVar=!passwordVar;
    }
  }
}