import 'package:path/path.dart';
import 'package:flutter_note_app/Note.class.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart';

class DB {
  static const String _file = 'notes_databases.db';
  static const String _table = 'notes';
  static const String _titleColumnName = 'titre';
  static const String _contentColumnName = 'contenu';

  DB();

  DB._internal(){
    if (_database == null) database;
  }

  static final DB instance = DB._internal();

  DatabaseFactory databaseFactory = databaseFactoryFfi;

  Database? _database;

  Future<Database> get database async{
    if (_database != null) return _database!;
    _database = await open();
    return _database!;
  }

  Future<Database> open() async {
    return await databaseFactory.openDatabase(
      join(await databaseFactory.getDatabasesPath(), _file),
      options: OpenDatabaseOptions(
        onCreate: (db, version) {
          return db.execute('CREATE TABLE $_table(id INTEGER PRIMARY KEY AUTOINCREMENT, $_titleColumnName TEXT, $_contentColumnName TEXT)');
        },
        version: 1,
      )
    );
  }


  Future<void> close() async {
    await _database!.close();
    _database = null;
  }

  // static DB? _db;
  // DB._createInstance();

  // factory DB() {
  //   _db ??= DB._createInstance();
  //   return _db!;
  // }

  // Future<Database> get database async {
  //   _database ??= await initializeDatabase();
  //   return _database!;
  // }

  // Future<Database> initializeDatabase() async {
  //   // Directory dir = await getApplicationDocumentsDirectory();
  //   // String path = '${dir.path}\notes_database.db';
  //   // print(path);
  //   // var noteDb = await openDatabase(path, version: 1, onCreate: (db, version) {return db.execute('CREATE TABLE notes (id PRIMARY KEY, titre TEXT, contenu TEXT)');});
  //   // return noteDb;
  //   final database = openDatabase(
  //     join(await getDatabasesPath(), 'notes_databases.db'),
  //     onCreate: (db, version) => {
  //       return db.execute(
  //         'CREATE TABLE'
  //       )
  //     },
  //   );
  // }

  Future<List<Note>> getNotes() async {
    final entries = await _database!.query(
      _table,
      columns: ['id', _titleColumnName, _contentColumnName],
    );
    final list = entries.map(
      (e) => Note.complete(e['id'] as int, e[_titleColumnName] as String, e[_contentColumnName] as String)
    ).toList();
    return list;
    // final db = await database;

    // final List<Map<String, Object?>> notesMap = await db.query('notes');

    // return [
    //   for (final {'id': id as int, 'titre': titre as String, 'contenu': contenu as String} in notesMap)
    //     Note(id: id, titre: titre, contenu: contenu),
    // ];
  }

  Future<List<Map>> getNumber() async {
    List<Map> result = await _database!.rawQuery('SELECT * FROM notes');
    // result.forEach((row) => print(row));
    return result;
    // print(result[0]["COUNT(id)"]);
    // return result[0]["COUNT(id)"];
  }

  int getNumberOfNotes() {
    int length = 0;
    // getNumber().then((value) => length = value);
    return length;
  }

  Future<void> insertNote(String title, String content) async {
    try {
      print("Insertion dans la table");
      await _database!.insert(_table, {
        _titleColumnName: title,
        _contentColumnName: content
      });
      // for (Note n in await getNotes()){
      //   print(n.toMap());
      // }

    } on Exception catch (e) {
      print(e);
    }
    // final db = await database;

    // await db.insert(
    //   'notes',
    //   n.toMap(),
    //   conflictAlgorithm: ConflictAlgorithm.replace,
    // );
  }

  Future<void> updateNote(Note n) async {
    await _database!.update(
      _table,
      n.toMap(),
      where: 'id = ?',
      whereArgs: [n.id]
    );
  }

  Future<void> deleteNote(int id) async{
    await _database!.delete(
      _table,
      where: 'id = ?',
      whereArgs: [id]
    );
  }
}