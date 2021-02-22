import 'dart:core';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:flutter_db/model/contact.dart';

class DbHelper {
  static DbHelper _dbHelper;
  static Database _database;

  DbHelper._createObject();

  factory DbHelper() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper._createObject();
    }
    return _dbHelper;
  }

  // callback untuk database method
  void _createDb(Database db, int version) async {
    // konfigurasi untuk pembuatan table
    await db.execute('''
      CREATE TABLE contact (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        phone TEXT
      )
    ''');
  }

  Future<Database> initDb() async {
    // Set Directory buat database
    Directory directory = await getApplicationDocumentsDirectory();

    // membuat database
    String path = directory.path + 'contact.db';
    var contactDatabase = openDatabase(path, version: 1, onCreate: _createDb);
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
  }

  // CRUD

  // create
  Future<int> insert(Contact object) async {
    Database db = await this.database;
    int count = await db.insert('contact', object.toMap());
    return count;
  }

  // read
  Future<List<Map<String, dynamic>>> select() async {
    Database db = await this.database;
    var mapList = await db.query('contact', orderBy: 'name');
    return mapList;
  }
}
