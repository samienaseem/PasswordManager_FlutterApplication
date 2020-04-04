import 'package:passwordmanager/model/passowrd.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class DbHelper{

  static final DbHelper dbhelper=DbHelper._internal();
  String tblPmanager="Passwordmanager";
  String colId="id";
  String colTitle="title";
  String colEmail="email";
  String coldPassword="password";

  DbHelper._internal();

  factory DbHelper(){
    return dbhelper;
  }

  static Database _db;

  Future<Database> get db async{
    if(_db==null){
      _db=await initDatabase();
    }
    return _db;
  }

  Future<Database> initDatabase()async {
    Directory dir=await getApplicationDocumentsDirectory();
    String path=dir.path +"P_Manager.db";
    var manager= await openDatabase(path,version: 1, onCreate: _oncreate);
    return manager;
  }




  FutureOr<void> _oncreate(Database db, int version) async{
    await db.execute("create table $tblPmanager($colId INTEGER PRIMARY KEY, $colTitle TEXT, $colEmail TEXT, $coldPassword TEXT)");
  }

  Future<int> insertEntry(PasswordManger passwordManger)async{
    Database db=await this.db;
    var result= await db.insert(tblPmanager, passwordManger.tomap());
    return result;

  }

  Future<List> getPasswords()async{
    Database db=await this.db;
    var result= await db.rawQuery("select * from $tblPmanager order by $colId DESC");
    return result;

  }

  Future<int> Updatepassword(PasswordManger passwordManger)async{
    Database db=await this.db;
    var result=db.update(tblPmanager, passwordManger.tomap(),
      where:"$colId=?",
      whereArgs:[passwordManger.id],
    );
    return result;
  }

  Future<int> DeletePassoword(int id)async{
    Database db=await this.db;
    var result= await db.rawDelete("delete from $tblPmanager where $colId=$id");
    return result;
  }

  Future<int> DeleteTable()async{
    Database db= await this.db;
    var result=db.delete(tblPmanager);
    return result;
  }

  void AlterTable()async{
    Database db=await this.db;
    db.execute("Alter table $tblPmanager add $colTitle TEXT");
  }


}

