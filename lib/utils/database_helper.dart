import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:async';
import 'package:path_provider/path_provider.dart';
import 'dart:io' as io;
import 'package:synchronized/synchronized.dart';

class DatabaseHelper {
  static Database _db;
  DatabaseHelper.internal();
  final _lock = new Lock();

  String sqlCreate = '''
  create table if not exists list(
    id INTEGER PRIMARY KEY AUTOINCREMENT, 
    income TEXT, 
    outcome TEXT, 
    date TEXT 
    )
  ''';

  Future<Database> getDb() async {
    if (_db == null) {
      io.Directory documentDirectory = await getApplicationDocumentsDirectory();

      String path = join(documentDirectory.path, 'money.db');
      print(path);

      await _lock.synchronized(() async {
        if (_db == null) {
          _db = await openDatabase(path, version: 1);
        }
      });
    }

    return _db;
  }

  Future initDatabase() async {
    var dbClient = await getDb();
    // Create table
    await dbClient.rawQuery(sqlCreate);
    print('Table is created');
  }

  Future getList() async {
    var dbClient = await getDb();
    var sql = '''
    SELECT income,outcome,substr(date, 1, 2) as day,substr(date, 4, 2) as month,substr(date, 7, 4) as year,date from list
    ''';
    return await dbClient.rawQuery(sql);
  }

  Future getDetail(int id) async {
    var dbClient = await getDb();
    var sql = '''
    SELECT * FROM list where id=?
    ''';
    return await dbClient.rawQuery(sql, [id]);
  }

  Future removeDb() async {
    io.Directory documentDirectory = await getApplicationDocumentsDirectory();

    String path = join(documentDirectory.path, 'money.db');
    deleteDatabase(path);

    print('Remove Database ok!!!');
  }

  Future getSum() async {
    var dbClient = await getDb();
    var sql = '''
    SELECT SUM(income) as sum FROM list
    ''';
    return await dbClient.rawQuery(sql);
  }

  Future getOutcomeSum() async {
    var dbClient = await getDb();
    var sql = '''
    SELECT SUM(outcome) as sum FROM list
    ''';
    return await dbClient.rawQuery(sql);
  }

  Future getBalance() async {
    var dbClient = await getDb();
    var sql = '''
    SELECT SUM(income)- SUM(outcome) as sum FROM list
    ''';
    return await dbClient.rawQuery(sql);
  }

  Future remove(int id) async {
    var dbClient = await getDb();
    var sql = '''
    DELETE from list where id=?
    ''';
    return await dbClient.rawQuery(sql, [id]);
  }

  Future saveData(Map list) async {
    var dbClient = await getDb();
    String sql = '''
    INSERT INTO list(income,outcome,date)
    VALUES(?,?,?)
    ''';
    // Create table
    await dbClient.rawQuery(sql, [
      list['income'],
      list['outcome'],
      list['date'],
    ]);
    print('database save');
  }

  Future saveoutcome(Map list) async {
    var dbClient = await getDb();
    String sql = '''
    INSERT INTO list(income,outcome,date)
    VALUES(?,?,?)
    ''';
    // Create table
    await dbClient.rawQuery(sql, [
      list['income'],
      list['outcome'],
      list['date'],
    ]);
    print('database outcome save');
  }

  Future updateData(Map list) async {
    var dbClient = await getDb();
    String sql = '''
    UPDATE list SET income=?,outcome=?,date=?
    WHERE id=?
    ''';
    // Create table
    await dbClient.rawQuery(sql, [
      list['income'],
      list['outcome'],
      list['date'],
    ]);
    print('update!!!!!');
  }
}
