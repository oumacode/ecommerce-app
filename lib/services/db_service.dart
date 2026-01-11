import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbService {
  Future<Database> initDB() async {
    final path = join(await getDatabasesPath(), 'favorites.db');
    return openDatabase(
      path,
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE favorites(id INTEGER PRIMARY KEY AUTOINCREMENT,nom TEXT,price REAL)'
        );
      },
      version: 1,
    );
  }

  Future<void> addFavorite(String nom, int price) async {
    final db = await initDB();

    await db.insert('favorites',{'nom': nom,'price': price,},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<Map<String, dynamic>>> getFavorites() async {
    final db = await initDB();
    return db.query('favorites');
  }

  Future<void> deleteFavorite(int id) async {
    final db = await initDB();
    await db.delete('favorites', where: 'id=?', whereArgs: [id]);
  }
}
