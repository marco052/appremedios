import 'dart:async';

import 'package:path/path.dart';
import 'package:pharmacy_wiki/shared/classes/user.dart';
import 'package:sqflite/sqflite.dart';


class Connection {

  Future<Database> startConnection() async {
    Database database = await openDatabase(
      join(await getDatabasesPath(), 'pharmacy_wiki.db'),
      onCreate: (db, version) async {
        await db.execute("CREATE TABLE user(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, alias TEXT NOT NULL, value TEXT)");
        await db.execute("CREATE TABLE medicine(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT NOT NULL, quantity INTEGER, type TEXT, frequency TEXT)");
        await db.execute("INSERT INTO user(alias, value) VALUES ('NAME', ''), ('BIRTHDAY', ''), ('SEX', ''), ('HEIGHT', ''), ('WEIGHT', '')");
      },
      version: 1
    );

    return database;
  }


  Future<List<User>> getUserInfo() async {
    final db = await startConnection();
    final List<Map<String, dynamic>> maps = await db.query('user');
    return List.generate(maps.length, (i) {
      return User(
        id: maps[i]['id'],
        alias: maps[i]['alias'],
        value: maps[i]['value'],
      );
    });
  }


  Future<void> updateUserInfo(User user) async {
    final db = await startConnection();
    await db.update('user', user.toMap(), where: 'id = ?', whereArgs: [user.id]);
  } 



}

