import 'package:restaurant_app/data/model/detail_model.dart';
import 'package:restaurant_app/data/model/favorite_model.dart';

import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static DatabaseService? _instance;
  static Database? _database;

  DatabaseService._internal() {
    _instance = this;
  }

  factory DatabaseService() => _instance ?? DatabaseService._internal();

  static const String _favoriteList = 'favorite';

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      "$path/restaurantapp.db",
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_favoriteList (
             id TEXT PRIMARY KEY,
             name TEXT,
             city TEXT,
             description TEXT,
             pictureId TEXT,
             rating DOUBLE
           )     
        ''');
      },
      version: 1,
    );
    return db;
  }

  Future<Database?> get database async {
    _database ??= await _initializeDb();
    return _database;
  }

  Future<void> insertFavorite(RestaurantDetail restaurant) async {
    final db = await database;
    var value = {
      'id': restaurant.id,
      'name': restaurant.name,
      'city': restaurant.city,
      'description': restaurant.description,
      'pictureId': restaurant.pictureId,
      'rating': restaurant.rating.toString(),
    };
    await db!.insert(_favoriteList, value);
  }

  Future<List<RestaurantFavorit>> getFavorite() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_favoriteList);

    return results.map((e) => RestaurantFavorit.fromDb(e)).toList();
  }

  Future<Map> getFavoriteById(String id) async {
    final db = await database;

    List<Map<String, dynamic>> results =
        await db!.query(_favoriteList, where: 'id = ?', whereArgs: [id]);

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  Future<void> removeFavorite(String id) async {
    final db = await database;

    await db!.delete(_favoriteList, where: 'id = ?', whereArgs: [id]);
  }
}
