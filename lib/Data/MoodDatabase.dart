import 'package:sqflite/sqflite.dart';

import '../Model/Mood.dart';
import 'package:path/path.dart';

class MoodDatabase {
  static const String tableName = 'moods';

  static final MoodDatabase _instance = MoodDatabase._privateConstructor();

  factory MoodDatabase() {
    return _instance;
  }

  MoodDatabase._privateConstructor();

  Future<Database> open() async {
    final databasePath = await getDatabasesPath();
    final databaseFilePath = join(databasePath, 'mood_database.db');
    return openDatabase(databaseFilePath, version: 1,
        onCreate: (db, version) async {
          await db.execute('''
        CREATE TABLE $tableName (
          id INTEGER PRIMARY KEY,
          name TEXT NOT NULL
        )
      ''');
        });
  }

  Future<int> insertMood(Mood mood) async {
    final db = await open();
    return db.insert(tableName, mood.toMap());
  }

  Future<List<Mood>> getMoods() async {
    final db = await open();
    final maps = await db.query(tableName);
    return List.generate(maps.length, (i) {
      return Mood.fromMap(maps[i]);
    });
  }

  Future<List<Mood>> getMoodsForDay(DateTime day) async {
    final db = await open();
    final maps = await db.query(
      tableName,
      where: 'date = ?',
      whereArgs: [day.toIso8601String().substring(0, 10)],
    );
    return List.generate(maps.length, (i) {
      return Mood.fromMap(maps[i]);
    });
  }

}
