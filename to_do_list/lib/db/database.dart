import 'dart:io';

import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

import '../model/task.dart';

class DBProvider {
  DBProvider._();
  static final DBProvider db = DBProvider._();
  static Database? _database;
  String tasksTable = 'Tasks';
  String columnId = 'id';
  String columnTitle = 'title';
  String columnDescr = 'descr';
  String columnDate = 'date';
  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = dir.path + 'task.db';
    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  void _createDB(Database db, int version) async {
    await db.execute(
        'CREATE TABLE $tasksTable($columnId INTEGER PRIMARY KEY AUTOINCREMENT,$columnTitle TEXT, $columnDescr TEXT, $columnDate TEXT)');
  }

  Future<List<Map<String, dynamic>>> getTaskMapList() async {
    Database db = await database;
    var result = await db.query(tasksTable, orderBy: '$columnTitle ASC');
    return result;
  }

  //INSERT
  Future<int> insertTask(Task task) async {
    Database db = await database;
    var result = await db.insert(tasksTable, task.toMap());
    return result;
  }

  //UPDATE
  Future<int> updateTask(Task task) async {
    Database db = await database;
    var result = await db.update(tasksTable, task.toMap(),
        where: '$columnId = ?', whereArgs: [task.id]);
    return result;
  }

  //DELETE
  Future<int> deleteTask(int id) async {
    Database db = await database;
    var result = db.rawDelete('DELETE FROM $tasksTable WHERE $columnId = $id');
    return result;
  }

  //LENGTH OF TASKS
  Future<int> getLength() async {
    Database db = await database;
    List<Map<String, dynamic>> x =
        await db.rawQuery('SELECT COUNT (*) from $tasksTable');
    int result = Sqflite.firstIntValue(x) ?? 0;
    return result;
  }

  //GET THE MAP LIST {List<Map>} and convert it to task list List<Task>
  Future<List<Task>> getTaskList() async {
    var taskMapList = await getTaskMapList();
    List<Task> taskList = [];
    for (int i = 0; i < taskMapList.length; i++) {
      taskList.add(Task.fromMap(taskMapList[i]));
    }
    return taskList;
  }
}
