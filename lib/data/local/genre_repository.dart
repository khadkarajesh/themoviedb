import 'package:movie/data/dto/genre.dart';
import 'package:sqflite/sqflite.dart';

import 'database.dart';

class GenreRepository {
  Future<Database> database;

  GenreRepository({this.database});

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

  Future<int> getCount() async {
    Database db = await database;
    var rows = await db.rawQuery('SELECT COUNT(*) FROM $tableGenre');
    int total = Sqflite.firstIntValue(rows);
    return total;
  }
}
