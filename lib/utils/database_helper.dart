import 'package:sqflite/sqflite.dart';
import 'package:sqflite/sqlite_api.dart';
import 'package:path/path.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider instance = DBProvider._();
  static Database _database;

  static final tableName = "khoj_the_search";
  static final userId = "user_id";
  static final timeStamp = "timestamp";
  static final values = "input_data";

  Future<Database> get database async {
    if (_database != null) return _database;

    _database = await _initDB();
    return _database;
  }

  Future<Database> _initDB() async {
    return await openDatabase(
        join(await getDatabasesPath(), 'ami_design_pari_na.db'),
        onCreate: (db, version) async {
      await db.execute('''CREATE TABLE $tableName (
          $userId TEXT NOT NULL,
          $timeStamp TEXT NOT NULL,
          $values TEXT NOT NULL,
        )''');
    }, version: 1);
  }

  Future<int> insert(String tableName, Map<String, dynamic> row) async {
    Database db = await instance.database;
    return await db.insert(tableName, row);
  }

  Future<List<Map<String, dynamic>>> queryAll(String tableName) async {
    Database db = await instance.database;
    return await db.query(tableName);
  }
}
