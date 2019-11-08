
import 'dart:io';

import 'package:flutter_crud/models/user.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBProvider{

  static Database _database;
  static final DBProvider db = DBProvider._private();

  final String USER_TABLE= 'users';

  DBProvider._private();

  Future<Database> get database async{
    if(_database != null) return _database;

    _database = await initDatabase();
    return _database;
  }

  initDatabase() async{
    Directory appDirectory = await getApplicationDocumentsDirectory();
    final String path = join(appDirectory.path,'users.db');

    return await openDatabase(
        path,
        version: 1,
        onOpen: (db){},
        onCreate: (Database db, int version)async{
          await db.execute(
            'CREATE TABLE ${USER_TABLE} (id INTEGER PRIMARY KEY AUTOINCREMENT,'
                ' nombre  VARCHAR NOT NULL ,'
                ' ciudad  VARCHAR NOT NULL)');
        });
  }

  Future<int> addUser(User user) async{
    final db = await database;

//    final userId = await db.rawInsert(
//        'INSERT INTO users (id,nombre) VALUES (${user.id},${user.nombre})');
//    final userId = await db.rawInsert(
//        'INSERT INTO users (id,nombre) VALUES (?,?)',[user.id,user.nombre]);


    final userId = await db.insert(USER_TABLE, user.toMap());
    return userId;
  }

  Future<List<User>> listaUsers() async {
    final db = await database;

    final results = await db.query(USER_TABLE);

    List<User> users = results.isNotEmpty
        ? results.map((user) => User.fromMap(user)).toList()
        : [];
    return users;
  }

  Future<int> deleteAllUsers() async {
    final db = await database;

    final result = await db.delete('users');
    return result;
  }

}
