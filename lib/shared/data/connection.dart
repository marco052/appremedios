import 'dart:async';
import 'dart:convert';

import 'package:path/path.dart';
import 'package:pharmacy_wiki/shared/classes/scheduled_medicine.dart';
import 'package:pharmacy_wiki/shared/classes/user.dart';
import 'package:sqflite/sqflite.dart';


class Connection {

  Future<Database> startConnection() async {
    Database database = await openDatabase(
      join(await getDatabasesPath(), 'pharmacy_wiki.db'),
      onCreate: (db, version) async {
        await db.execute("CREATE TABLE user(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, alias TEXT NOT NULL, value TEXT)");
        await db.execute("CREATE TABLE medicine(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, name TEXT NOT NULL, quantity INTEGER, type TEXT, frequency TEXT, reason INTEGER NULL)");
        await db.execute("INSERT INTO user(alias, value) VALUES ('NAME', ''), ('BIRTHDAY', ''), ('SEX', ''), ('HEIGHT', ''), ('WEIGHT', '')");
      },
      version: 2
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

  Future<List<ScheduledMedicine>> getMedicines() async {
    final db = await startConnection();
    final List<Map<String, dynamic>> maps = await db.query('medicine');

    JsonDecoder jsonDecoder = new JsonDecoder();

    return List.generate(maps.length, (i) {

      return ScheduledMedicine(
        id: maps[i]['id'],
        name: maps[i]['name'],
        type: maps[i]['type'],
        quantity: maps[i]['quantity'],
        frequency: Frequency.fromJson(jsonDecoder.convert(maps[i]['frequency'])),
        reason: maps[i]['reason']
      );
    });
  }

  Future<void> insertMedicine(ScheduledMedicine medicine) async {
  final db = await startConnection();

  await db.insert(
    'medicine',
    medicine.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
}


  Future<void> updateUserInfo(User user) async {
    final db = await startConnection();
    await db.update('user', user.toMap(), where: 'id = ?', whereArgs: [user.id]);
  } 



}

