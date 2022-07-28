import 'package:restaurant_app/data/model/ui/restaurant.dart';
import 'package:restaurant_app/widgets/restaurant_item.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static DatabaseHelper? _databaseHelper;
  static late Database _database;

  DatabaseHelper._internal() {
    _databaseHelper = this;
  }

  factory DatabaseHelper() => _databaseHelper ?? DatabaseHelper._internal();

  Future<Database> get database async {
    _database = await _initializeDb();
    return _database;
  }

  static const String _tableName = 'favorite';
  static const String columnId = "id";
  static const String columnName = "name";
  static const String columnImage = "image";
  static const String columnRating = "rating";
  static const String columnLocation = "location";

  Future<Database> _initializeDb() async {
    var path = await getDatabasesPath();
    var db = openDatabase(
      "${path}restaurant.db",
      onCreate: (db, version) async {
        await db.execute(
          '''CREATE TABLE $_tableName (
               $columnId TEXT PRIMARY KEY,
               $columnName TEXT,
               $columnImage TEXT,
               $columnRating FLOAT,
               $columnLocation TEXT
             )''',
        );
      },
      version: 1,
    );

    return db;
  }

  Future<int> addToFavorite(RestaurantUiModel restaurant) async {
    final Database db = await database;
    return await db.insert(_tableName, restaurant.toMap());
  }

  Future<List<RestaurantUiModel>> getFavoriteRestaurants() async {
    final Database db = await database;
    List<Map<String, dynamic>> data = await db.query(_tableName);
    return data.map((e) => RestaurantUiModel.fromMap(e)).toList();
  }

  Future<RestaurantUiModel> getFavoriteRestaurantById(String id) async {
    final Database db = await database;
    List<Map<String, dynamic>> results = await db.query(
      _tableName,
      where: 'id = ?',
      whereArgs: [id],
    );

    return results.map((res) => RestaurantUiModel.fromMap(res)).first;
  }

  Future<bool> isFavoriteRestaurant(String id) async {
    try {
      await getFavoriteRestaurantById(id);
      return true;
    } on StateError {
      return false;
    }
  }

  Future<int> removeFavorite(String id) async {
    final Database db = await database;
    return await db.delete(
      _tableName,
      where: "$columnId = ?",
      whereArgs: [id],
    );
  }
}
