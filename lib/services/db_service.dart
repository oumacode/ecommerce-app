import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DBService {
  static Database? _db;

  // Ouvrir / créer la base
  static Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await _initDB();
    return _db!;
  }

  static Future<Database> _initDB() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'favorites.db');

    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute("""
        CREATE TABLE favorites (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          name TEXT,
          price REAL
        )
        """);
      },
    );
  }

  // Ajouter un favori
  static Future<void> addFavorite(String name, double price) async {
    final db = await database;
    await db.insert('favorites', {
      "name": name,
      "price": price
    });
  }

  // Supprimer un favori
  static Future<void> deleteFavorite(int id) async {
    final db = await database;
    await db.delete('favorites', where: 'id = ?', whereArgs: [id]);
  }

  // Obtenir tous les favoris
  static Future<List<Map<String, dynamic>>> getFavorites() async {
    final db = await database;
    return await db.query('favorites');
  }
}
