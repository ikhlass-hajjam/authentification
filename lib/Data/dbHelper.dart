import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;

import '../Model/UserModel.dart';


class DbHelper{
  late Database _db;

  static const DB_Name='test.db';
  static const String Table_User='user';
  static const int Version=1;

  static const String C_UserID='user_id';
  static const String C_UserName='user_name';
  static const String C_Email='email';
  static const String C_Password='password';

  // create DB functions

  Future<Database> get db async{
    if(_db!=null){
      return _db;
    }
    _db= await initDb();
    return _db;
  }

  initDb() async{
    io.Directory documentsDirectory= await getApplicationDocumentsDirectory();
    String path=join(documentsDirectory.path, DB_Name);
    var db =await openDatabase(path, version: Version, onCreate: _onCreate);
    return db;
  }

  _onCreate(Database db, int intVersion) async{
    await db.execute("CREATE TABELE $Table_User("
        "$C_UserID TEXT, "
        "$C_UserName TEXT, "
        "$C_Email TEXT, "
        "$C_Password TEXT, "
        "PRIMARY KEY ($C_UserID)"
        ")");
  }

  Future<int> saveData(UserModel user) async {
    var dbClient = await db;
    var res = await dbClient.insert(Table_User, user.toMap());
    return res;
  }

  Future<UserModel> getLoginUser(String userId, String password) async {
    var dbClient = await db;
    var res = await dbClient.rawQuery("SELECT * FROM $Table_User WHERE "
        "$C_UserID = '$userId' AND "
        "$C_Password = '$password'");

    if (res.length > 0) {
      return UserModel.fromMap(res.first);
    }

    return Future.error('User not found');
  }

  Future<int> updateUser(UserModel user) async {
    var dbClient = await db;
    var res = await dbClient.update(Table_User, user.toMap(),
        where: '$C_UserID = ?', whereArgs: [user.user_id]);
    return res;
  }

  Future<int> deleteUser(String user_id) async {
    var dbClient = await db;
    var res = await dbClient
        .delete(Table_User, where: '$C_UserID = ?', whereArgs: [user_id]);
    return res;
  }


}