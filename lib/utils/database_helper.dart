// this is a database helper file. It's main purpose to make
// working with database easy and simple.

import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DBProvider {
  // we called a private constructor and make a static instance and a static
  // database so that there will be only one instance and
  // database during the whole execution
  DBProvider._();
  static final DBProvider instance = DBProvider._();
  static Database _database;

  // making the database table and column name final so we can reference it
  // without the worry of getting a typo
  static final tableName = "khoj_the_search";
  static final userId = "user_id";
  static final timeStamp = "timestamp";
  static final values = "input_data";

  // this function returns a database. If a database exists then it
  // will return that database, otherwise it will create a new database
  // and return that.
  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDB();
    return _database;
  }

  // this function will create a new database with a table
  // with appropriate column names
  Future<Database> _initDB() async {
    return await openDatabase(
        join(await getDatabasesPath(), 'ami_design_pari_na.db'),
        onCreate: (db, version) async {
      await db.execute('''CREATE TABLE $tableName (
          $userId TEXT NOT NULL,
          $timeStamp TEXT NOT NULL,
          $values TEXT NOT NULL
        )'''); // this execute function is used to run SQL code from dart
    }, version: 1);
  }

  // this function takes a table name and a map of data to insert to the table
  Future<int> insert(String tableName, Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(tableName, row);
  }

  // this function query all data from table that's name passed as a argument
  Future<List<Map<String, dynamic>>> queryAll(String tableName) async {
    Database db = await instance.database;
    return await db.query(tableName);
  }

  // this function will drops the table as given table name
  // and creates an empty table there
  Future<void> dropTable(String tableName) async {
    Database db = await instance.database;
    await db.execute('''DROP TABLE $tableName''');
    await db.execute('''CREATE TABLE $tableName (
          $userId TEXT NOT NULL,
          $timeStamp TEXT NOT NULL,
          $values TEXT NOT NULL
      )''');
  }
}
