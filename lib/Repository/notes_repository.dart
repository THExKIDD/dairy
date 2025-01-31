import 'dart:async';

import 'package:diary/models/note.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class NotesRepository {
  static const _dbName = 'notes_database.db';
  static const _tableName = 'notes';

  static Future<Database> _database() async {
    final database = openDatabase(
      join(await getDatabasesPath(), _dbName),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE $_tableName(id INTEGER PRIMARY KEY, title TEXT, description TEXT, createdAt TEXT)',
        );
      },
      version: 1,
    );
    return database;
  }

  static Future<List<Note>?> insert({required Note note}) async {
    final db = await _database();
    print('insertinggggggggggggggggggggggggggggggggggggggggggggggggggggggg');

    await db.insert(
      _tableName,
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
    return null;
  }

  static Future<List<Note>> getNotes() async {
    final db = await _database();

    final List<Map<String, dynamic>> maps = await db.query(_tableName);

    if (maps.isEmpty) {
      return []; // Return an empty list if the database query returns an empty list
    } else {
      return List.generate(maps.length, (i) {
        return Note(
          id: maps[i]['id'] as int,
          title: maps[i]['title'] as String,
          description: maps[i]['description'] as String,
          createdAt: DateTime.parse(maps[i]['createdAt'] as String),
        );
      });
    }
  }

  static update({required Note note}) async {

    final db = await _database();

    // Update the given Dog.
    await db.update(
      _tableName,
      note.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [note.id],
    );
  }

  static delete({required Note note}) async
  {
    final db = await _database();

    // Remove the Dog from the database.
    await db.delete(
      _tableName,
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [note.id],
    );
  }
}

//
// import 'dart:io';
//
// import 'package:diary/models/note.dart';
// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';
// import 'package:path_provider/path_provider.dart';
//
// class DBhelper {
//   static const dbName = 'MyDatabase';
//   static const dbVersion = 1;
//   static const dbTable = 'MyTable';
//
//
// static final DBhelper instance = DBhelper();
//
// static Database? _database;
//
// Future<Database?> get database async{
//
//   _database ??= await initDB();
//   return _database;
//   /*if(_database != null) return _database;
//
//   _database= await initDB();
//   return _database;*/
// }
//
// initDB() async
// {
//   Directory directory = await getApplicationDocumentsDirectory();
//   String path = join(directory.path, dbName);
//   return await openDatabase(path, version: dbVersion, onCreate: onCreate);
// }
//
// Future onCreate(Database db, int Version) async
// {
//   db.execute(
//     '''
//     CREATE TABLE $dbTable (
//     id INTEGER PRIMARY KEY,
//     Title TEXT,
//     Description TEXT,
//     CreatedAt TEXT
//
//
//     )
//
//
//
//
//     '''
//   );
// }
//
//
// insertRecord({required Note note}) async
// {
//   Database? db = await instance.database;
//   return await db!.insert(dbTable, note.toMap(), conflictAlgorithm: ConflictAlgorithm.replace,);
//
//
// }
//
//   static Future<List<Note>> getNotes() async {
//      Database? db = await instance.database;
//
//     final List<Map<String, dynamic>> maps = await db!.query(dbTable);
//
//      return List.generate(maps.length, (i) {
//       return Note(
//          id: maps[i]['id'] as int,
//          title: maps[i]['title'] as String,
//          description: maps[i]['description'] as String,
//          createdAt: DateTime.parse(maps[i]['createdAt'] as String),
//        );
//      });
//    }
//
// Future<int> updateRecord({required Note note}) async
// {
//   Database? db = await instance.database;
//   return db!.update(dbTable, note.toMap(), where: 'id = ?', whereArgs: [note.id]);
//
// }
//
//
// Future<int> deleteRecord({required Note note}) async
// {
//   Database? db = await instance.database;
//   return await db!.delete(dbTable, where: 'id = ?', whereArgs: [note.id]);
// }
// }