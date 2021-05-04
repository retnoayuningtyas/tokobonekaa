import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'item.dart';
import 'pelanggan.dart';

class DbHelper {
  static DbHelper _dbHelper;
  static Database _database;
  DbHelper._createObject();
  Future<Database> initDb() async {
    //untuk menentukan nama database dan lokasi yg dibuat
    Directory directory = await getApplicationDocumentsDirectory();
    String path = directory.path + 'item.db';

    //create, read databases
    var itemDatabase = openDatabase(path, version: 5, onCreate: _createDb);
    //mengembalikan nilai object sebagai hasil dari fungsinya
    return itemDatabase;
  }

  //buat tabel baru dengan nama item
  void _createDb(Database db, int version) async {
    await db.execute('''
 CREATE TABLE item (
 id INTEGER PRIMARY KEY AUTOINCREMENT,
 name TEXT,
 price INTEGER,
 stock INTEGER
 )
 ''');
 await db.execute('''
        CREATE TABLE pelanggan (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        alamat TEXT,
        nohp INTEGER
        )
    ''');
  }

//select databases
  Future<List<Map<String, dynamic>>> select() async {
    Database db = await this.initDb();
    var mapList = await db.query('item', orderBy: 'name');
    return mapList;
  }

  //create databases
  Future<int> insertItem(Item object) async {
    Database db = await this.initDb();
    int count = await db.insert('item', object.toMap());
    return count;
  }

//update databases
  Future<int> updateItem(Item object) async {
    Database db = await this.initDb();
    int count = await db
        .update('item', object.toMap(), where: 'id=?', whereArgs: [object.id]);
    return count;
  } //delete databases

  Future<int> deleteItem(int id) async {
    Database db = await this.initDb();
    int count = await db.delete('item', where: 'id=?', whereArgs: [id]);
    return count;
  }

  Future<List<Item>> getItemList() async {
    var itemMapList = await select();
    int count = itemMapList.length;
    List<Item> itemList = List<Item>();
    for (int i = 0; i < count; i++) {
      itemList.add(Item.fromMap(itemMapList[i]));
    }
    return itemList;
  }

  Future<List<Map<String, dynamic>>> selectPelanggan() async {
    Database db = await this.initDb();
    var mapList = await db.query('pelanggan', orderBy: 'name');
    return mapList;
  }

  Future<int> insertPelanggan(Pelanggan object) async {
    Database db = await this.initDb();
    int count = await db.insert('pelanggan', object.toMap());
    return count;
  }

//update databases
  Future<int> updatePelanggan(Pelanggan object) async {
    Database db = await this.initDb();
    int count = await db
        .update('pelanggan', object.toMap(), where: 'id=?', whereArgs: [object.id]);
    return count;
  } //delete databases

  Future<int> deletePelanggan(int id) async {
    Database db = await this.initDb();
    int count = await db.delete('pelanggan', where: 'id=?', whereArgs: [id]);
    return count;
  }

  Future<List<Pelanggan>> getPelangganList() async {
    var pelangganMapList = await selectPelanggan();
    int count = pelangganMapList.length;
    List<Pelanggan> pelangganList = List<Pelanggan>();
    for (int i = 0; i < count; i++) {
      pelangganList.add(Pelanggan.fromMap(pelangganMapList[i]));
    }
    return pelangganList;
  }

  factory DbHelper() {
    if (_dbHelper == null) {
      _dbHelper = DbHelper._createObject();
    }
    return _dbHelper;
  }
  Future<Database> get database async {
    if (_database == null) {
      _database = await initDb();
    }
    return _database;
  }
}
