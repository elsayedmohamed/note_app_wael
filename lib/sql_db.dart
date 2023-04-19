import 'dart:async';
import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SqlDb {
  static Database? _db;

  Future<Database?> get db async {
    if (_db == null) {
      _db = await initialDb();
      return _db;
    } else {
      return _db;
    }
  }

  initialDb() async {
    String dBPath = await getDatabasesPath();
    String path = join(dBPath, 'notes.db');
    Database myDb = await openDatabase(path,
        onCreate: _onCreate, version: 1, onUpgrade: _onUpgrade);
    return myDb;
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''

CREATE TABLE "note" (
     "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
  "title" TEXT NOT NULL,
   "note" TEXT NOT NULL,
  "color" TEXT NOT NULL
   )
''');
    debugPrint('on create ==============================>');
  }

//Read data
  readData(String sql) async {
    Database? myDb = await db;
    List<Map> response = await myDb!.rawQuery(sql);
    return response;
  }

  //Insert data
  Future<int> insertData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawInsert(sql);
    return response;
  }

  // Update data
  Future<int> updateData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawUpdate(sql);
    return response;
  }

  // Delete data
  Future<int> deleteData(String sql) async {
    Database? myDb = await db;
    int response = await myDb!.rawDelete(sql);
    return response;
  }

  FutureOr<void> _onUpgrade(Database db, int oldVersion, int newVersion) {}

  Future deleteDataBase() async {
    String dBPath = await getDatabasesPath();
    String path = join(dBPath, 'notes.db');
    await deleteDatabase(path);
  }
}
