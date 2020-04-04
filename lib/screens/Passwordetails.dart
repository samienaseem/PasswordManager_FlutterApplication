import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:passwordmanager/model/passowrd.dart';

class PasswordDetails extends StatefulWidget{
  @override
  State<StatefulWidget> createState()=> ShowDetails();

}

class ShowDetails extends State{
  @override
  Widget build(BuildContext context) {
      return Scaffold(
        appBar: AppBar(
          title: Text("Hello World"),
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
                            obscureText: true,
                            decoration: InputDecoration(
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
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.save),
          onPressed: null,
          tooltip: "Save",
        ),
      );
  }

}