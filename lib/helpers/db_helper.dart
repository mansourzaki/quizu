import 'dart:developer';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import '../models/score.dart';

class DbHelper {
  DbHelper._();
  static DbHelper dbHelper = DbHelper._();
  static const String tableName = 'scores';
  static const String scoreIdColumName = 'id';
  static const String scoreDateColumName = 'date';
  static const String scoreColumName = 'score';
  Database? database;
  initDatabase() async {
    database = await createConnectionWithDatabase();
  }

  Future<Database> createConnectionWithDatabase() async {
    String databasePath = await getDatabasesPath();
    String databaseName = 'scores.db';
    String fullPath = join(databasePath, databaseName);
    Database database =
        await openDatabase(fullPath, version: 1, onCreate: (db, i) {
      log('hello, the database has been created');

      db.execute('''
 CREATE TABLE $tableName (
  $scoreIdColumName INTEGER PRIMARY KEY AUTOINCREMENT,
   $scoreDateColumName TEXT,
    $scoreColumName INTEGER)
''');
    }, onOpen: (db) async {
      final tables =
          await db.rawQuery('SELECT name FROM sqlite_master ORDER BY name;');
      log(tables.toString());
    });
    return database;
  }

  insertNewScroe(Score score) async {
    int rowIndex = await database!
        .insert(tableName, {'date': score.date!.toIso8601String(), 'score': score.score});
    log(rowIndex.toString());
  }

  Future<List<Score>> selectAllScores() async {
    List<Map<String, Object?>> rowsAsMaps = await database!.query(tableName);
    List<Score> scores = rowsAsMaps.map((e) => Score.fromMap(e)).toList();
    return scores;
  }

  Future deleteAll() async {
    //List<Map<String, Object?>> rowsAsMaps = await database!.query(tableName);
    await database!.delete(tableName);
  }
}
