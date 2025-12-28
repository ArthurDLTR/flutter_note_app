import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_note_app/Note.class.dart';
import 'package:sqflite/sqflite.dart';

class DB {
  static DB? _db;
  static Database? _database;
  DB._createInstance();

  factory DB() {
    _db ??= DB._createInstance();
    return _db!;
  }

  Future<Database> get database async {
    _database ??= await initializeDatabase();
    return _database!;
  }

  Future<Database> initializeDatabase() async {
    Directory dir = await getApplicationDocumentsDirectory();
    String path = '${dir.path}/notes_database.db';
    // print(path);
    var noteDb = openDatabase(path, version: 1, onCreate: (db, version) {return db.execute('CREATE TABLE notes (id PRIMARY KEY, titre TEXT, contenu TEXT)');});
    return noteDb;
  }

  Future<List<Note>> getNotes() async {
    final db = await database;

    final List<Map<String, Object?>> notesMap = await db.query('notes');

    return [
      for (final {'id': id as int, 'titre': titre as String, 'contenu': contenu as String} in notesMap)
        Note(id: id, titre: titre, contenu: contenu),
    ];
  }

  int getNotesLength(){
    int length = 0;

    getLength().then((value) {
      length = value;
    });

    return length;
  }

  Future<int> getLength() async {
    return await getNotes().then((value) {
      return value.length;
    });
  }

  Future<void> insertNote(Note n) async {
    final db = await database;

    await db.insert(
      'notes',
      n.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> updateNote(Note n) async {
    final db = await database;

    await db.update(
      'notes',
      n.toMap(),
      where: 'id = ?',
      whereArgs: [n.id]
    );
  }

  Future<void> deleteNote(int id) async{
    final db = await database;

    await db.delete(
      'notes',
      where: 'id = ?',
      whereArgs: [id]
    );
  }
}