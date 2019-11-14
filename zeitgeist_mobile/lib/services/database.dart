import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import '../model/time.dart';
import 'package:path/path.dart';

class TimesDatabaseService {
  String path;

  TimesDatabaseService._();

  static final TimesDatabaseService db = TimesDatabaseService._();

  Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    // if _database is null we instantiate it
    _database = await init();
    return _database;
  }

  init() async {
    String path = await getDatabasesPath();
    path = join(path, 'times.db');
    print("Entered path $path");

    return await openDatabase(path, version: 1,
        onCreate: (Database db, int version) async {
      await db.execute(
          'CREATE TABLE Times (_id INTEGER PRIMARY KEY, title TEXT, date TEXT, points INTEGER, timeInMinutes INTEGER);');
      print('New table created at $path');
    });
  }

  Future<List<TimesModel>> getTimesFromDB() async {
    final db = await database;
    List<TimesModel> timesList = [];
    List<Map> maps = await db.query('Times',
        columns: ['_id', 'title', 'date', 'points', 'timeInMinutes']);
    if (maps.length > 0) {
      maps.forEach((map) {
        timesList.add(TimesModel.fromMap(map));
      });
    }
    print("fetch times");
    return timesList;
  }

  Future<List<TimesModel>> getTimeWithId(timeId) async {
    final db = await database;
    List<TimesModel> timesList = [];
    List<Map> maps = await db.query('Times',
        where: '_id = ?',
        whereArgs: [timeId],
        columns: ['_id', 'title', 'date', 'points', 'timeInMinutes']);
    if (maps.length > 0) {
      maps.forEach((map) {
        timesList.add(TimesModel.fromMap(map));
      });
    }
    return timesList;
  }

  updateTimeInDB(TimesModel updatedTime) async {
    final db = await database;
    await db.update('Times', updatedTime.toMap(),
        where: '_id = ?', whereArgs: [updatedTime.id]);
    print('Time updated: ${updatedTime.title} ${updatedTime.timeInMinutes}');
  }

  Future<int> getPointsFromDB() async {
    final db = await database;
    List<TimesModel> timesList = [];
    List<Map> maps = await db.query('Times',
        columns: ['_id', 'title', 'date', 'points', 'timeInMinutes']);
    if (maps.length > 0) {
      maps.forEach((map) {
        timesList.add(TimesModel.fromMap(map));
      });
    }
    var points = 0;
    timesList.forEach((time) {
      print(time.points);
      points += time.points;
    });
    return points;
  }

  deleteTimeInDB(TimesModel timeToDelete) async {
    final db = await database;
    await db.delete('Times', where: '_id = ?', whereArgs: [timeToDelete.id]);
    print('Time deleted');
  }

  Future<TimesModel> addTimeInDB(TimesModel newTime) async {
    final db = await database;
    if (newTime.title.trim().isEmpty) newTime.title = 'Untitled Time';
    await db.transaction((transaction) {
      transaction.rawInsert(
          'INSERT into Times(title, date, points, timeInMinutes) VALUES ("${newTime.title}", "${newTime.date.toIso8601String()}", ${newTime.points}, ${newTime.timeInMinutes});');
    });
    print('Time added: ${newTime.title} ${newTime.timeInMinutes}');
    return newTime;
  }

  void flushDb() async {
    final db = await database;
    db.delete("Times");
  }
}
