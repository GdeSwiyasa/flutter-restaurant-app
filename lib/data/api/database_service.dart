import 'package:restaurant_app/data/model/detail_model.dart';
import 'package:restaurant_app/data/model/favorit_model.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static DatabaseService? _instance;
  static Database? _database;

  DatabaseService._internal() {
    _instance = this;
  }

  factory DatabaseService() => _instance ?? DatabaseService._internal();

  static const String _favoritList = 'favorit';

  // Future<Database?> get database async => _database ??= await _initializeDb();

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      "$path/restoranapp.db",
      onCreate: (db, version) async {
        await db.execute('''CREATE TABLE $_favoritList (
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

  Future<void> insertFavorit(RestaurantDetail restaurant) async {
    final db = await database;
    var value = {
      'id': restaurant.id,
      'name': restaurant.name,
      'city': restaurant.city,
      'description': restaurant.description,
      'pictureId': restaurant.pictureId,
      'rating': restaurant.rating.toString(),
    };
    await db!.insert(_favoritList, value);
  }

  Future<List<RestaurantFavorit>> getFavorite() async {
    final db = await database;
    List<Map<String, dynamic>> results = await db!.query(_favoritList);

    return results.map((e) => RestaurantFavorit.fromDb(e)).toList();
  }

  Future<Map> getFavoriteById(String id) async {
    final db = await database;

    List<Map<String, dynamic>> results =
        await db!.query(_favoritList, where: 'id = ?', whereArgs: [id]);

    if (results.isNotEmpty) {
      return results.first;
    } else {
      return {};
    }
  }

  Future<void> removeFavorite(String id) async {
    final db = await database;

    await db!.delete(_favoritList, where: 'id = ?', whereArgs: [id]);
  }
}
