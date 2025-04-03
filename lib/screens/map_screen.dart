import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '/models/location.dart';

class MapService {
  static Database? _database;

  static Future<Database> get _db async {
    if (_database != null) return _database!;
    _database = await openDatabase(
      join(await getDatabasesPath(), 'locations.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE locations(id TEXT PRIMARY KEY, name TEXT, description TEXT, latitude REAL, longitude REAL)',
        );
      },
      version: 1,
    );
    return _database!;
  }

  static Future<void> insertLocation(Location location) async {
    final db = await _db;
    await db.insert(
      'locations',
      location.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Location>> getLocations() async {
    final db = await _db;
    final List<Map<String, dynamic>> maps = await db.query('locations');
    return List.generate(maps.length, (i) {
      return Location(
        id: maps[i]['id'],
        name: maps[i]['name'],
        description: maps[i]['description'],
        latitude: maps[i]['latitude'],
        longitude: maps[i]['longitude'],
      );
    });
  }
}
