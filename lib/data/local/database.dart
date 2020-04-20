import 'dart:io';

import 'package:movie/data/dto/genre.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';

final String tableGenre = 'genres';
final String id = 'id';
final String name = 'name';

class DatabaseHelper {
  static final _databaseName = "movie.db";
  static final _databaseVersion = 1;

  DatabaseHelper._privateConstructor();

  static final DatabaseHelper instance = DatabaseHelper._privateConstructor();

  static Database _database;

  Future<Database> get database async {
    if (_database != null) {
      return _database;
    }
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, _databaseName);
    return await openDatabase(path,
        version: _databaseVersion, onCreate: _onCreate);
  }

  Future _onCreate(Database db, int version) async {
    await db.execute(
        '''create table $tableGenre ($id INTEGER, $name TEXT NOT NULL)''');
  }


  Future<int> insert(Genre genre) async {
    Database db = await database;
    return await db.insert(tableGenre, genre.toMap());
  }

  Future<Genre> getGenre(int genreId) async {
    Database db = await database;
    List<Map> maps = await db.query(tableGenre,
        columns: [id, name], where: '$id = ?', whereArgs: [genreId]);
    return maps.length > 0 ? Genre.fromMap(maps.first) : null;
  }
}
